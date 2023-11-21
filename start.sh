#!/bin/bash

#$REPOSITORY
#$ACCESS_TOKEN
#$REGISTRATION_TOKEN

if [ -z ${REGISTRATION_TOKEN+x} ]; then 
    echo "Fetching REGISTRATION_TOKEN from Github..."; 
    REGISTRATION_TOKEN=$(curl -X POST -H "Authorization: token ${ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" https://api.github.com/repos/${REPOSITORY}/actions/runners/registration-token | jq .token --raw-output)

else 
    echo "REGISTRATION_TOKEN configured"; 
fi


cd /home/docker/actions-runner

./config.sh --url https://github.com/${REPOSITORY} --token ${REGISTRATION_TOKEN}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REGISTRATION_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
