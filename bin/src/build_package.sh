################################################################################
# Functionality to compress a build into a tarbal.
################################################################################


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
