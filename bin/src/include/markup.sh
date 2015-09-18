################################################################################
# Include script that holds the code to markup the given string.
################################################################################

##
# Show a line as a main header (h1).
#
# This will result in text in blue.
#
# @param string test to show in the markup
##
function markup_h1 {
  echo -e "${LBLUE}$1${RESTORE}"
}

##
# Show a line as a secundary header (h2).
#
# This will result in text in light white.
#
# @param string text to show in the markup
##
function markup_h2 {
  echo -e "${LWHITE}$1${RESTORE}"
}

##
# Show a line of text as a success.
#
# The whole line will be shown in green.
#
# @param string text to show in the markup.
##
function markup_success {
  echo -e "${GREEN}$1${RESTORE}"
}

##
# Show a line of text as a warning.
#
# The whole line will be shown in yellow.
#
# @param string text to show in the markup.
##
function markup_warning {
  echo -e "${YELLOW}$1${YELLOW}"
}

##
# Show a line of text as an error.
#
# The whole line will be shown in red.
#
# @param string text to show in the markup.
##
function markup_error {
  echo -e "${RED}$1${RED}"
}

##
# Show an item as a list item.
#
# @param The text to show in the bullet.
##
function markup_li {
  echo -e " • $1"
}

##
# Show an item as a list item within a h1.
#
# @param The text to show in the bullet.
##
function markup_h1_li {
  echo -e " ${BLUE}•${LBLUE} $1"
}
