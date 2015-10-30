################################################################################
# Hook information for the Reset script.
################################################################################

# Common hook information.
hook_info_run_load "common.sh"

# Script specific information.
hook_info_run_load "script_before.sh"
hook_info_run_load "backup.sh"
hook_info_run_load "cleanup.sh"
hook_info_run_load "drupal_install.sh"
hook_info_run_load "drupal_modules_disable.sh"
hook_info_run_load "drupal_modules_enable.sh"
hook_info_run_load "drupal_login.sh"
hook_info_run_load "script_after.sh"
