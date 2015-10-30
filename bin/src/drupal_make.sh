################################################################################
# Functionality to download core and contrib modules & themes using make files.
################################################################################


##
# Function to download core & contrib modules and themes based on the make
# files.
#
# This script will try to load the make config from 4 files:
#   1. config/drupal_make.sh
#   2. config/drupal_make_<environment>.sh
#   3. config/<script-name>/drupal_make.sh
#   4. config/<script-name>/drupal_make_<environment>.sh
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - drupal_make_before : Scripts that should run before the user is logged in.
# - drupal_make_after  : Scripts that should run after the user id logged in.
#
# The hooks will be called without and with environment suffix.
##
function drupal_make_run {
  # Run any script before we run the make files.
  hook_invoke drupal_make_before


  # Make sure that the web directory does not exists.
  if [ -d "$DIR_WEB" ]; then
    drupal_sites_default_unprotect
    rm -R "$DIR_WEB"
  fi


  # Make Drupal core.
  markup_h1 "Download Drupal core"
  markup_h2 "_core.make"
  drush make "$DIR_CONFIG/make/_core.make" "$DIR_WEB"
  echo

  # 1. Default make files.
  drupal_make_run_file "$DIR_CONFIG/drupal_make.sh"

  # 2. Make files specific for the environment.
  drupal_make_run_file "$DIR_CONFIG/drupal_make_$ENVIRONMENT.sh"

  # 3. Make files specific for the script name.
  drupal_make_run_file "$DIR_CONFIG/$SCRIPT_NAME/drupal_make.sh"

  # 4. Make files specific for the script name and environment.
  drupal_make_run_file "$DIR_CONFIG/$SCRIPT_NAME/drupal_make_$ENVIRONMENT.sh"


  # Run any script after we did run the make files.
  hook_invoke drupal_make_after
}

##
# Run the make files.
#
# @param The file name of the script that contains the config array.
##
function drupal_make_run_file {
  # Reset the variable.
  local MAKE_FILES=()
  local drupal_make_file="$1"

  # Check if file exists.
  if [ ! -f "$drupal_make_file" ]; then
    markup_debug "Make file does not exists : $drupal_make_file"
    return
  fi

  markup_h1 "Make configuration $drupal_make_file"
  source "$drupal_make_file"

  # Check if there are make files in the config.
  if [ ${#MAKE_FILES[@]} -eq 0 ]; then
    markup "No make files in configuration."
    return
  fi

  # Run all make files in the configuration.
  for make_file in ${MAKE_FILES[@]}; do
    markup_h2 "${make_file}"
    drush make --no-core "$DIR_CONFIG/make/${make_file}" "$DIR_WEB"
  done
  echo
}
