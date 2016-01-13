################################################################################
# Functionality to install or update drupal/coder locally.
################################################################################


##
# Install (or update) & configure drupal/coder packages.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - init_coder_before : Scripts that should run before coder is
#   installed/updated.
# - init_coder_after  : Scripts that should run after coder is
#   installed/updated.
#
# The hooks will be called without and with environment suffix.
# The hooks will only be called if installing coder is not disabled.
##
function init_coder_run {
  markup_h1 "Install coder."

  # Check if not disabled.
  if [ ! -z "$CODER_DISABLED" ]; then
    message_warning "Installing drupal/coder is disabled."
    markup " > Enable it by setting CODER_DISABLED=0 in config/config.sh."
    echo
    return
  fi


  # Hook before install/update composer.
  hook_invoke "init_coder_before"

  # Install drupal/coder.
  composer_skeleton_run require drupal/coder

  # Register the drupal coding standards to phpcs.
  "$DIR_BIN/packagist/vendor/bin/phpcs" \
    --config-set installed_paths \
    "$DIR_BIN/packagist/vendor/drupal/coder/coder_sniffer"

  echo

  # Hook after install/update composer.
  hook_invoke "init_coder_after"
}
