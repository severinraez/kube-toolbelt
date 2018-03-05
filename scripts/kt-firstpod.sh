#!/bin/bash

namespace=$1
deployment=$2

if [[ $# -ne 2 ]]; then
    echo "Usage: NAMESPACE DEPLOYMENT"
    echo "Print the first pod of the deployment NAMESPACE/DEPLOYMENT."
    exit -1
fi

set -e

# Get all pod names
kubectl -n $namespace get pod -o=jsonpath='
  {range .items[*]}
    {.metadata.name}
    {"\n"}
  {end}
' |\
    # , remove clutter suffered
    # from indenting the jsonpath template above
    tr -d ' ' |\
    grep -v '^$' |\
    # , return the first pod of the deployment.
    grep -E "^$deployment-\w{10}-\w{5}" |\
    head -1
