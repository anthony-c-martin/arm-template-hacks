#!/bin/bash

az deployment sub create \
  -f ./main.bicep \
  --location 'East US 2' \
  --name 'aks_test' \
  --parameters \
    dnsPrefix='REPLACEME' \
    linuxAdminUsername='REPLACEME' \
    sshRSAPublicKey='REPLACEME'