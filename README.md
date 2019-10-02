# Assign reviewers based on assignees

If your team currently uses pull request assignees but would like to switch to  [Review Requests](https://blog.github.com/2016-12-07-introducing-review-requests/), having everyone change their workflows can be difficult. This GitHub Action eases the transition by automatically creating and deleting review requests based on assignees. This may be particularly helpful when using a 3rd-party app like [Pull Reminders](https://pullreminders.com) that relies on review requests.

## Usage

This Action subscribes to [Pull request events](https://help.github.com/en/articles/events-that-trigger-workflows#pull-request-event-pull_request) specifically the `assigned` and `unassigned` events which fire whenever users are assigned or unassigned to pull requests.

```workflow
name: Assign reviewers based on assignees
on:
  pull_request:
    types: [assigned, unassigned]

jobs:
  assignee_to_reviewer:
    runs-on: ubuntu-latest
    steps:
      - name: Assignee to Reviewer
        uses: pullreminders/assignee-to-reviewer-action@v1.0.4
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

```

Note that the workflow for `pull_request` events will be triggered by default only for `opened`, `synchronize` or `reopened` activity types. For other, events the `types` keyword must be used.

## Demo

<img src="https://github.com/pullreminders/assignee-to-reviewer-action/raw/master/docs/images/example.png" width="540">

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).
