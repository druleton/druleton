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
  # Fallback to dev-master if no configuration found.
  if [ -z "$DRUSH_VERSION" ]; then
    DRUSH_VERSION="dev-master"
  fi

  # Hook before install/update composer.
  hook_invoke "init_drush_before"

  markup_h1 "Install drush."
  if [ "$DRUSH_VERSION" == "global" ]; then
    markup_warning "Skip drush installation : globally installed drush will be used."
  else
    composer_skeleton_run require drush/drush:$DRUSH_VERSION --prefer-source
  fi

  echo

  # Hook after install/update composer.
  hook_invoke "init_drush_after"
}
