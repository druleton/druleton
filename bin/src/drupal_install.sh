################################################################################
# Include script that holds the code to run the Drupal install.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - drupal_install_before : Scripts that should run before Drupal is installed.
# - drupal_install_after  : Scripts that should run after Drupal is installed.
################################################################################


# Run any script before we run the Drupal installer.
hook_invoke "drupal_install_before"


# Install Drupal with the configuration parameters.
markup_h1 "Install Drupal"
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
