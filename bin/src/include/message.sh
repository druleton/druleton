################################################################################
# Include script that holds the code to show messages on screen.
################################################################################

##
# Function to show a success message.
#
# @param string message
##
function message_success {
  echo -e "${GREEN}✓${RESTORE} $1"
}

##
# Function to show a warning message.
#
# @param string message
##
function message_warning {
  echo -e " ${YELLOW}!${RESTORE} $1"
}

##
# Function to show an error message.
#
# @param string message
##
function message_error {
  echo -e " ${RED}✗${RED} $1"
}
