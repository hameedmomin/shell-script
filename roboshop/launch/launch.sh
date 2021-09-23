#!/bin/bash

COMPONENT=$1

# -z validating

if [ -z "${COMPONENT}" ]; then
  echo "Component Input is Needed"
  exit 1
fi

LID=lt-0b970bef7d9f13f52
LVER=1

#validate if instance is already there

INSTANCE_CREATE(){

INSTANCE_STATE=$(aws ec2 describe-instance --filters "Name=tag:Name,Values=${COMPONENT}" | jq.Reservations[].Instance[].State.Name | xargs -n1)

echo -n Instance ${COMPONENT} created - IPADDRESS IS

aws ec2 run-instances --launch-template LaunchTemplateId=${LID},Version=${LVER}  --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=${COMPONENT}}]" | jq | grep  PrivateIpAddress  |xargs -n1
sleep 30

DNS_UPDATE
if [ "${INSTANCE_STATE}" = "running" ]; then
  echo "Instance already exist"
  DNS_UPDATE
  return 0
fi

if [ "${INSTANCE_STATE}" = "stopped" ]; then
  echo "${COMPONENT} Instance already exit"
  retrun 0
fi
  }

