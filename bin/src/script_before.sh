################################################################################
# Include script that triggers the script_before hook.
#
# This script will trigger 1 "hooks" in the config/<script-name>/ directory:
# - script_before : Scripts that should run before the actual script is run.
################################################################################

hook_invoke "script_before"
