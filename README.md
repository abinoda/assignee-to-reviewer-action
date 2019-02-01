# Assign reviewers based on assignees

If your team currently uses pull request assignees but would like to switch to  [Review Requests](https://blog.github.com/2016-12-07-introducing-review-requests/), having everyone change their workflows can be difficult. This GitHub Action eases the transition by automatically creating and deleting review requests based on assignees. This may be particularly helpful when using a 3rd-party app like [Pull Reminders](https://pullreminders.com) that relies on review requests.

## Usage

This Action subscribes to [Pull request events](https://developer.github.com/v3/activity/events/types/#pullrequestevent) which fire whenever users are assigned or unassigned to pull requests.

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
