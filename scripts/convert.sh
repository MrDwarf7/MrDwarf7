#!/bin/env bash

# CURRENT_DIR=$(dirname "$(realpath "$0")")
SCRIPTS_DIR=$(dirname "$(realpath "$0")")
SCRIPTS_PARENT_DIR=$(dirname "${SCRIPTS_DIR}")

## To pull them down locally (for Typst)
# wget https://github-readme-stats.vercel.app/api?username=mrdwarf7&show_icons=true&theme=dark#gh-dark-mode-only -o ./cards/stats.svg
# wget "https://github-readme-stats.vercel.app/api/top-langs/?username=mrdwarf7&theme=dark&layout=compact&hide=powershell,lua#gh-dark-mode-only" -o ./cards/top-langs.svg

printf "Current directory: %s\n" "${SCRIPTS_DIR}"
printf "Parent directory: %s\n" "${SCRIPTS_PARENT_DIR}"

pandoc --pdf-engine=typst "${SCRIPTS_PARENT_DIR}/README.template.typ" -o "${SCRIPTS_PARENT_DIR}/README.md"

data=$(cat "${SCRIPTS_PARENT_DIR}/README.md")
echo "$data" | tr -d '`' | cat - | tee >"${SCRIPTS_PARENT_DIR}/README.md"
