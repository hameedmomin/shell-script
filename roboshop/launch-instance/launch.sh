#!/bin/bash

COMPONENT=$1
# -z validating
if [ -z "${COMPONENT}" ]; then
  echo "Component Input is Needed"
  exit 1
fi

LID=lt-0b970bef7d9f13f52
LVER=1

#validate if instance is already their

DNS_UPDATE(){
  PRIVATEIP=$(aws ec2 describe-instance --filters "Name=tag:Name,Values=${COMPONENT}" | jq.Reservations[].Instance[].PrivateIpAddress | xargs -n1)
  sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${IPADDRESS}/" record.json >/tmp/record.json
  aws route53 change-resource-record-sets --hosted-zone-id Z07567143CWQBG84ZKWAY --change-batch file:///tmp/record.json |jq

}

INSTANCE_STATE=$(aws ec2 describe-instance --filters "Name=tag:Name,Values=${COMPONENT}" | jq.Reservations[].Instance[].State.Name | xargs -n1)
if [ "${INSTANCE_STATE}" = "running" ]; then
  echo "Instance already exist"
  DNS_UPDATE
  exit 0
fi

aws ec2 run-instances --launch-template LaunchTemplateId=${LID},Version=${LVER} --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq
sleep 30
DNS_UPDATE