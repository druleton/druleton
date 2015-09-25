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
  local hook_invoke_name="$1"

  # Invoke the script for the script name.
  hook_invoke_script "$SCRIPT_NAME/${hook_invoke_name}.sh"

  # Invoke the script for the script and environment name.
  hook_invoke_script "$SCRIPT_NAME/${hook_invoke_name}_$ENVIRONMENT.sh"
}

##
# Check if the hook script exists, if so include it so it is run.
#
# @param file path within the config folder of the hook script to run.
##
function hook_invoke_script {
  local hook_invoke_script="$1"
  if [ -f "$hook_invoke_script" ]; then
    markup_debug "Run hook : $hook_invoke_script" 1
    source "$DIR_CONFIG/$hook_invoke_script"
    echo
  else
    markup_debug "Hook not implemented : $hook_invoke_script"
  fi
}

##
# Function to load the help text(s).
#
# The help text is loaded based on the default "core" script help and the
# optional help text as defined in the config/$SCRIPT_NAME/help.txt file.
##
function hook_info_run {
  echo
  source "$DIR_SRC/hook_info/${SCRIPT_NAME}.sh"
  echo
  exit
}

##
# Load a hook info file.
#
# @param The path to the file to load.
##
function hook_info_run_load {
  local hook_info="$DIR_SRC/hook_info/hook/$1"
  if [ -f "$hook_info" ]; then
    source "$hook_info"
  fi
}


# Detect if the hook_info is called.
if [ $( option_is_set "--hook-info" ) -eq 1 ]; then
  hook_info_run
fi
