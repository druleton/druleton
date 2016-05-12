################################################################################
# Hook information for the Install script.
################################################################################

# Common hook information.
hook_info_run_load "common.sh"

# Script specific information.
hook_info_run_load "script_before.sh"
hook_info_run_load "drupal_composer.sh"
hook_info_run_load "build_package.sh"
hook_info_run_load "script_after.sh"
