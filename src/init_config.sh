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

  # Check first if there is already a config file.
  if [ -f "$DIR_CONFIG/config.sh" ]; then
    message_success "Config file already in place."

    # If not installed with force, end here.
    if [ $(option_is_set "-f") -ne 1 ] && [ $(option_is_set "--force") -ne 1 ]; then
      return
    fi
  else
    # No config file, create on based on the config_example.sh file.
    cp "$DIR_CONFIG/config_example.sh" "$DIR_CONFIG/config.sh"

    # Check if the file could be copied.
    if [ ! -f "$DIR_CONFIG/config.sh" ]; then
      message_error "No config file available."
      echo
      exit 1
    fi

    message_success "Config created based on the config/config_example.sh file."
    echo
  fi

  init_config_file
  source "$DIR_CONFIG/config.sh"
  echo
}

##
# Ask and fill in the config variables.
##
function init_config_file {
  init_config_load_current

  INIT_CONFIG_CONFIRMED=0
  while [ $INIT_CONFIG_CONFIRMED -ne 1 ]; do
    init_config_collect
    init_config_confirm
  done

  init_config_save
}

##
# Load the current config
##
function init_config_load_current {
  source "${DIR_CONFIG}/config.sh"

  INIT_CONFIG_SITE_NAME="${SITE_NAME}"
  INIT_CONFIG_SITE_URL="${SITE_URL}"
  INIT_CONFIG_SITE_PROFILE="${SITE_PROFILE}"

  INIT_CONFIG_DB_USER="${DB_USER}"
  INIT_CONFIG_DB_PASS="${DB_PASS}"
  INIT_CONFIG_DB_NAME="${DB_NAME}"
  INIT_CONFIG_DB_HOST="${DB_HOST}"

  INIT_CONFIG_ACCOUNT_NAME="${ACCOUNT_NAME}"
  INIT_CONFIG_ACCOUNT_PASS="${ACCOUNT_PASS}"
  INIT_CONFIG_ACCOUNT_MAIL="${ACCOUNT_MAIL}"

  # Allow project specific config file variables.
  hook_invoke "config_load_current"

  INIT_CONFIG_COMPOSER_USE_GLOBAL="${COMPOSER_USE_GLOBAL}"
  INIT_CONFIG_DRUSH_VERSION="${DRUSH_VERSION}"
  INIT_CONFIG_CODER_DISABLED="${CODER_DISABLED}"
}

##
# Gather the configuration parameters.
##
function init_config_collect {
  markup_h1 "Collect config variables"
  markup_h2 "Website details"
  markup_prompt "The name of the site" "${INIT_CONFIG_SITE_NAME}"
  INIT_CONFIG_SITE_NAME="${REPLY:-$INIT_CONFIG_SITE_NAME}"
  markup_prompt "The url where the website will be hosted" "${INIT_CONFIG_SITE_URL}"
  INIT_CONFIG_SITE_URL="${REPLY:-$INIT_CONFIG_SITE_URL}"
  markup_prompt "The drupal install profile" "${INIT_CONFIG_SITE_PROFILE}"
  INIT_CONFIG_SITE_PROFILE="${REPLY:-$INIT_CONFIG_SITE_PROFILE}"
  echo

  markup_h2 "Database credentials"
  markup_prompt "Database username" "${INIT_CONFIG_DB_USER}"
  INIT_CONFIG_DB_USER="${REPLY:-$INIT_CONFIG_DB_USER}"
  markup_prompt "Database password" "${INIT_CONFIG_DB_PASS}"
  INIT_CONFIG_DB_PASS="${REPLY:-$INIT_CONFIG_DB_PASS}"
  markup_prompt "Database name" "${INIT_CONFIG_DB_NAME}"
  INIT_CONFIG_DB_NAME="${REPLY:-$INIT_CONFIG_DB_NAME}"
  markup_prompt "Database hostname or IP address" "$INIT_CONFIG_DB_HOST"
  INIT_CONFIG_DB_HOST="${REPLY:-$INIT_CONFIG_DB_HOST}"
  echo

  markup_h2 "Drupal administrator account"
  markup_prompt "Administrator username" "${INIT_CONFIG_ACCOUNT_NAME}"
  INIT_CONFIG_ACCOUNT_NAME="${REPLY:-$INIT_CONFIG_ACCOUNT_NAME}"
  markup_prompt "Administrator password" "${INIT_CONFIG_ACCOUNT_PASS}"
  INIT_CONFIG_ACCOUNT_PASS="${REPLY:-$INIT_CONFIG_ACCOUNT_PASS}"
  local default_account_mail="${INIT_CONFIG_ACCOUNT_NAME}@${INIT_CONFIG_SITE_URL}"
  markup_prompt "Administrator email address" "${default_account_mail}"
  INIT_CONFIG_ACCOUNT_MAIL="${REPLY:-$default_account_mail}"
  echo

  # Allow project specific config file variables.
  hook_invoke "config_collect"

  markup_h2 "Druleton options"
  local composer_use_global_yn="n"
  if [ "$INIT_CONFIG_COMPOSER_USE_GLOBAL" = "1" ]; then
    composer_use_global_yn="y"
  fi
  markup_prompt "Use global composer instead of a local copy [y/n]" "${composer_use_global_yn}"
  REPLY="${REPLY:-$composer_use_global_yn}"
  if [[ $REPLY =~ ^[Yy1]$ ]]; then
    INIT_CONFIG_COMPOSER_USE_GLOBAL=1
  else
    INIT_CONFIG_COMPOSER_USE_GLOBAL=0
  fi

  local drush_version_to_use="${INIT_CONFIG_DRUSH_VERSION:-phar}"
  markup_prompt "Drush version to use [phar/global/branch name]" "${drush_version_to_use}"
  INIT_CONFIG_DRUSH_VERSION="${REPLY:-$drush_version_to_use}"

  local coder_disabled_yn="n"
  if [ "$INIT_CONFIG_CODER_DISABLED" = "1" ]; then
    coder_disabled_yn="y"
  fi
  markup_prompt "Do not install drupal coder (y/n)?" "${coder_disabled_yn}"
  REPLY="${REPLY:-$coder_disabled_yn}"
  if [[ $REPLY =~ ^[Yy1]$ ]]; then
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

  # Allow project specific config file variables.
  hook_invoke "config_confirm"

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

  init_config_save_variable "SITE_NAME" "${INIT_CONFIG_SITE_NAME}"
  init_config_save_variable "SITE_URL" "${INIT_CONFIG_SITE_URL}"
  init_config_save_variable "SITE_PROFILE" "${INIT_CONFIG_SITE_PROFILE}"

  init_config_save_variable "DB_USER" "${INIT_CONFIG_DB_USER}"
  init_config_save_variable "DB_PASS" "${INIT_CONFIG_DB_PASS}"
  init_config_save_variable "DB_NAME" "${INIT_CONFIG_DB_NAME}"
  init_config_save_variable "DB_HOST" "${INIT_CONFIG_DB_HOST}"

  init_config_save_variable "ACCOUNT_NAME" "${INIT_CONFIG_ACCOUNT_NAME}"
  init_config_save_variable "ACCOUNT_PASS" "${INIT_CONFIG_ACCOUNT_PASS}"
  init_config_save_variable "ACCOUNT_MAIL" "${INIT_CONFIG_ACCOUNT_MAIL}"

  # Allow project specific config file variables.
  hook_invoke "config_save"

  init_config_save_variable "COMPOSER_USE_GLOBAL" "${INIT_CONFIG_COMPOSER_USE_GLOBAL}"
  init_config_save_variable "DRUSH_VERSION" "${INIT_CONFIG_DRUSH_VERSION}"
  init_config_save_variable "CODER_DISABLED" "${INIT_CONFIG_CODER_DISABLED}"

  message_success "Configuration is saved"
  echo
}

##
# Write a single variable value to the config file.
#
# @param string The variable name
# @param string The variable value
##
function init_config_save_variable {
  local file="${DIR_CONFIG}/config.sh"
  local isInteger='^[0-9]+$'

  local key="$1"
  local value="$2"

  local valueString="\"${value}\""
  local pattern="s/^\(${key}=\).*/\1\"${value}\"/"

  # Do not quote integers.
  if [[ $value =~ $isInteger ]]; then
    local pattern="s/^\(${key}=\).*/\1${value}/"
    local valueString="${value}"
  fi

  # Overwrite or append
  if [ "$(cat "${file}" | grep "^${key}=")" != "" ]; then
    sed -i.bak "${pattern}" "${file}"
    rm "${DIR_CONFIG}/config.sh.bak"
  else
    echo "${key}=${valueString}" >> "${file}"
  fi
}
