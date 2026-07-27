#!/usr/bin/env bash
# typst -> markdown pipeline for the GitHub profile README.
#
# Uses -t gfm so pandoc emits clean ![](url) image syntax for remote URLs
# (the default markdown writer rewrites remote image() URLs to broken local
# paths). The gh-html.lua filter converts sentinel-tagged raw() strings
# (badges, stat <img>, skyline) into raw HTML so they pass through untouched.
set -euo pipefail

SCRIPTS_DIR=$(dirname "$(realpath "$0")")
SCRIPTS_PARENT_DIR=$(dirname "${SCRIPTS_DIR}")

cd "${SCRIPTS_PARENT_DIR}"

pandoc \
  --pdf-engine=typst \
  --from typst \
  --to gfm \
  --lua-filter="${SCRIPTS_DIR}/gh-html.lua" \
  README.template.typ \
  -o README.md
