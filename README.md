# GitHub Action for Assignee to Reviewer

If your team currently uses pull request Assignees but would like to switch to  [Review Requests](https://blog.github.com/2016-12-07-introducing-review-requests/), having everyone change their workflows can be difficult. This GitHub Action eases the transition by automatically creating and removing review requests based on Assignees.

## Usage

This Action is used by subscribing to [Issues events](https://developer.github.com/v3/activity/events/types/#issuesevent) which are triggered whenever Assigness are added or removed.

```workflow
workflow "Assign reviewers based on assignees" {
  on = "pull_request"
  resolves = ["Assignee to reviewer"]
}

action "Assignee to reviewer" {
  uses = "pullreminders/assignee-to-reviewer-action@master"
  secrets = [
    "GITHUB_TOKEN"
  ]
}
```

## Demo

<img src="https://github.com/pullreminders/assignee-to-reviewer-action/raw/master/docs/images/example.png" width="540">

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).