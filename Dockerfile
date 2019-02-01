FROM alpine:3.9

LABEL "com.github.actions.name"="Assignee to reviewer"
LABEL "com.github.actions.description"="Automatically create review requests based on assignees"
LABEL "com.github.actions.icon"="arrow-up-right"
LABEL "com.github.actions.color"="gray-dark"

LABEL version="2.0.0"
LABEL repository="http://github.com/pullreminders/assignee-to-reviewer-action"
LABEL homepage="http://github.com/pullreminders/assignee-to-reviewer-action"
LABEL maintainer="Abi Noda <abi@pullreminders.com>"

RUN apk add --update \
  curl \
  jq

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/ash", "/entrypoint.sh"]
