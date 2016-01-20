################################################################################
# Functionality to install or update the configuration file.
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
function init_config_run {
  markup_h1 "Configure druleton."

  # Hook before install/update composer.
  hook_invoke "init_config_before"

  INIT_CONFIG_CONFIRMED=0
  while [ $INIT_CONFIG_CONFIRMED -ne 1 ]; do
    init_config_collect
    init_config_confirm
  done

  init_config_save

  # Hook after install/update composer.
  hook_invoke "init_config_after"
}

##
# Gather the configuration parameters.
##
function init_config_collect {
  markup_h2 "Website details"

  markup_prompt "The name of the site" "My Website"
  INIT_CONFIG_SITE_NAME="${REPLY:-My Website}"

  markup_prompt "The url where the website will be hosted"
  INIT_CONFIG_SITE_URL="$REPLY"

  markup_prompt "The drupal install profile" "default"
  INIT_CONFIG_SITE_PROFILE="${REPLY:-default}"

  echo

  markup_h2 "Database credentials"
  markup_prompt "Database username"
  INIT_CONFIG_DB_USER="$REPLY"
  markup_prompt "Database password"
  INIT_CONFIG_DB_PASS="$REPLY"
  markup_prompt "Database name"
  INIT_CONFIG_DB_NAME="$REPLY"
  markup_prompt "Database hostname or IP address"
  INIT_CONFIG_DB_HOST="$REPLY"

  echo

  markup_h2 "Drupal administrator account"
  markup_prompt "Administrator username" "admin"
  INIT_CONFIG_ACCOUNT_NAME="${REPLY:-admin}"

  markup_prompt "Administrator password" "drupal"
  INIT_CONFIG_ACCOUNT_PASS="${REPLY:-drupal}"

  local default_account_mail="${INIT_CONFIG_ACCOUNT_NAME}@${INIT_CONFIG_SITE_URL}"
  markup_prompt "Administrator email address" "${default_account_mail}"
  INIT_CONFIG_ACCOUNT_MAIL="${REPLY:-$default_account_mail}"

  echo

  markup_h2 "Druleton options"
  markup_prompt "Use global composer instead of a local copy [y/n]" "n"
  if [[ $REPLY =~ ^[Yy1]$ ]]; then
    INIT_CONFIG_COMPOSER_USE_GLOBAL=1
  else
    INIT_CONFIG_COMPOSER_USE_GLOBAL=0
  fi

  markup_prompt "Drush version to use [phar/global/branch name]" "phar"
  INIT_CONFIG_DRUSH_VERSION="${REPLY:-phar}"
  markup_prompt "Install drupal coder to check code style (y/n)?" "y"
  if [[ $REPLY =~ ^[Nn0]$ ]]; then
    INIT_CONFIG_CODER_DISABLED=1
  else
    INIT_CONFIG_CODER_DISABLED=0
  fi

  echo
}

##
# Confirm the collected config data.
##
function init_config_confirm {
  markup_h1 "Confirm configuration"
  markup_h2 "Website details"
  markup_li_value "Name" "${INIT_CONFIG_SITE_NAME:--}"
  markup_li_value "URL" "${INIT_CONFIG_SITE_URL:--}"
  markup_li_value "Install profile" "${INIT_CONFIG_SITE_PROFILE:--}"
  markup_h2 "Database credentials"
  markup_li_value "Username" "${INIT_CONFIG_DB_USER:--}"
  markup_li_value "Password" "${INIT_CONFIG_DB_PASS:--}"
  markup_li_value "Database name" "${INIT_CONFIG_DB_NAME:--}"
  markup_li_value "hostname/IP address" "${INIT_CONFIG_DB_HOST:--}"
  markup_h2 "Drupal administrator account"
  markup_li_value "username" "${INIT_CONFIG_ACCOUNT_NAME:--}"
  markup_li_value "password" "${INIT_CONFIG_ACCOUNT_PASS:--}"
  markup_li_value "email address" "${INIT_CONFIG_ACCOUNT_MAIL:--}"
  markup_h2 "Druleton options"
  markup_li_value "Use global composer" "${INIT_CONFIG_COMPOSER_USE_GLOBAL:--}"
  markup_li_value "Drush version to use" "${INIT_CONFIG_DRUSH_VERSION:--}"
  markup_li_value "Disable coder installation" "${INIT_CONFIG_CODER_DISABLED:--}"

  echo
  markup_prompt "Is this data correct [y/n]?"
  if [[ $REPLY =~ ^[Yy1]$ ]]; then
    INIT_CONFIG_CONFIRMED=1
  else
    INIT_CONFIG_CONFIRMED=0
  fi

  echo
}

##
# Write the collected configuration variables to the config file.
##
function init_config_save {
  markup_h1 "Save configuration"
  message_success "Configuration is saved"
  echo
}
