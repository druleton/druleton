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

  if [ -d "$DIR_BUILD/web" ]; then
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
    markup_h1_li "Build directory : ${LWHITE}${DIR_BUILD}/web${RESTORE}"
  else
    markup_h1_li "Build file : ${LWHITE}${BUILD_PACKAGE_NAME}${RESTORE}"
    markup_h1_li "Directory  : ${LWHITE}${DIR_BUILD}${RESTORE}"
  fi
  markup_h1_divider
  echo
}

##
# Confirm the build command.
##
function build_confirm {
  if [ $CONFIRMED -eq 1 ]; then
    return
  fi

  prompt_confirm "Are you sure" "n"

  if [ $REPLY -ne 1 ]; then
    markup_warning "! Build aborted"
    echo
    exit 1
  fi

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
# Build the drupal package using the make files.
##
function build_drupal_make {
  # Change the $DIR_WEB to the build folder while we run the make files.
  DIR_WEB_NORMAL="$DIR_WEB"
  DIR_WEB="$DIR_BUILD/web"
  drupal_make_run
  DIR_WEB="$DIR_WEB_NORMAL"
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
  tar -czf "$BUILD_PACKAGE_NAME" "web"
  if [ $? -ne 1 ]; then
    message_success "Package created."
    markup_debug "Package : $BUILD_PACKAGE_NAME"
  else
    message_error "Error while creating package"
  fi

  # Remove the web directory as this is now part of the package.
  rm -R web
  if [ $? -ne 1 ]; then
    message_success "Cleaned up the build directory."
  else
    message_error "Error while removing the build directory."
  fi

  echo

  hook_invoke "build_package_after"
}
