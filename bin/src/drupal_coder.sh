################################################################################
# Functionality to run phpcs with drupal/coder code standards on the  code.
################################################################################


# Include the configuration (if any).
if [ -f "$DIR_CONFIG/drupal_coder.sh" ]; then
  source "$DIR_CONFIG/drupal_coder.sh"
fi


##
# Run the coder on all directories as specified in $CODER_DIRECTORIES.
#
# The $CODER_DIRECTORIES is defined in config/drupal_coder.sh
##
function drupal_coder_run_all {
  if [ -z "$CODER_DIRECTORIES" ]; then
    message_error "There are no directories defined in \$CODER_DIRECTORIES."
    markup " > Add these in an array to the config/drupal_coder.sh file."
    echo
    exit
  fi

  for directory in ${CODER_DIRECTORIES[@]}; do
    markup_h2 "Scan $directory"
    drupal_coder_run $directory "$@"
    echo
  done
}

##
# Run the phpcs command with the drupal code standards.
##
function drupal_coder_run {
  local options="$( drupal_coder_options )"
  local cmd_options="$( drupal_coder_filter_options "$@" )"

  # Only use colors if not disabled.
  if [ $( option_is_set "--no-color") -ne 1 ]; then
    options="$options --colors"
  else
    options="$options --no-colors"
  fi

  # Filter out command options specific by the skeleton.
  local cmd="$DIR_BIN/packagist/vendor/bin/phpcs $options"
  $cmd "$@"
}

##
# Create the shared phpcs & phpcbf options.
#
# This will check and add
# - Show progress.
# - Ignore patterns.
# - Extensions to scan.
#
# @return string
#   The options to add to the command call.
##
function drupal_coder_options {
  local options="-p --standard=Drupal"

  # Exclude patterns.
  local ignore_patterns="$( drupal_coder_ignore_patterns )"
  if [ ! -z "$ignore_patterns" ]; then
    options="$options --ignore=$ignore_patterns"
  fi

  # File extensions.
  local extensions="$( drupal_coder_extensions )"
  if [ ! -z "$extensions" ]; then
    options="$options --extensions=$extensions"
  fi

  echo "$options"
}

##
# Get the ignore patterns (if any).
#
# This will:
# - First check if there are any ignore patterns passed as command options.
# - Fallback to the ignore patterns as defined in the config/coder.sh file.
#
# @return string
#   A list of ignore patterns (if any).
##
function drupal_coder_ignore_patterns {
  # Check if ignore patterns are passed using --ignore
  local ignore="$( option_get_value "--ignore" )"
  if [ ! -z "$ignore" ]; then
    echo "$ignore"
    return
  fi

  # Fallback to the patterns from the configuration (if any).
  if [ ! -z $CODER_IGNORE ]; then
    printf '%s,' "${CODER_IGNORE[@]}"
    return
  fi

  echo ""
}

##
# Get the file extensions (if any).
#
# This will:
# - First check if there are any extensions passed as command options.
# - Fallback to the extensions as defined in the config/coder.sh file.
#
# @return string
#   A list of extensions (if any).
##
function drupal_coder_extensions {
  # Check if the extensions are passed using --extensions.
  local extensions="$( option_get_value "--extensions" )"
  if [ ! -z "$extensions" ]; then
    echo "$extensions"
    return
  fi

  # Fallback to the extensions in the configuration.
  if [ ! -z $CODER_EXTENSIONS ]; then
    printf '%s,' "${CODER_EXTENSIONS[@]}"
    return
  fi

  echo ""
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
function drupal_coder_filter_options {
  local options="$@"

  # Skeleton uses --no-color, phpcs uses --no-colors
  options=${options/--no-color/}

  # phpcs has no confirm option.
  options=${options/-y/}

  # phpcs has only -v not --verbose.
  options=${options/--verbose/-v}

  # phpcs does not support environments.
  options=${options/--env=*/}

  # Remove all from the options.
  options=${options/all/}

  echo "$options"
}
