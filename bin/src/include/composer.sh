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
  local cmd_options="$( composer_filter_options "$@" )"

  # Only use colors if not disabled.
  if [ $( option_is_set "--no-color") -ne 1 ]; then
    cmd_options="$options --ansi"
  else
    cmd_options="$options --no-ansi"
  fi

  if [ ! -z "$COMPOSER_USE_GLOBAL" ]; then
    cmd_composer="composer"
  fi

  local cmd="$cmd_composer $cmd_options"
  COMPOSER_DISABLE_XDEBUG_WARN=1  $cmd
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

##
# Make sure that a COMPOSER_USE_GLOBAL variable is set.
##
function composer_variable_use_global {
  if [ ! -z "$COMPOSER_USE_GLOBAL" ]; then
    COMPOSER_USE_GLOBAL=0
  fi
}

##
# Remove skeleton specific command options.
#
# @param string
#   The command options.
#
# @return string
#   The filtered options.
##
function composer_filter_options {
  local options="$@"

  # Skeleton uses --no-color, phpcs uses --no-colors
  options=${options/--no-color/}

  # phpcs has no confirm option.
  options=${options/-y/}

  # phpcs does not support environments.
  options=${options/--env=*/}

  echo "$options"
}
