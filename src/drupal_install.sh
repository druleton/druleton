################################################################################
# Functionality to install a Drupal site based on the configuration file.
################################################################################


##
# Function to instal a Drupal site based on the global config parameters.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - drupal_install_before : Scripts that should run before Drupal is installed.
# - drupal_install_after  : Scripts that should run after Drupal is installed.
#
# The hooks will be called without and with environment suffix.
##
function drupal_install_run {
  # Run any script before we run the Drupal installer.
  hook_invoke "drupal_install_before"


  # Install Drupal with the configuration parameters.
  markup_h1 "Install Drupal"

  markup_debug "Install Drupal with:"
  markup_debug "  - Site name : $SITE_NAME"
  markup_debug "  - Profile   : $SITE_PROFILE"
  markup_debug "  - Username  : $ACCOUNT_NAME"
  markup_debug "  - Password  : $ACCOUNT_PASS"
  markup_debug "  - Email     : $ACCOUNT_MAIL"
  markup_debug "  - DB host   : $DB_HOST"
  markup_debug "  - DB name   : $DB_NAME"
  markup_debug "  - DB user   : $DB_USER"
  markup_debug "  - DB pass   : $DB_PASS"

  drupal_drush -y si \
    --account-name="$ACCOUNT_NAME" \
    --account-pass="$ACCOUNT_PASS" \
    --account-mail="$ACCOUNT_MAIL" \
    --site-name="$SITE_NAME" \
    --db-url="mysql://$DB_USER:$DB_PASS@$DB_HOST/$DB_NAME" \
    $SITE_PROFILE
  echo


  # Run any script after we run the Drupal installer.
  hook_invoke "drupal_install_after"
}
