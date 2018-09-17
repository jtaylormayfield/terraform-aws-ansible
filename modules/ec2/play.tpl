#!/bin/bash

set -e

command -v git >/dev/null 2>&1 || { echo >&2 "Git is not installed. Aborting."; exit 1; }
command -v ansible-playbook >/dev/null 2>&1 || { echo >&2 "Ansible is not installed. Aborting."; exit 1; }

# Git clone all repositories simultaneously
${git_cmds}

wait

# Run playbooks sequentially
${play_cmds}
