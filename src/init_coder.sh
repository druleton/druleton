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
  # Check not skipped.
  if [ $INIT_OPTION_SKIP_CODER -eq 1 ]; then
    markup_debug "Skipped : Install/update drupal coder."
    markup_debug
    return
  fi

  markup_h1 "Install coder"

  # Check if not disabled.
  if [ "$CODER_DISABLED" = "1" ]; then
    markup_warning "drupal/coder is disabled."
    markup_info "Enable it by setting CODER_DISABLED=0 in config/config.sh."
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
