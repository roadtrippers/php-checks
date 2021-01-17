#!/bin/bash

## don't use set -e
## lint all the files

DIRECTORY=${1:-./}

check_usage(){
    if [ ! -d "${DIRECTORY}" ]; then
	echo "${DIRECTORY} is not a directory"
	exit 2
    fi
}

main(){
    FILES_THAT_FAILED=()
    HAS_ERROR=0

    while IFS= read -r -d '' f
    do
	if ! php --syntax-check "${f}"; then
            echo "ERROR: $f has linting issues"
            FILES_THAT_FAILED+=("${f}")
            HAS_ERROR=1
	fi
    done <   <(find "${DIRECTORY}" -type f -name '*.php'  -print0)
    
    if [ "${HAS_ERROR}" == "1" ]; then
	echo "The following file(s) have linting issues:"
	for v in "${FILES_THAT_FAILED[@]}"; do
            echo "  ${v}"
	done
    else
	echo "All php files under ${DIRECTORY} passed linting"
    fi

    exit ${HAS_ERROR}
}

check_usage
main
