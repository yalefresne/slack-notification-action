#!/bin/bash

if [[ -n $INPUT_BRANCH_NAME && ${GITHUB_REF#refs/heads/} != $INPUT_BRANCH_NAME ]]; then
	echo "Job is not running on branch : $INPUT_BRANCH_NAME"
	exit 0
fi

if [[ $INPUT_BUILD_STATUS == "success" && $INPUT_DEPLOY_STATUS == "success" ]]; then
	MESSAGE=":tada: *$GITHUB_REPOSITORY* $GITHUB_WORKFLOW has succeeded!"
elif [[ $INPUT_BUILD_STATUS == "failure" || $INPUT_DEPLOY_STATUS == "failure" ]]; then
	MESSAGE=":warning: *$GITHUB_REPOSITORY* $GITHUB_WORKFLOW has failed!"
fi

LINK="<https://github.com/$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID|Click here> for details"

curl -X POST --data-urlencode "payload={\"channel\": \"#$INPUT_CHANNEL_NAME\", \"username\": \"Github\", \"text\": \"$MESSAGE $LINK\", \"icon_emoji\": \":octocat:\"}" $INPUT_WEBHOOK_SLACK
