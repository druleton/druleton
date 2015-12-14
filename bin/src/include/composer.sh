################################################################################
# Include script that holds helper functions about Composer.
################################################################################

##
# Run a composer command.
#
# This will run the bin/composer command with surpression of the XDEBUG warning.
##
function composer_run {
  local cmd_composer="$DIR_BIN/packagist/composer.phar"

  if [ ! -z "$COMPOSER_USE_GLOBAL" ]; then
    cmd_composer="composer"
  fi

  COMPOSER_DISABLE_XDEBUG_WARN=1 "$cmd_composer" "$@"
}

##
# Run a composer command within the skeleton context.
#
# Use this to perform composer commands on the set of packages required and
# installed by the skeleton.
##
function composer_skeleton_run {
  composer_run "$@" --working-dir="$DIR_BIN/packagist"
}
