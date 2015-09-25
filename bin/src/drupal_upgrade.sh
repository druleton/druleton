################################################################################
# Include script that runs the Drupal upgrade script trough Drush.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - drupal_upgrade_before : Scripts that should run before the upgrade is run.
# - drupal_upgrade_after  : Scripts that should run after the upgrade has run.
################################################################################


markup_h1 "Upgrade Drupal"
if [ $(drupal_is_installed) -eq 1 ]; then
  hook_invoke "drupal_upgrade_before"

  drupal_drush -y updb
  drupal_drush cc all

  hook_invoke "drupal_upgrade_after"
else
  message_warning "There is no working Drupa installation."
fi

echo
