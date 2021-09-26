#!/bin/bash

COMPONENT=$1

# -z validating

if [ -z "${COMPONENT}" ]; then
  echo "Component Input is Needed"
  exit 1
fi

LID=lt-0b970bef7d9f13f52
LVER=2

## Validating the instance is already there

INSTANCE_CREATE() {
  INSTANCE_STATE=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instance[].State.Name | xargs -n1)

  if [ "${INSTANCE_STATE}" = "Running" ]; then
    echo "Instance already exists"
    exit 0
  fi

  if [ "${INSTANCE_STATE}" = "Stopped" ]; then
    echo "Instance already exists!!"
    exit 0
  fi

}
aws ec2 run-instances --launch-template LaunchTemplateId=${LID},Version=${LVER}  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq
