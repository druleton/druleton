################################################################################
# Include script that holds the color definitions for text.
################################################################################

# Define the colors only if the are wanted.
if [ $( option_is_set "--no-color" ) -ne 1 ]; then

  # Restore to default colours
  RESTORE='\033[0m'

  # Simple colors
  BLACK='\033[00;30m'
  RED='\033[00;31m'
  GREEN='\033[00;32m'
  YELLOW='\033[00;33m'
  BLUE='\033[00;34m'
  MAGENTA='\033[00;35m'
  CYAN='\033[00;36m'
  WHITE='\033[00;37m'
  GREY='\033[01;30m'

  # Bold (lighter)
  LBLACK='\033[01;30m'
  LRED='\033[01;31m'
  LGREEN='\033[01;32m'
  LYELLOW='\033[01;33m'
  LBLUE='\033[01;34m'
  LMAGENTA='\033[01;35m'
  LCYAN='\033[01;36m'
  LWHITE='\033[01;37m'

  # Predefined background colours
  BGBLACK='\033[00;40;37m'
  BGRED='\033[00;41;37m'
  BGGREEN='\033[00;42;30m'
  BGYELLOW='\033[00;43;30m'
  BGBLUE='\033[00;44;37m'
  BGMAGENTA='\033[00;45;30m'
  BGCYAN='\033[00;46;30m'
  BGWHITE='\033[00;47;30m'

  # Predefined background colours with lighter foreground
  BGLBLACK='\033[01;40;37m'
  BGLRED='\033[01;41;37m'
  BGLGREEN='\033[01;42;37m'
  BGLYELLOW='\033[01;43;37m'
  BGLBLUE='\033[01;44;37m'
  BGLMAGENTA='\033[01;45;37m'
  BGLCYAN='\033[01;46;37m'
  BGLWHITE='\033[01;47;30m'

fi
