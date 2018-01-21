#!/bin/bash

if [[ $# -ne 3 ]]; then
    echo "Usage: kt-generate-user-credentials.sh NAMESPACE SECRETNAME USERNAME"
    exit 2;
fi

# DESCRIPTION
#
# Will generate the secret SECRETNAME with the following keys:
# * user, set to the USERNAME given
# * password, a generated 32 character password

set -e

$(dirname $0)/utils/check-dependency.sh mktemp
$(dirname $0)/utils/check-dependency.sh pwgen


namespace=$1
secretname=$2
username=$3

username_file=$(mktemp)
password_file=$(mktemp)

function cleanup {
    rm $username_file
    rm $password_file
}
trap cleanup EXIT

echo -n $username > $username_file
pwgen 32 1 | xargs echo -n > $password_file

(
    set -x
    kubectl \
        -n $namespace\
        create secret generic $secretname \
        --from-file=user=$username_file \
        --from-file=password=$password_file
)
