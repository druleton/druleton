################################################################################
# Include script that runs the code to login into Drupal from CLI and open the
# site in the default browser.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - drupal_login_before : Scripts that should run before the user is logged in.
# - drupal_login_after  : Scripts that should run after the user id logged in.
################################################################################


# Run any script before we login into Drupal.
hook_invoke "drupal_login_before"


# Open on-time-login in browser.
markup_h1 "Open browser and login"
if [ `drupal_is_installed` -eq 1 ]; then
  drush --root="$DIR_WEB" uli -l "$SITE_URL" /
else
  message_error "No working Drupal installation to login to."
fi
echo


# Run any script after we login into Drupal.
hook_invoke "drupal_login_after"
