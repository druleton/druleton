################################################################################
# Functionality to init druleton.
################################################################################

##
# Initiate the init process.
##
function init_init {
  INIT_DRULETON_INSTALLED=$(init_druleton_check)
}

##
# Init info.
##
function init_info {
  echo
  markup_h1_divider
  markup_h1 " ${LWHITE}Initiate/update${LBLUE} environment for website ${WHITE}$SITE_NAME${LBLUE} ($ENVIRONMENT)"
  markup_h1_divider
  markup_h1_li "Composer will be installed or updated in the bin/ directory."
  markup_h1_li "Drush will be installed (or global installed drush will be used)."
  markup_h1_li "Any custom command will be included in the bin/ directory."
  markup_h1_divider
  echo
}

##
# The init script is finished information.
##
function build_finished {
  markup_h1_divider
  markup_success " Finished"
  markup_h1_divider
  echo
}

##
# Confirm the init process.
##
function init_confirm {
  if [ $CONFIRMED -eq 1 ]; then
    return
  fi

  prompt_confirm "Are you sure" "n"

  if [ $REPLY -ne 1 ]; then
    markup_warning "! Init aborted"
    echo
    exit 1
  fi

  echo
}

##
# Run the init script.
##
function init_run {
  # Partial init based on the given argument.
  case "$SCRIPT_ARGUMENT" in
    config)
      init_config_run
      ;;

    *)
      init_druleton_run
      init_config_run
      init_composer_run
      init_drush_run
      init_coder_run
      init_custom_commands_run
      ;;
  esac
}
