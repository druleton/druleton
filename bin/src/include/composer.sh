################################################################################
# Include script that holds helper functions about Composer.
################################################################################

##
# Run a composer command.
#
# This will run the bin/composer command with surpression of the XDEBUG warning.
##
function composer_run {
  COMPOSER_DISABLE_XDEBUG_WARN=1 "$DIR_BIN/composer" "$@"
}

##
# Run a composer command within the skeleton context.
#
# Use this to perform composer commands on the set of packages required and
# installed by the skeleton.
##
function composer_skeleton_run {
  composer_run "$@" --working-dir="$DIR_BIN"
}
