#!/bin/sh

if [ -z "${MY_PKGSRC:-}" ]; then
	for pfx in "$HOME/opt/pkg-2025Q2/" "$HOME/opt/pkg-2025Q3" "$HOME/opt/pkg-2025Q4" "$HOME/opt/pkg-2026Q1"; do
		if [ -d "${pfx}/bin" ] && [ -d "${pfx}/sbin" ]; then
			MY_PKGSRC=$(readlink -f "${pfx}")
			export MY_PKGSRC
		fi
	done
fi

if [ -n "${MY_PKGSRC:-}" ] && [ -d "${MY_PKGSRC}" ]; then
	[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"
	_prepend_path "${MY_PKGSRC}/bin"
	_prepend_path "${MY_PKGSRC}/sbin"
fi
