#!/bin/sh
<<<<<<< HEAD

_prepend_path "$HOME/opt/pkg-2025Q3/bin"
_prepend_path "$HOME/opt/pkg-2025Q3/sbin"
=======
[ -r "${_DOTBASE}/lib/helpers.sh" ] && . "${_DOTBASE}/lib/helpers.sh"

bootstrap_pkgsrc() {
    REVISION="${1:?need REVISION like 2025Q3}"
    LOCALBASE="$HOME/opt/pkg-$REVISION"
    PKGSRCDIR="$HOME/opt/src/pkgsrc-$REVISION"
    WRKOBJDIR="$HOME/opt/var/obj-$REVISION"
    DISTDIR="$HOME/opt/var/distfiles"
    PACKAGES="$HOME/opt/var/packages/$REVISION"
    PKG_DBDIR="$LOCALBASE/.pkgdb"
    PKG_SYSCONFBASE="$LOCALBASE/etc"
    VARBASE="$HOME/opt/var"
    mkdir -p "$LOCALBASE" "$WRKOBJDIR" "$DISTDIR" "$PACKAGES" "$PKG_DBDIR" \
          "$PKG_SYSCONFBASE" "$VARBASE" || return 1
    MKFRAG=$(mktemp "${TMPDIR:-/tmp}/mkfrag.XXXXXX") || return 1
    cat >"$MKFRAG"<<EOF
LOCALBASE=      $LOCALBASE
PKGSRCDIR=      $PKGSRCDIR
WRKOBJDIR=      $WRKOBJDIR
DISTDIR=        $DISTDIR
PACKAGES=       $PACKAGES
PKG_DBDIR=      $PKG_DBDIR
PKG_SYSCONFBASE=$PKG_SYSCONFBASE
MAKE_JOBS?= \${_MAKE_JOBS_CMD:U$(
  (getconf _NPROCESSORS_ONLN 2>/dev/null) || echo 1
)}
FETCH_USING?= curl
EOF
    BOOTSTRAP_ARGS="--unprivileged \
--prefix=$LOCALBASE \
--pkgdbdir=$PKG_DBDIR \
--sysconfdir=$PKG_SYSCONFBASE \
--varbase=$VARBASE \
--mk-fragment=$MKFRAG \
--make-jobs=$(
(getconf _NPROCESSORS_ONLN 2>/dev/null) || echo 1
)"
    (cd "$PKGSRCDIR/bootstrap" && sh ./bootstrap $BOOTSTRAP_ARGS ) || {
        echo "bootstrap failed" >&2
        rm -f "$MKFRAG"
        return 1
    }
    echo "Bootstrap complete for $REVISION under $LOCALBASE"
    rm -f "$MKFRAG"
}

if [ -z "${MY_PKGSRC:-}" ]; then
    for pfx in "$HOME/opt/pkg-2025Q2/" "$HOME/opt/pkg-2025Q3" "$HOME/opt/pkg-2025Q4"; do
	if [ -d "${pfx}/bin" ] && [ -d "${pfx}/sbin" ]; then
	    MY_PKGSRC="${pfx}"
	fi
    done
fi
_prepend_path "${MY_PKGSRC}/bin"
_prepend_path "${MY_PKGSRC}/sbin"

>>>>>>> 715ba83 (pkgsrc bootstrap & path script)
