AC_INIT([dotfiles], [1.0], [benjames@mit.edu])

AM_INIT_AUTOMAKE([foreign subdir-objects])
#AC_PROG_SED

AC_ARG_ENABLE([all],
              [AS_HELP_STRING([--enable-all],
                              [enable all optional parts])],
              [case "${enableval}" in
               yes) all=true ;;
               no)  all=false ;;
               *) AC_MSG_ERROR([bad value ${enableval} for --enable-all]) ;;
               esac],
              [all=false])


if test "x$all" = "xtrue"; then
    emacs=true
    bash=true
    systemd=true
    git=true
    screen=true
    tmux=true
    conda=true
    ssh=true
else
    AC_ARG_ENABLE([emacs],
        [AS_HELP_STRING([--enable-emacs], [Enable Emacs dotfiles])],
        [case "${enableval}" in
             yes) emacs=true ;;
             no)  emacs=false ;;
             *) AC_MSG_ERROR([bad value ${enableval} for --enable-emacs]) ;;
        esac],
        [emacs=false])

    AC_ARG_ENABLE([bash],
        [AS_HELP_STRING([--enable-bash], [Enable Bash dotfiles])],
        [case "${enableval}" in
             yes) bash=true ;;
             no)  bash=false ;;
             *) AC_MSG_ERROR([bad value ${enableval} for --enable-bash]) ;;
         esac],
        [bash=false])

    AC_ARG_ENABLE([systemd],
        [AS_HELP_STRING([--enable-systemd], [Enable Systemd dotfiles])],
        [case "${enableval}" in
             yes) systemd=true ;;
             no)  systemd=false ;;
             *) AC_MSG_ERROR([bad value ${enableval} for --enable-systemd]) ;;
         esac],
        [systemd=false])

    AC_ARG_ENABLE([git],
        [AS_HELP_STRING([--enable-git], [Enable Git dotfiles])],
        [case "${enableval}" in
             yes) git=true ;;
             no)  git=false ;;
             *) AC_MSG_ERROR([bad value ${enableval} for --enable-git]) ;;
         esac],
        [git=false])

    AC_ARG_ENABLE([screen],
        [AS_HELP_STRING([--enable-screen], [Enable Screen dotfiles])],
        [case "${enableval}" in
             yes) screen=true ;;
             no)  screen=false ;;
             *) AC_MSG_ERROR([bad value ${enableval} for --enable-screen]) ;;
         esac],
        [screen=false])

    AC_ARG_ENABLE([tmux],
        [AS_HELP_STRING([--enable-tmux], [Enable Tmux dotfiles])],
        [case "${enableval}" in
             yes) tmux=true ;;
             no)  tmux=false ;;
             *) AC_MSG_ERROR([bad value ${enableval} for --enable-tmux]) ;;
         esac],
        [tmux=false])

    AC_ARG_ENABLE([conda],
        [AS_HELP_STRING([--enable-conda], [Enable Conda dotfiles])],
        [case "${enableval}" in
             yes) conda=true ;;
             no)  conda=false ;;
             *) AC_MSG_ERROR([bad value ${enableval} for --enable-conda]) ;;
         esac],
        [conda=false])

    AC_ARG_ENABLE([ssh],
        [AS_HELP_STRING([--enable-ssh], [Enable Ssh dotfiles])],
        [case "${enableval}" in
             yes) ssh=true ;;
             no)  ssh=false ;;
             *) AC_MSG_ERROR([bad value ${enableval} for --enable-ssh]) ;;
         esac],
        [ssh=false])
fi
AM_CONDITIONAL([EMACS], [test x"$emacs" = x"true"])
AM_CONDITIONAL([BASH], [test x"$bash" = x"true"])
AM_CONDITIONAL([SYSTEMD], [test x"$systemd" = x"true"])
AM_CONDITIONAL([GIT], [test x"$git" = x"true"])
AM_CONDITIONAL([SCREEN], [test x"$screen" = x"true"])
AM_CONDITIONAL([TMUX], [test x"$tmux" = x"true"])
AM_CONDITIONAL([CONDA], [test x"$conda" = x"true"])
AM_CONDITIONAL([SSH], [test x"$ssh" = x"true"])

AC_ARG_WITH([dotfiles-dir],
    [AS_HELP_STRING([--with-dotfiles-dir=@<:@=DIR@:>@], [Set the directory to install dotfiles into])],
    [dotfilesdir=$withval],
    [dotfilesdir=$HOME])
AC_SUBST(dotfilesdir)

# Allow user to provide substitution values
AC_ARG_WITH([jupyter-luria-prefix],
    [AS_HELP_STRING([--with-jupyter-luria-prefix=@<:@=NAME@:>@], [Set the Jupyter prefix port on Luria])],
    [jupyter_luria_prefix=$withval],
    [jupyter_luria_prefix=100])
AC_SUBST(jupyter_luria_prefix)

AC_ARG_WITH([conda-exe],
    [AS_HELP_STRING([--with-conda-exe=@<:@=NAME@:>@], [Set the Conda EXE])],
    [conda_exe=$withval],
    [conda_exe=$CONDA_EXE])

if test x"$conda" = x"true"; then
   AS_IF([test -f "$conda_exe"], [], [AC_MSG_WARN([File "$conda_exe" does not exist but conda is enabled. Please install conda first.])])
fi
AC_SUBST(conda_exe)

conda_bindir=`dirname "$conda_exe"`
AC_SUBST(conda_bindir)
conda_prefix=`dirname "$conda_bindir"`
AC_SUBST(conda_prefix)

AC_ARG_WITH([BROAD],
    [AS_HELP_STRING([--with-broad=@<:@=NAME@:>@], [Set the Broad username])],
    [BROAD=$withval],
    [BROAD=])
AC_SUBST(BROAD)

AC_ARG_WITH([CSAIL],
    [AS_HELP_STRING([--with-csail=@<:@=NAME@:>@], [Set the CSAIL username])],
    [CSAIL=$withval],
    [CSAIL=])
AC_SUBST(CSAIL)

AC_ARG_WITH([MIT],
    [AS_HELP_STRING([--with-mit=@<:@=NAME@:>@], [Set the MIT username])],
    [MIT=$withval],
    [MIT=])
AC_SUBST(MIT)

AC_CONFIG_FILES([Makefile .config/systemd/user/jupyter_luria@.service src/conda_init.sh .ssh/config .bash_profile])
AC_OUTPUT
