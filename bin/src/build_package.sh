################################################################################
# Include script that runs the code to login into Drupal from CLI and open the
# site in the default browser.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - build_package_before : Scripts that should run before the package is
#                          created.
# - build_package_after  : Scripts that should run after the package is created.
################################################################################


if [ $(option_is_set "--no-package") -ne 1 ]; then

  # Run any script before the package is created.
  hook_invoke "build_package_before"


  markup_h1 "Package the build"

  cd "$DIR_BUILD"

  BUILD_PACKAGE_NAME="${SITE_NAME// /_}-$(date +%Y%m%d_%H%M%S).tar.gz"

  if [ ! -z $SCRIPT_ARGUMENT ]; then
    BUILD_PACKAGE_NAME="${SCRIPT_ARGUMENT// /_}.tar.gz"
  fi

  # Cleanup old build package.
  if [ -f "$DIR_BUILD/$BUILD_PACKAGE_NAME" ]; then
    markup_debug "Remove old build package."
    rm "$DIR_BUILD/$BUILD_PACKAGE_NAME"
  fi

  tar -czf "$BUILD_PACKAGE_NAME" "web"
  if [ $? -ne 1 ]; then
    message_success "Package created"
    markup_debug "Package : $BUILD_PACKAGE_NAME"
  else
    message_error "Error while creating package"
  fi

  rm -R web

  echo


  # Run any script after the package is created.
  hook_invoke "build_package_after"

else
  markup_debug "Build not packaged." 1
fi
