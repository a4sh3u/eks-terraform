#!/bin/bash

for asg in $(terraform output -json workers_asg_names | jq -r .value[]); do
  for instance in $(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name ${asg} | jq -r .AutoScalingGroups[].Instances[].InstanceId); do
    #echo $instance
    public_ip=$(aws ec2 describe-instances --instance-ids ${instance} | jq -r .Reservations[].Instances[].PublicIpAddress)
    if [ ${public_ip} != "null" ]; then
      echo "${public_ip}"
    fi
  done
done
