################################################################################
# Include script that reads out the script arguments.
################################################################################

# Loop trough the arguments and store them in the options array.
SCRIPT_OPTIONS=()
while [ "$#" -gt 0 ]; do
  SCRIPT_OPTIONS+=("$1")
  shift
done

##
# Function to check if a given option is set.
#
# @param The option name (including - or --) to check for.
##
function option_is_set {
  for option in ${SCRIPT_OPTIONS[@]}; do
    if [[ "$option" == "$1" ]]; then
      echo 1
      return
    fi
  done

  echo 0
}
