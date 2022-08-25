#!/bin/bash -e

sudo() { "$@" ; }

echo "# ----------------------------------------------------------"
echo "# Create the Snapshot for: ${1}"
echo "# ----------------------------------------------------------"
echo "ENV_RUNNER_TEMP:    ${ENV_RUNNER_TEMP}"
echo "ENV_SNAPSHOT:       ${ENV_SNAPSHOT}"
echo "ENV_EXCLUDE:        ${ENV_EXCLUDE}"
echo "Parameter #1:       ${1}"

FIND_INIT="sudo find"
FIND_INIT="${FIND_INIT} ${ENV_SNAPSHOT}"
FIND_INIT="${FIND_INIT} -type f,l"
EXCLUDED=("${ENV_EXCLUDE}")

FIND_EXCLUDE=" -not \( -path \"${ENV_RUNNER_TEMP}*\" -prune \)"
for EXCLUDE in ${EXCLUDED[*]}; do
  echo "EXCLUDE: ${EXCLUDE}"
  FIND_EXCLUDE="${FIND_EXCLUDE} -not \( -path \"${EXCLUDE}*\" -prune \)"
done

FIND_END=" > ${ENV_RUNNER_TEMP}/${1}"
FIND_END="${FIND_END} 2> /dev/null || true"

FIND="${FIND_INIT}${FIND_EXCLUDE}${FIND_END}"

echo "----------------------------------------"
echo "FIND: ${FIND}"
echo "----------------------------------------"
eval "${FIND}"

echo "# ----------------------------------------------------------"
