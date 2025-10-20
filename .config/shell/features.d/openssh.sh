#!/bin/sh
mkdir -p "$HOME/.ssh/cm_socket" "$HOME/.cache"
export KRB5CCNAME="DIR:${HOME}/.cache/krb5cc"
