#!/usr/bin/env bash

# pip install localstack awscli-local
# SERVICES=sqs,dynamodb,ses DEFAULT_REGION=eu-west-1 localstack start

awslocal sqs create-queue --queue-name integration-brig-events-internal
awslocal sqs create-queue --queue-name integration-brig-userkey-blacklist
awslocal sqs create-queue --queue-name integration-gundeck-events
awslocal sqs create-queue --queue-name integration-brig-events
awslocal dynamodb create-table --table-name local-brig-userkey-blacklist --attribute-definitions AttributeName=key,AttributeType=S --key-schema AttributeName=key,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
awslocal dynamodb create-table --table-name local-brig-prekeys --attribute-definitions AttributeName=client,AttributeType=S --key-schema AttributeName=client,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
#   "QueueUrl": "http://localhost:4576/queue/integration-brig-events"
