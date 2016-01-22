################################################################################
# Include script that holds the code to ask user for input.
################################################################################

##
# Show a prompt on 2 lines.
#
# - First line: the question with optional default value.
# - Second line: a prompt to fill in the response.
#
# @param string the question to ask
# @param string (optional) the default answer if nothing is filled in.
#
# The result will be stored in the $REPLY variable.
##
function prompt {
  local question="$1"
  local default="$2"
  local color="${GREEN}"

  echo -e -n "${question}"

  if [ "$2" != "" ]; then
    echo -e -n " ${GREY}($2)${RESTORE}"
  fi

  echo ":"

  echo -e -n "${GREY} > ${color}"
  read
  echo -e -n "${RESTORE}"

  # Read the reply, fallback to default if no reply entered.
  REPLY="${REPLY:-$default}"
}

##
# Show a y/n prompt.
#
# - The [y/n] option will be added automatically to the question string.
# - The REPLY will contain 1 (y) or 0 (no).
#
# @param string the question to ask
# @param string (optional) the default answer if nothing is filled in.
#
# The result will be stored in the $REPLY variable.
##
function prompt_yn {
  local question="$1"
  local default

  # Translate the default to y or n.
  case $2 in
    1|Y|y)
      default="y"
      ;;

    0|N|n)
      default="n"
      ;;

    *)
      default=""
      ;;
  esac

  # Ask the question.
  prompt "${question} [y/n]?" "${default}"

  # Check the answer.
  case $REPLY in
    1|Y|y)
      REPLY=1
      ;;

    0|N|n)
      REPLY=0
      ;;

    *)
      message_error "Not a valid entry!"
      echo

      # Ask the question again.
      prompt_yn "${question}" "${default}"
      ;;
  esac
}

##
# Show a confirm prompt.
#
# This is the same as prompt_yn but the question will be in a different color
# to attract more attention.
#
# - The [y/n] option will be added automatically to the question string.
# - The REPLY will contain 1 (y) or 0 (no).
#
# @param string the question to ask
# @param string (optional) the default answer if nothing is filled in.
#
# The result will be stored in the $REPLY variable.
##
function prompt_confirm {
  prompt_yn "${MAGENTA}$1" "$2"
}
