################################################################################
# Include script that reads out the script arguments.
################################################################################

# Loop trough the arguments and store them in the options array.
SCRIPT_OPTIONS=()
SCRIPT_ARGUMENT=""
while [ "$#" -gt 0 ]; do
  if [[ $1 == -* ]]; then
    SCRIPT_OPTIONS+=("$1")
  else
    SCRIPT_ARGUMENT="$1"
  fi

  shift
done

##
# Function to check if a given option is set.
#
# @param The option name (including - or --) to check for.
##
function option_is_set {
  for option in ${SCRIPT_OPTIONS[@]}; do
    if [[ "$option" == "$1" ]] || [[ "$option" == "$1="* ]]; then
      echo 1
      return
    fi
  done

  echo 0
}

##
# Get the value from an option.
#
# @param The option name (including - or --) to get the value from.
##
function option_get_value {
  if [ $(option_is_set "$1") -ne 1 ]; then
    echo ""
    return
  fi

  for option in ${SCRIPT_OPTIONS[@]}; do
    if [[ "$option" == "$1" ]]; then
      echo 1
      return
    fi

    if [[ "$option" == "$1="* ]]; then
      echo "${option#*=}"
      return
    fi
  done

  echo 0
}

##
# Get the environment from the argument.
##
function option_get_environment {
  local environment=$(option_get_value "--env")
  if [ -z "$environment" ]; then
    echo "dev"
    return
  fi

  echo "$environment"
}
