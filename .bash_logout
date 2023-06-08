#!/usr/bin/env bash

if [ "${SSH_AUTH_SOCK}" ] ; then
  eval `ssh-agent -k`
fi

type -P gpgconf >/dev/null && gpgconf --kill gpg-agent

clear
