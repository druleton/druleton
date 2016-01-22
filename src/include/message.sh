################################################################################
# Include script that holds the code to show messages on screen.
################################################################################

##
# Function to show a success message.
#
# @param string message
##
function message_success {
  markup " ${GREEN}✓${RESTORE} $1"
}

##
# Function to show a warning message.
#
# @param string message
##
function message_warning {
  markup " ${YELLOW}!${RESTORE} $1"
}

##
# Function to show an error message.
#
# @param string message
##
function message_error {
  markup " ${RED}✗ $1"
}

##
# Function to show a tip message.
#
# @param string message
##
function message_info {
  markup " ${CYAN}ⓘ  $1"
}
