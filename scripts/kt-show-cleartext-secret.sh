#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Usage: kt-show-cleartext-secret.sh NAMESPACE SECRETNAME"
    exit 2;
fi

# DESCRIPTION
#
# Will show the secret values in cleartext.
#
# KNOWN LIMITATIONS
#
# Cannot handle secrets with multiline values.

set -e

$(dirname $0)/utils/check-dependency.sh jq
$(dirname $0)/utils/check-dependency.sh base64
$(dirname $0)/utils/check-dependency.sh datamash

namespace=$1
secretname=$2

keys_values=$(
    kubectl \
        -n ldap \
        get secret $secretname \
        -o json \
        | jq .data)

# jq: -r to omit "s, -S to have sorted output so both jq commands follow the same order.
keys=$(echo $keys_values | jq -rS  "keys | .[]" | tr '\n' ' ')
values=$(
    echo $keys_values \
        | jq -rS  "values | .[]" \
        | xargs -n1 -I % sh -c "echo % | base64 -d" | tr '\n' ' ')

# Format the output.
echo -e "$keys\n$values" \
    | datamash transpose -W \
    | sed 's/\t/ /g' \
    | sed 's/ /: /g'

