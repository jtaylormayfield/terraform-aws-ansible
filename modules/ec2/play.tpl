#!/bin/bash

set -e

command -v git >/dev/null 2>&1 || { echo >&2 "Git is not installed. Aborting."; exit 1; }
command -v ansible >/dev/null 2>&1 || { echo >&2 "Ansible is not installed. Aborting."; exit 1; }

${join(" & ", git_cmds}

wait

${join(" && ", ansible_cmds}
