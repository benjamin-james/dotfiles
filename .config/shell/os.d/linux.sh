#!/bin/sh
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"
_prepend_path "$HOME/.local/bin"
mkdir -p "${HOME}/.cache"

if [ -n "${QT_LOGGING_RULES:-}" ]; then
	## KWin script debugging
	QT_LOGGING_RULES="kwin_*.debug=true"
	export QT_LOGGING_RULES
fi
