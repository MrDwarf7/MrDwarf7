#!/bin/env bash

pandoc --pdf-engine=typst ./README.template.typ -o README.md
