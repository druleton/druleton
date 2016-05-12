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
function drupal_composer_install_run {
  # Run any script before we run the composer files.
  hook_invoke drupal_composer_before


  # Make sure that the web directory does not exists.
  if [ -d "$DIR_WEB" ]; then
    drupal_sites_default_unprotect
    rm -R "$DIR_WEB"
  fi

  # Compose Drupal core.
  markup_h1 "Download Drupal core & other requirements"
  markup_h2 "Composer Install"
  composer_drupal_run install


  # Run any script after we did run the composer files.
  hook_invoke drupal_composer_after
}


##
# Function to update core & contrib modules and themes based on the composer
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
function drupal_composer_update_run {
  # Run any script before we run the composer files.
  hook_invoke drupal_composer_before


  # Make sure that the web directory does not exists.
  if [ -d "$DIR_WEB" ]; then
    drupal_sites_default_unprotect
    rm -R "$DIR_WEB"
  fi

  # Compose Drupal core.
  markup_h1 "Update Drupal core & other requirements"
  markup_h2 "Composer Update"
  composer_drupal_run update


  # Run any script after we did run the composer files.
  hook_invoke drupal_composer_after
}
