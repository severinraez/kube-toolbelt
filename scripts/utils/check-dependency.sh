#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: check-dependency.sh binary-name"
    exit 2;
fi

binary=$1

which $binary > /dev/null;

not_available=$?

if (( $not_available == 1 )); then
    echo "I need the binary '$binary', please install the corresponding package and/or make sure it's in your path."

    exit 1;
else
    exit 0;
fi

