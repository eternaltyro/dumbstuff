#!/bin/bash

THRESHOLD=80
SLACK_CHANNEL="#buildops"
SLACK_USERNAME="sentinel"
SLACK_URL="https://hooks.slack.com/services/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"
DF_ALIAS=$(df -x tmpfs -x devtmpfs -x proc -x sysfs -x cgroup --output=pcent | grep -vE '^Use' | sed 's/%//')
DF_EXT4="df --type ext4 --output=pcent | grep -vE '^Use' | sed 's/%//'"
HOSTNAME=$(hostname --fqdn)

function post_to_slack {
    MESSAGE=$*
    curl -X POST \
        --data-urlencode "payload={\"channel\": \"${SLACK_CHANNEL}\", \"username\":
    \"${SLACK_USERNAME}\", \"text\": \"${MESSAGE}\"}" \
        ${SLACK_URL}
}

for value in $DF_ALIAS; do
    if [ $value -ge ${THRESHOLD} ]; then
        post_to_slack "Disk usage critical on ${HOSTNAME}"
        break
    fi
done
