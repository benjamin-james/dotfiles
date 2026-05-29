#!/bin/sh

krb_use_collection() {
	_krb5cc_dir=""

	if [ -n "${XDG_RUNTIME_DIR:-}" ] && [ -d "$XDG_RUNTIME_DIR" ]; then
		_krb5cc_dir="${XDG_RUNTIME_DIR}/krb5cc"
	else
		uid=$(id -u)
		_krb5cc_dir="/tmp/krb5cc_${uid}.d"
		unset uid
	fi

	umask 077

	if [ -e "$_krb5cc_dir" ] && { [ ! -d "$_krb5cc_dir" ] || [ -L "$_krb5cc_dir" ]; }; then
		printf 'Unsafe Kerberos cache path: %s\n' "$_krb5cc_dir" >&2
		return 1
	fi

	mkdir -p "$_krb5cc_dir" || return 1
	chmod 700 "$_krb5cc_dir" || return 1

	KRB5CCNAME="DIR:${_krb5cc_dir}"
	export KRB5CCNAME
	unset _krb5cc_dir
}

if [ -z "${KRB5CCNAME:-}" ]; then
	krb_use_collection
fi
