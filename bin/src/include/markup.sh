################################################################################
# Include script that holds the code to markup the given string.
################################################################################

##
# Prints a line with support for color variables (eg. ${LWHITE}, ${YELLOW}).
#
# @param string test to show in the markup.
##
function markup {
  echo -e "$1${RESTORE}"
}

##
# Show a line as a main header (h1).
#
# This will result in text in blue.
#
# @param string test to show in the markup
##
function markup_h1 {
  markup "${LBLUE}$1"
}

##
# Show a line as a secundary header (h2).
#
# This will result in text in light white.
#
# @param string text to show in the markup
##
function markup_h2 {
  markup "${YELLOW}$1"
}

##
# Show a line of text as a success.
#
# The whole line will be shown in green.
#
# @param string text to show in the markup.
##
function markup_success {
  markup "${GREEN}$1"
}

##
# Show a line of text as a warning.
#
# The whole line will be shown in yellow.
#
# @param string text to show in the markup.
##
function markup_warning {
  markup "${YELLOW}$1"
}

##
# Show a line of text as an error.
#
# The whole line will be shown in red.
#
# @param string text to show in the markup.
##
function markup_error {
  markup "${RED}$1"
}

##
# Show an item as a list item.
#
# @param The text to show in the bullet.
##
function markup_li {
  markup " ${GREY}•${RESTORE} $1"
}

##
# Show an item as a list item within a h1.
#
# @param The text to show in the bullet.
##
function markup_h1_li {
  markup " ${BLUE}•${LBLUE} $1"
}

##
# Show text as a debug message.
#
# @param The text to show in the debug message.
# @param Should there be a newline after the debug message.
##
function markup_debug {
  if [ $(option_is_set "-v") -ne 1 ] && [ $(option_is_set "--verbose") -ne 1 ]; then
    return
  fi

  markup  "${GREY}$1"
  if [ ! -z "$2" ]; then
    echo
  fi
}

##
# Show a horizontal divider.
##
function markup_divider {
  markup "================================================================================"
}

##
# Show a horizontal divider within a h1.
##
function markup_h1_divider {
  markup_h1 "================================================================================"
}
