#!/bin/env bash

SCRIPTS_DIR=$(dirname "$(realpath "$0")")
SCRIPTS_PARENT_DIR=$(dirname "${SCRIPTS_DIR}")

cd "${SCRIPTS_PARENT_DIR}" || return 1

pandoc --pdf-engine=typst \
  ./README.template.typ \
  -o README.md

declare content

content=$(cat ./README.md)

trimmed_content=$(echo "${content}" | tr -d '`')

MARKER="@@GH_HTML@@"

# strip marker
trimmed_content=$(echo "${trimmed_content}" | sed "s/${MARKER}//g")

echo "${trimmed_content}" >README.md
