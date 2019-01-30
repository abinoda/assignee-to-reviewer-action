FROM debian:9.6-slim

LABEL "com.github.actions.name"="GitHub Action for Assignee to Reviewer"
LABEL "com.github.actions.description"="Create review requests based on assignees."
LABEL "com.github.actions.icon"="arrow-up-right"
LABEL "com.github.actions.color"="white"

LABEL version="1.0.0"
LABEL repository="http://github.com/pullreminders/assignee-to-reviewer-action"
LABEL homepage="http://github.com/pullreminders/assignee-to-reviewer-action"
LABEL maintainer="Abi Noda <abi@pullreminders.com>"

RUN apt-get update && apt-get install -y \
    curl \
    jq

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
