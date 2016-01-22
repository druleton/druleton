################################################################################
# Include script that triggers the script_before hook.
#
# This script will trigger 1 "hooks" in the config/<script-name>/ directory:
# - script_before : Scripts that should run before the actual script is run.
################################################################################


##
# Function to run the script_before hook.
#
# This script will trigger 1 "hooks" in the config/<script-name>/ directory:
# - script_before : Scripts that should run before the actual script is run.
#
# The hook will be called without and with environment suffix.
##
function script_before_run {
  hook_invoke "script_before"
}
