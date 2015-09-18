################################################################################
# Include script that holds the code to check and run a hook script file.
################################################################################

##
# Call a hook by providing the hook name.
#
# It will try to run 2 hook scripts:
#   1. The hook by the script that is run name.
#      e.g. config/<script_name>/<hook_name>.sh
#   2. The hook by the script that is run and the environment for who its run.
#       e.g. config/<script_name>/<hook_name>_<environment>.sh
#
# @param hook name.
##
function hook_invoke {
  hook_invoke_name="$1"

  # Invoke the script for the script name.
  hook_invoke_script "$DIR_CONFIG/$SCRIPT_NAME/$hook_invoke_name.sh"

  # Invoke the script for the script and environment name.
  hook_invoke_script "$DIR_CONFIG/$SCRIPT_NAME/$hook_invoke_name_$ENVIRONMENT.sh"
}

##
# Check if the hook script exists, if so include it so it is run.
#
# @param full file path of the hook script to run.
##
function hook_invoke_script {
  hook_invoke_script="$1"
  if [ -f "$hook_invoke_script" ]; then
    echo -e "${LWHITE}>${LBLUE} Run hook${RESTORE}"
    markup_debug "$hook_invoke_script"
    echo
    source "$hook_invoke_script"
    echo
  fi
}
