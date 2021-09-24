#!/bin/bash

COMPONENT=$1

# -z validating

if [ -z "${COMPONENT}" ]; then
  echo "Component Input is Needed"
  exit 1
fi

LID=lt-0b970bef7d9f13f52
LVER=1

## Validating the instance is already there

INSTANCE_STATE=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instance[].State.Name | xargs -n1)

if [ "${INSTANCE_STATE}" = "running" ]; then
  echo "Instance already exist"
  return 0
fi

if [ "${INSTANCE_STATE}" = "stopped" ]; then
  echo "${COMPONENT} Instance already exit"
  return 0
fi

aws ec2 run-instances --launch-template LaunchTemplateId=${LID},Version=${LVER}  --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=${COMPONENT}}]" | jq