################################################################################
# Include script that triggers the script_after hook.
#
# This script will trigger 1 "hooks" in the config/<script-name>/ directory:
# - script_after : Scripts that should run after the actual script is run.
################################################################################

hook_invoke "script_after"
