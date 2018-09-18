#!/bin/bash
# Author:       J. Taylor Mayfield
# Email:        justin.mayfield@cgi.com
# Date:         2018-09-18
# Usage:        play.sh
# Description:  Clone Ansible playbook Git repositories and execute them sequentially.

set -e

command -v git >/dev/null 2>&1 || { echo >&2 "Git is not installed. Aborting."; exit 1; }
command -v ansible-playbook >/dev/null 2>&1 || { echo >&2 "Ansible is not installed. Aborting."; exit 1; }

# Git clone all repositories
${git_cmds}

# Wait for clone operations to finish
wait

# Run playbooks
${play_cmds}
