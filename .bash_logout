# /etc/skel/.bash_logout

# This file is sourced when a login shell terminates.

# Kill the gpg-agent
if [ -n "${GPG_AGENT_INFO}" ]; then
	kill $(echo ${GPG_AGENT_INFO} | cut -d':' -f 2) > /dev/null 2>&1
fi

# Clear the screen for security's sake.
clear
