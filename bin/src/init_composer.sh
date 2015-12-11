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

  if [ -f "$DIR_BIN/composer" ]; then
    init_composer_update
  else
    init_composer_install
  fi

  echo

  # Hook after install/update composer.
  hook_invoke "init_composer_after"
}

##
# Install composer by downloading phar file locally.
##
function init_composer_install {
  markup_h1 "Install composer."
  curl -sS https://getcomposer.org/installer \
    | php -- --install-dir="$DIR_BIN" --filename=composer
}

##
# Update composer.
##
function init_composer_update {
  markup_h1 "Update composer."
  $DIR_BIN/composer self-update
}
