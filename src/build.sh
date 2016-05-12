################################################################################
# Functionality to compress a build into a tarbal.
################################################################################

##
# Build command information.
##
function build_info {
  echo
  markup_h1_divider
  markup_h1 " ${LWHITE}Build${LBLUE} website ${WHITE}$SITE_NAME${LBLUE} ($ENVIRONMENT)"
  markup_h1_divider
  markup_h1_li "Drupal core, contrib modules and themes will be downloaded."
  markup_h1_li "Custom profiles, modules & themes will be copied into the site structure."
  markup_h1_li "The site will not be installed."

  if [ -d "$DIR_BUILD/current" ]; then
    markup_h1_li "The previous build will be deleted and overwritten."
  fi

  markup_h1_divider
  echo
}

##
# The build script is finished information.
##
function build_finished {
  markup_h1_divider
  markup_success " Finished"
  markup_h1_divider
  if [ -z "$BUILD_PACKAGE_NAME" ]; then
    markup_h1_li "Build directory : ${LWHITE}${DIR_BUILD}/current${RESTORE}"
  else
    markup_h1_li "Build file : ${LWHITE}${BUILD_PACKAGE_NAME}${RESTORE}"
    markup_h1_li "Directory  : ${LWHITE}${DIR_BUILD}${RESTORE}"
  fi
  markup_h1_divider
  echo
}

##
# Check (and create if not) if the build directory exists.
##
function build_check_directory {
  if [ -d "$DIR_BUILD" ]; then
    mkdir -p "$DIR_BUILD"
    markup_debug "Build directory created." 1
  fi
}

##
# Build the drupal package using the composer files.
##
function build_drupal_composer {
  # Create current build folder in build directory.
  mkdir -p "$DIR_BUILD/current"

  # Copy composer files to build directory.
  build_drupal_composer_copy_composer_files

  # Change the $DIR_ROOT to the build folder while we run the composer file.
  DIR_ROOT_NORMAL="$DIR_ROOT"
  DIR_WEB_NORMAL="$DIR_WEB"
  DIR_ROOT="$DIR_BUILD/current"
  DIR_WEB="$DIR_BUILD/current/web"

  drupal_composer_run

  # Reset $DIR_ROOT and $DIR_WEB.
  DIR_ROOT="$DIR_ROOT_NORMAL"
  DIR_WEB="$DIR_WEB_NORMAL"

  # Cleanup composer files in current build folder.
  build_drupal_composer_cleanup_composer_files
}

##
# Copy the composer files from the DIR_ROOT to the DIR_BUILD in order to
# be able to run them there.
##
function build_drupal_composer_copy_composer_files {
  COMPOSER_FILE="$DIR_ROOT/composer.json"
  COMPOSER_LOCK_FILE="$DIR_ROOT/composer.lock"
  COMPOSER_SCRIPTS_FOLDER="$DIR_ROOT/scripts"

  if [ -f "$COMPOSER_FILE" ]; then
    message_success "Composer: composer.json file copied to current build folder"
    cp -f $COMPOSER_FILE "$DIR_BUILD/current/composer.json"
  else
    message_error "Error while copying the composer.json file"
    return
  fi

  if [ -f "$COMPOSER_LOCK_FILE" ]; then
    message_success "Composer: composer.lock file copied to current build folder"
    cp -f $COMPOSER_LOCK_FILE "$DIR_BUILD/current/composer.lock"
  fi

  if [ -d "$COMPOSER_SCRIPTS_FOLDER" ]; then
    message_success "Composer: scripts folder copied to current build folder"
    cp -rf $COMPOSER_SCRIPTS_FOLDER "$DIR_BUILD/current/scripts"
  fi
}

##
# Cleanup the composer files from the current build folder as we don't
# need them for packaging.
##
function build_drupal_composer_cleanup_composer_files {
  COMPOSER_FILE="$DIR_BUILD/current/composer.json"
  COMPOSER_LOCK_FILE="$DIR_BUILD/current/composer.lock"
  COMPOSER_SCRIPTS_FOLDER="$DIR_BUILD/current/scripts"

  if [ -f "$COMPOSER_FILE" ]; then
    message_success "Composer: composer.json removed from current build folder"
    rm -f $COMPOSER_FILE
  fi

  if [ -f "$COMPOSER_LOCK_FILE" ]; then
    message_success "Composer: composer.lock file removed from current build folder"
    rm -f $COMPOSER_LOCK_FILE
  fi

  if [ -d "$COMPOSER_SCRIPTS_FOLDER" ]; then
    message_success "Composer: scripts folder removed from current build folder"
    rm -rf $COMPOSER_SCRIPTS_FOLDER
  fi
}

##
# Function to create a package from the build result.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - build_package_before : Scripts that should run before the package is
#                          created.
# - build_package_after  : Scripts that should run after the package is created.
#
# The hooks will be called without and with environment suffix.
##
function build_package_run {
  if [ $(option_is_set "--no-package") -eq 1 ]; then
    markup_debug "Build not packaged (--no-package)." 1
    return
  fi

  hook_invoke "build_package_before"

  cd "$DIR_BUILD"
  markup_h1 "Package the build"

  # Create the package name (from argument of fallback to date).
  BUILD_PACKAGE_NAME="${SITE_NAME// /_}-$(date +%Y%m%d_%H%M%S).tar.gz"
  if [ ! -z $SCRIPT_ARGUMENT ]; then
    BUILD_PACKAGE_NAME="${SCRIPT_ARGUMENT// /_}.tar.gz"
  fi

  # Cleanup old build package.
  if [ -f "$DIR_BUILD/$BUILD_PACKAGE_NAME" ]; then
    markup_debug "Remove old build package."
    rm "$DIR_BUILD/$BUILD_PACKAGE_NAME"
  fi

  # Create the package.
  tar -czf "$BUILD_PACKAGE_NAME" -C "current" .
  if [ $? -ne 1 ]; then
    message_success "Package created."
    markup_debug "Package : $BUILD_PACKAGE_NAME"
  else
    message_error "Error while creating package"
  fi

  # Remove the current build directory as this is now part of the package.
  rm -R current
  if [ $? -ne 1 ]; then
    message_success "Cleaned up the build directory."
  else
    message_error "Error while removing the build directory."
  fi

  echo

  hook_invoke "build_package_after"
}
