################################################################################
# Functionality to install or update drush locally.
################################################################################


##
# Install (download) or (self-)update a local drush instance.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - init_drush_before : Scripts that should run before drush is
#   installed/updated.
# - init_drush_after  : Scripts that should run after drush is
#   installed/updated.
#
# The hooks will be called without and with environment suffix.
##
function init_drush_run {
  if [ $INIT_OPTION_SKIP_DRUSH -eq 1 ]; then
    markup_debug "Skipped : Install/Update drush."
    markup_debug
    return
  fi

  # Hook before install/update composer.
  hook_invoke "init_drush_before"

  markup_h1 "Install drush"

  if [ "$DRUSH_VERSION" == "global" ]; then
    markup_warning "Skip drush installation : globally installed drush will be used."

  elif [ "$DRUSH_VERSION" == "phar" ]; then
    init_drush_phar_with_force

    if [ ! -f "$DIR_BIN/packagist/drush.phar" ]; then
      curl -o "$DIR_BIN/packagist/drush.phar" http://files.drush.org/drush.phar
      chmod +x "$DIR_BIN/packagist/drush.phar"
      message_success "Drush downloaded to bin/packagist/drush.phar"
    else
      message_success "Drush was already downloaded to bin/packagist/drush.phar"
    fi

  else
    composer_skeleton_run require drush/drush:$DRUSH_VERSION --prefer-source
  fi

  echo

  # Hook after install/update composer.
  hook_invoke "init_drush_after"
}

##
# Check if the init command was called with force.
#
# This will delete downloaded files so the init command will be run as a new
# install.
##
function init_drush_phar_with_force {
  if [ $(option_is_set "-f") -ne 1 ] && [ $(option_is_set "--force") -ne 1 ]; then
    markup_debug "Init with force : No force used on druleton."
    markup_debug
    return
  fi

  if [ ! -f "$DIR_BIN/packagist/drush.phar" ]; then
    markup_debug "Init with force : No drush.phar file to delete."
    markup_debug
    return
  fi

  rm -f "$DIR_BIN/packagist/drush.phar"
  message_success "Init with force : drush.phar file is deleted."
  echo
}
