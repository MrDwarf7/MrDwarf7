#!/bin/env bash

CURRENT_DIR=$(dirname "$(realpath "$0")")
# CALLED_FROM=$(pwd)
# ROOT_DIR=${CURRENT_DIR}/..

ROOT_DIR=$(realpath "${CURRENT_DIR}/..")

## To pull them down locally (for Typst)
# wget https://github-readme-stats.vercel.app/api?username=mrdwarf7&show_icons=true&theme=dark#gh-dark-mode-only -o ./cards/stats.svg
# wget "https://github-readme-stats.vercel.app/api/top-langs/?username=mrdwarf7&theme=dark&layout=compact&hide=powershell,lua#gh-dark-mode-only" -o ./cards/top-langs.svg

printf "Current directory: %s\n" "${CURRENT_DIR}"
printf "Root directory: %s\n" "${ROOT_DIR}"

pandoc --pdf-engine=typst "${ROOT_DIR}/README.template.typ" -o "${ROOT_DIR}/README.md"
data=$(cat "${ROOT_DIR}/README.md")
echo "$data" | tr -d '`' | cat - | tee >"${ROOT_DIR}/README.md"
