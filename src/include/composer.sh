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
  local cmd_options=""

  # Only use colors if not disabled.
  if [ $( option_is_set "--no-color") -ne 1 ]; then
    cmd_options="$options --ansi"
  else
    cmd_options="$options --no-ansi"
  fi

  if [ "$COMPOSER_USE_GLOBAL" = "1" ]; then
    cmd_composer="composer"
  fi

  local cmd="$cmd_composer $cmd_options"
  COMPOSER_DISABLE_XDEBUG_WARN=1 $cmd "$@"
}

##
# Run a composer command within the druleton context.
#
# Use this to perform composer commands on the set of packages required and
# installed by druleton.
##
function composer_skeleton_run {
  composer_run "$@" --working-dir="$DIR_BIN/packagist"
}

##
# Run a composer command within the Drupal web directory context.
#
# Use this to perform composer commands on the set of packages required and
# installed for the Drupal website located in the web directory.
##
function composer_drupal_run {
  composer_run "$@" --working-dir="$DIR_ROOT"
}

##
# Make sure that a COMPOSER_USE_GLOBAL variable is set.
##
function composer_variable_use_global {
  if [ "$COMPOSER_USE_GLOBAL" != "1" ]; then
    COMPOSER_USE_GLOBAL=0
  fi
}


##
# Create the $COMPOSER_OPTIONS array based on the $SCRIPT_OPTIONS_ALL array.
##
function composer_filter_options {
  COMPOSER_OPTIONS=()

  markup_debug "Filter composer options:"

  for composer_option in "${SCRIPT_OPTIONS_ALL[@]}"; do
    # Check if the option should be passed to composer.
    if [ $(composer_filter_option "$composer_option") -eq 1 ]; then
      markup_debug " • $composer_option"
    else
      COMPOSER_OPTIONS+=("$composer_option")
    fi
  done

  markup_debug
}

##
# Remove druleton specific command options.
#
# @param string
#   The command options.
#
# @return string
#   The filtered options.
##
function composer_filter_option {
  local option="$1"

  # Druleton uses --no-color, composer does not support it.
  if [ "$option" == "--no-color" ]; then
    echo 1
    return
  fi

  # composer has no confirm option.
  if [ "$option" == "-y" ] || [ "option" == "--confirm" ]; then
    echo 1
    return
  fi

  # composer does not support environments.
  if [[ "$option" == "--env="* ]]; then
    echo 1
    return
  fi

  echo 0
}
