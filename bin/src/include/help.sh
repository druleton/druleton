################################################################################
# Include script that holds the help functionality.
################################################################################

##
# Function to load the help text(s).
#
# The help text is loaded based on the default "core" script help and the
# optional help text as defined in the config/$SCRIPT_NAME/help.txt file.
##
function help_run {
  echo
  help_run_load "$DIR_SRC/help/${SCRIPT_NAME}_description.txt"
  help_run_load "$DIR_CONFIG_SRC/help/${SCRIPT_NAME}_description.txt"
  echo

  markup_h2 "Examples:"
  help_run_load "$DIR_SRC/help/${SCRIPT_NAME}_examples.txt"
  help_run_load "$DIR_CONFIG_SRC/help/${SCRIPT_NAME}_examples.txt"
  help_run_load "$DIR_SRC/help/common_examples.txt"
  echo

  markup_h2 "Arguments:"
  help_run_load "$DIR_SRC/help/${SCRIPT_NAME}_arguments.txt"
  help_run_load "$DIR_CONFIG_SRC/help/${SCRIPT_NAME}_arguments.txt"
  help_run_load "$DIR_SRC/help/common_arguments.txt"
  echo

  markup_h2 "Options:"
  help_run_load "$DIR_SRC/help/${SCRIPT_NAME}_options.txt"
  help_run_load "$DIR_CONFIG_SRC/help/${SCRIPT_NAME}_options.txt"
  help_run_load "$DIR_SRC/help/common_options.txt"
  echo

  # Check if there are extra's to show.
  # Use this for binary wrappers like bin/drush, bin/composer, ...
  if [ -f "$DIR_SRC/help/${SCRIPT_NAME}_extra.sh" ]; then
    source "$DIR_SRC/help/${SCRIPT_NAME}_extra.sh"
    echo
  fi
  if [ -f "$DIR_CONFIG_SRC/help/${SCRIPT_NAME}_extra.sh" ]; then
    source "$DIR_CONFIG_SRC/help/${SCRIPT_NAME}_extra.sh"
    echo
  fi

  exit
}

##
# Load a help file (if exists) and print out on screen.
#
# @param Path to the help file.
##
function help_run_load {
  local content=""

  if [ -f "$1" ]; then
    content="$(cat $1)"
  fi

  if [ ! -z "$content" ]; then
    markup "$content"
  fi
}


# Detect if the help is called.
if [ $( option_is_set "--help" ) -eq 1 ]; then
  help_run
fi
if [ $( option_is_set "-h" ) -eq 1 ]; then
  help_run
fi
