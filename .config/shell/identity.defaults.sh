# shellcheck shell=sh
# shellcheck disable=SC2034  # vars consumed by gcfg-render, not this file
# Personal identity. Sourced by gcfg-render as the search values for
# in-place substitution in registered config files (see render-registry).
# If changing, copy this file to identity.local.sh (gitignored), edit the
# values, and run `gcfg render` to substitute them into config files.
MY_NAME="Benjamin James"
MY_EMAIL="benjames@mit.edu"
MY_EMAIL_CSAIL="benjames@csail.mit.edu"
MY_USER="benjames"
MY_GITHUB_USER="benjamin-james"
MY_GPG_KEYID="0x2F46E248ED575F62D40B7AABCD29765D063D78C4"
MY_OS_PROJECT="usersandbox_benjames"
