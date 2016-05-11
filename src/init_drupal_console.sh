################################################################################
# Functionality to install or update drupal console locally.
################################################################################


##
# Install (download) or (self-)update a local drupal console instance.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - init_drupal_console_before : Scripts that should run before drupal console
#   is installed/updated.
# - init_drupal_console_after  : Scripts that should run after drupal console
#   is installed/updated.
#
# The hooks will be called without and with environment suffix.
##
function init_drupal_console_run {
  if [ $INIT_OPTION_SKIP_DRUPAL_CONSOLE -eq 1 ]; then
    markup_debug "Skipped : Install/Update drupal console."
    markup_debug
    return
  fi

  # Hook before install/update composer.
  hook_invoke "init_drupal_console_before"

  markup_h1 "Install drupal console"

  if [ "$DRUPAL_CONSOLE_VERSION" == "global" ]; then
    markup_warning "Skip drupal console installation : globally installed drupal console will be used."

  elif [ "$DRUPAL_CONSOLE_VERSION" == "phar" ]; then
    init_drupal_console_phar_with_force

    if [ ! -f "$DIR_BIN/packagist/drupal.phar" ]; then
      curl https://drupalconsole.com/installer -L -o "$DIR_BIN/packagist/drupal.phar"
      chmod +x "$DIR_BIN/packagist/drupal.phar"
      message_success "Drush downloaded to bin/packagist/drupal.phar"
    else
      message_success "Drush was already downloaded to bin/packagist/drupal.phar"
    fi

  else
    composer_skeleton_run require drupal/console:$DRUPAL_CONSOLE_VERSION --prefer-source
  fi

  echo

  # Hook after install/update composer.
  hook_invoke "init_drupal_console_after"
}

##
# Check if the init command was called with force.
#
# This will delete downloaded files so the init command will be run as a new
# install.
##
function init_drupal_console_phar_with_force {
  if [ $(option_is_set "-f") -ne 1 ] && [ $(option_is_set "--force") -ne 1 ]; then
    markup_debug "Init with force : No force used on drupal.phar."
    markup_debug
    return
  fi

  if [ ! -f "$DIR_BIN/packagist/drupal.phar" ]; then
    markup_debug "Init with force : No drupal.phar file to delete."
    markup_debug
    return
  fi

  rm -f "$DIR_BIN/packagist/drupal.phar"
  message_success "Init with force : drupal.phar file is deleted."
  echo
}
