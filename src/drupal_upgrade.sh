################################################################################
# Functionality to upgrade Drupal using Drupal Console commands.
################################################################################


##
# Function to run the Drupal upgrade function.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - drupal_upgrade_before : Scripts that should run before the upgrade is run.
# - drupal_upgrade_after  : Scripts that should run after the upgrade has run.
#
# The hooks will be called without and with environment suffix.
##
function drupal_upgrade_run {
  markup_h1 "Upgrade Drupal"

  # Check first if we have something to upgrade.
  if [ $(drupal_is_installed) -ne 1 ]; then
    message_warning "There is no working Drupal installation."
    echo
    exit
    return 1
  fi

  # Trigger the before hook(s).
  hook_invoke "drupal_upgrade_before"

  # Do Drupal upgrade.
  #
  # Drupal Console's update:execute command does the following:
  #  - Switch site into maintenance mode
  #  - Executing required previous updates
  #  - Operating in maintenance mode off
  #  - Rebuilding cache(s)
  drupal_console update:execute all
  echo

  # Trigger the after hook(s).
  hook_invoke "drupal_upgrade_after"
}
