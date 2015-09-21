
################################################################################
# Bootstrap for the scripts, contains common startup steps.
#
# Defined variables after including this script:
#  $SCRIPT_NAME : the name of the called script (install, reset, update, ...).
#  $ENVIRONMENT : the environment for who we are running this script.
#  $DIR_CURRENT : the path from where the script is called.
#  $DIR_BIN     : the bin directory where the script is located.
#  $DIR_SRC     : the directory where all the include scripts are.
#  $DIR_ROOT    : the root of the project.
#  $DIR_PROJECT : the directory where the projects profiles, modules and themes
#                 are located.
#  $DIR_CONFIG  : the directory where all the config files are.
#  $DIR_WEB     : the directory where Drupal will be installed (web root).
#  $DIR_BACKUP  : the directory where backups will be stored.
#  $DIR_BUILD   : the directory where the build will be stored.
#  $DRUPAL_INSTALLED : Is there a working Drupal instalation 1/0.
#  $CONFIRMED   : is the --confirm or -y option passed to the script.
################################################################################


# Get the script name
SCRIPT_NAME=$( basename $0 )

# Get the environment.
ENVIRONMENT="dev"

# Define all paths.
DIR_CURRENT=${PWD}
DIR_SRC=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DIR_BIN=$( cd "$DIR_SRC/.." && pwd)
DIR_ROOT=$( cd "$DIR_BIN/.." && pwd )
DIR_PROJECT="$DIR_ROOT/project"
DIR_CONFIG="$DIR_ROOT/config"
DIR_WEB="$DIR_ROOT/web"
DIR_BACKUP="$DIR_ROOT/backup"
DIR_BUILD="$DIR_ROOT/build"


# Include helpers.
source "$DIR_SRC/include/options.sh"
source "$DIR_SRC/include/colors.sh"
source "$DIR_SRC/include/markup.sh"
source "$DIR_SRC/include/message.sh"
source "$DIR_SRC/include/hook.sh"
source "$DIR_SRC/include/drupal.sh"

# Load the config file.
source "$DIR_CONFIG/config.sh"


# Check if there is a working Drupal.
# Check if there is currently a working Drupal installation.
DRUPAL_INSTALLED=$( drupal_is_installed )

# Check if a confirmed option is given.
if [ $(option_is_set "--confirm") -eq 1 ] || [ $(option_is_set "-y") -eq 1 ]; then
  CONFIRMED=1
else
 CONFIRMED=0
fi

# Load Help.
source "$DIR_SRC/include/help.sh"
