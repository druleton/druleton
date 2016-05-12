################################################################################
# Functionality to login de admin user into the Drupal website.
################################################################################


##
# Function to login into a Drupal site with the admin user.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - drupal_login_before : Scripts that should run before the user is logged in.
# - drupal_login_after  : Scripts that should run after the user id logged in.
#
# The hooks will be called without and with environment suffix.
##
function drupal_login_run {
  if [ $(option_is_set "--no-login") -eq 1 ]; then
    markup_debug "Drupal login is disabled" 1
    return
  fi

  # Run hooks before we login into Drupal.
  hook_invoke "drupal_login_before"

  # Open on-time-login in browser.
  markup_h1 "Open browser and login"
  if [ `drupal_is_installed` -eq 1 ]; then
    #drupal_console user:login:url 1 --uri="$SITE_URL"
    drupal_drush user-login 1 --uri="$SITE_URL"
  else
    message_error "No working Drupal installation to login to."
  fi
  echo

  # Run hooks after we login into Drupal.
  hook_invoke "drupal_login_after"
}
