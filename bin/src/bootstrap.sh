
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


# Check if there is currently a working Drupal installation.
DRUPAL_INSTALLED=0
DRUPAL_INSTALLED_SUCCESS=`drush --root="$DIR_WEB" \
status grep "Drupal bootstrap" \
| grep "Successful"`
if [[ "$DRUPAL_INSTALLED_SUCCESS" != "" ]]; then
  DRUPAL_INSTALLED=1
fi


# Include helpers.
source "$DIR_SRC/include/colors.sh"
source "$DIR_SRC/include/markup.sh"
source "$DIR_SRC/include/message.sh"
source "$DIR_SRC/include/hook.sh"

# Load the config file.
source "$DIR_CONFIG/config.sh"
