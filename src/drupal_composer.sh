####################################################################################
# Functionality to download core and contrib modules & themes using composer files.
####################################################################################


##
# Function to download core & contrib modules and themes based on the composer
# files.
#
# This script will try to load the composer config from 4 files:
#   1. config/drupal_composer.sh
#   2. config/drupal_composer_<environment>.sh
#   3. config/<script-name>/drupal_composer.sh
#   4. config/<script-name>/drupal_composer_<environment>.sh
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - drupal_composer_before : Scripts that should run before the user is logged in.
# - drupal_composer_after  : Scripts that should run after the user id logged in.
#
# The hooks will be called without and with environment suffix.
##
function drupal_composer_run {
  # Run any script before we run the composer files.
  hook_invoke drupal_composer_before


  # Make sure that the web directory does not exists.
  if [ -d "$DIR_WEB" ]; then
    drupal_sites_default_unprotect
    rm -R "$DIR_WEB"
  fi


  # Compose Drupal core.
  markup_h1 "Download Drupal core"
  markup_h2 "_core/composer.json"
  drupal_drush_run make "$DIR_CONFIG/make/_core/composer.json" "$DIR_WEB"
  echo

  # 1. Default composer files.
  drupal_composer_run_file "$DIR_CONFIG/drupal_composer.sh"

  # 2. Composer files specific for the environment.
  drupal_composer_run_file "$DIR_CONFIG/drupal_composer_$ENVIRONMENT.sh"

  # 3. Composer files specific for the script name.
  drupal_composer_run_file "$DIR_CONFIG/$SCRIPT_NAME/drupal_composer.sh"

  # 4. Composer files specific for the script name and environment.
  drupal_composer_run_file "$DIR_CONFIG/$SCRIPT_NAME/drupal_composer_$ENVIRONMENT.sh"


  # Run any script after we did run the composer files.
  hook_invoke drupal_composer_after
}

##
# Run the composer files.
#
# @param The file name of the script that contains the config array.
##
function drupal_composer_run_file {
  # Reset the variable.
  local MAKE_FILES=()
  local drupal_composer_file="$1"

  # Check if file exists.
  if [ ! -f "$drupal_composer_file" ]; then
    markup_debug "Composer file does not exists : $drupal_composer_file"
    return
  fi

  markup_h1 "Composer configuration $drupal_composer_file"
  source "$drupal_composer_file"

  # Check if there are composer files in the config.
  if [ ${#MAKE_FILES[@]} -eq 0 ]; then
    markup "No composer files in configuration."
    return
  fi

  # Run all composer files in the configuration.
  for make_file in ${MAKE_FILES[@]}; do
    markup_h2 "${make_file}"
    drupal_drush_run make --no-core "$DIR_CONFIG/make/${make_file}" "$DIR_WEB"
  done
  echo
}
