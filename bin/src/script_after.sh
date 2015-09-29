################################################################################
# Include script that triggers the script_after hook.
################################################################################


##
# Function to run the script_after hook.
#
# This script will trigger 1 "hooks" in the config/<script-name>/ directory:
# - script_after : Scripts that should run after the actual script is run.
#
# The hook will be called without and with environment suffix.
##
function script_after_run {
  hook_invoke "script_after"
}
