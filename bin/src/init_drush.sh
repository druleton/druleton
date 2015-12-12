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
  # Hook before install/update composer.
  hook_invoke "init_drush_before"

  markup_h1 "Install drush."
  composer_skeleton_run require drush/drush:dev-master --prefer-source
  echo

  # Hook after install/update composer.
  hook_invoke "init_drush_after"
}
