#!/bin/bash

TF_ACTION="${1}"
TF_ACTION_PLAN="plan"
TF_ACTION_APPLY="apply"
TF_ACTION_DESTROY="destroy"

if [ -e .env ]; then
  . .env
else
  echo "ERROR: .env file not found" >&2
  exit 1
fi

TIMESTAMP=`date +%Y%m%d%H%M%S`
TF_OUTPUT_DIR=tfplan-out

[ ! -d $TF_OUTPUT_DIR ] && mkdir -p $TF_OUTPUT_DIR

terraform init

if [ "${TF_ACTION}" == "${TF_ACTION_PLAN}" ] || [ "${TF_ACTION}" == "${TF_ACTION_APPLY}" ]; then
  terraform plan -input=false -out $TF_OUTPUT_DIR/terraform.tfplan-$TIMESTAMP -var "home_dir=$HOME" -var "account_id=$AWS_ACCOUNT_ID" -var "account_name=$AWS_ACCOUNT_NAME"
fi
if [ "${TF_ACTION}" == "${TF_ACTION_APPLY}" ]; then
  [ -e $TF_OUTPUT_DIR/terraform.tfplan-$TIMESTAMP ] && terraform apply -input=false $TF_OUTPUT_DIR/terraform.tfplan-$TIMESTAMP
elif [ "${TF_ACTION}" == "${TF_ACTION_DESTROY}" ]; then
  terraform destroy -var "home_dir=$HOME" -var "account_id=$AWS_ACCOUNT_ID" -var "account_name=$AWS_ACCOUNT_NAME"
else
  echo -e "\n\tUsage:\n\t\t$0 [ ${TF_ACTION_PLAN} | ${TF_ACTION_APPLY} | ${TF_ACTION_DESTROY} ]\n"
fi
