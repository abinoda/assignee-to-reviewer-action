#!/bin/bash
set -eu

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "Set the GITHUB_TOKEN env variable."
  exit 1
fi

if [[ -z "$GITHUB_EVENT_NAME" ]]; then
  echo "Set the GITHUB_REPOSITORY env variable."
  exit 1
fi

if [[ -z "$GITHUB_EVENT_PATH" ]]; then
  echo "Set the GITHUB_EVENT_PATH env variable."
  exit 1
fi

API_HEADER="Accept: application/vnd.github.v3+json; application/vnd.github.antiope-preview+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

action=$(jq --raw-output .action "$GITHUB_EVENT_PATH")
number=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")
assignee=$(jq --raw-output .assignee.login "$GITHUB_EVENT_PATH")

# Github Actions will mark a check as "neutral" (neither failed/succeeded) when you exit with code 78
# But this will terminate any other Actions running in parallel in the same workflow.
# Configuring this Environment Variable `REVIEWERS_UNMODIFIED_EXIT_CODE=0` if no reviewer was added or deleted.
# Docs: https://developer.github.com/actions/creating-github-actions/accessing-the-runtime-environment/#exit-codes-and-statuses
REVIEWERS_UNMODIFIED_EXIT_CODE=${REVIEWERS_UNMODIFIED_EXIT_CODE:-78}

update_review_request() {
  curl -sSL \
    -H "Content-Type: application/json" \
    -H "${AUTH_HEADER}" \
    -H "${API_HEADER}" \
    -X $1 \
    -d "{\"reviewers\":[\"${assignee}\"]}" \
    "https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/${number}/requested_reviewers"
}

if [[ "$action" == "assigned" ]]; then
  update_review_request 'POST'
elif [[ "$action" == "unassigned" ]]; then
  update_review_request 'DELETE'
else
  echo "Ignoring action ${action}"
  exit "$REVIEWERS_UNMODIFIED_EXIT_CODE"
fi
