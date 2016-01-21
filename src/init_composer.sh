################################################################################
# Functionality to install or update composer locally.
################################################################################


##
# Install (download) or (self-)update a local composer instance.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - init_composer_before : Scripts that should run before composer is
#   installed/updated.
# - init_composer_after  : Scripts that should run after composer is
#   installed/updated.
#
# The hooks will be called without and with environment suffix.
##
function init_composer_run {
  # Hook before install/update composer.
  hook_invoke "init_composer_before"

  init_composer_with_force

  if [ -d "$DIR_BIN/packagist" ]; then
    init_composer_update
    echo
    init_composer_init
    echo
    init_composer_update_packages
    echo
  else
    init_composer_install
    echo
    init_composer_init
    echo
  fi

  # Hook after install/update composer.
  hook_invoke "init_composer_after"
}

##
# Check if the init command was called with force.
#
# This will delete downloaded files so the init command will be run as a new
# install.
##
function init_composer_with_force {
  if [ $(option_is_set "-f") -ne 1 ] && [ $(option_is_set "--force") -ne 1 ]; then
    markup_debug "Init with force : No force used on druleton."
    markup_debug
    return
  fi

  if [ ! -d "$DIR_BIN/packagist" ]; then
    markup_debug "Init with force : No bin/packagist directory to delete."
    markup_debug
    return
  fi

  rm -Rf "$DIR_BIN/packagist"
  message_success "Init with force : bin/packagist directory is deleted."
  echo
}

##
# Install composer by downloading phar file locally.
##
function init_composer_install {
  markup_h1 "Install composer."
  mkdir -p "$DIR_BIN/packagist"

  if [ "$COMPOSER_USE_GLOBAL" = "1" ]; then
    markup_warning "Skip composer installation : globally installed composer will be used."
  else
    curl -sS https://getcomposer.org/installer \
      | php -- --install-dir="$DIR_BIN/packagist"
  fi
}

##
# Update composer.
##
function init_composer_update {
  # Check first if already installed.
  if [ "$COMPOSER_USE_GLOBAL" != "1" ] &&
  [ ! -f "$DIR_BIN/packagist/composer.phar" ]; then
    init_composer_install
    return
  fi

  markup_h1 "Update composer."

  if [ "$COMPOSER_USE_GLOBAL" != "1" ]; then
    composer_skeleton_run self-update
  else
    markup_warning "Skip composer update : globally installed composer is in use."
  fi
}

##
# Initiate the composer environment.
##
function init_composer_init {
  markup_h1 "Initiate composer."

  if [ -f "$DIR_BIN/packagist/composer.json" ]; then
    message_success "Composer was already initiated."
  else
    composer_skeleton_run -n init \
      --name="druleton/bin" \
      --description="PHP packages needed by druleton." \
      --author="zero2one <zero2one@serial-graphics.be>" \
      --homepage="https://github.com/zero2one/druleton" \
      --license="MIT" \
      --type="library"
    message_success "Composer is initiated"
  fi
}

##
# Update the composer packages.
##
function init_composer_update_packages {
  markup_h1 "Update installed composer packages"
  composer_skeleton_run update
}
