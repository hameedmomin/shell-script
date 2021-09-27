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

DNS_UPDATE() {
  PRIVATEIP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].PrivateIpAddress | xargs -n1)
  sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${PRIVATEIP}/" record.json >/tmp/record.json
  aws route53 change-resource-record-sets --hosted-zone-id Z05483541JD3IOXLSP16I --change-batch file:///tmp/record.json | jq
}

INSTANCE_STATE=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].State.Name | xargs -n1)

if [ "${INSTANCE_STATE}" = "running" ]; then
  echo "Instance already exists"
  DNS_UPDATE
  exit 0
fi

if [ "${INSTANCE_STATE}" = "stopped" ]; then
  echo "Instance already exists!!"
  exit 0
fi

aws ec2 run-instances --launch-template LaunchTemplateId=${LID},Version=${LVER}  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq
sleep 30
DNS_UPDATE

