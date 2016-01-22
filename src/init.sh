################################################################################
# Functionality to init druleton.
################################################################################

##
# Initiate the init process.
##
function init_init {
  # Default everything is skipped.
  INIT_OPTION_SKIP_STRUCTURE=1
  INIT_OPTION_SKIP_DRULETON=1
  INIT_OPTION_SKIP_CONFIG=1
  INIT_OPTION_SKIP_COMPOSER=1
  INIT_OPTION_SKIP_DRUSH=1
  INIT_OPTION_SKIP_CODER=1
  INIT_OPTION_SKIP_CUSTOM=1

  # Check if a specific argument was provided.
  case "$SCRIPT_ARGUMENT" in
    structure)
      INIT_OPTION_SKIP_STRUCTURE=0
      ;;

    druleton)
      INIT_OPTION_SKIP_DRULETON=0
      ;;

    config)
      INIT_OPTION_SKIP_CONFIG=0
      ;;

    composer)
      INIT_OPTION_SKIP_COMPOSER=0
      ;;

    drush)
      INIT_OPTION_SKIP_DRUSH=0
      ;;

    coder)
       INIT_OPTION_SKIP_CODER=0
       ;;

    custom)
      INIT_OPTION_SKIP_CUSTOM=0
      ;;

    "")
      # No option, check --skip- options.
      INIT_OPTION_SKIP_STRUCTURE=$(option_is_set "--skip-structure")
      INIT_OPTION_SKIP_DRULETON=$(option_is_set "--skip-druleton")
      INIT_OPTION_SKIP_CONFIG=$(option_is_set "--skip-config")
      INIT_OPTION_SKIP_COMPOSER=$(option_is_set "--skip-composer")
      INIT_OPTION_SKIP_DRUSH=$(option_is_set "--skip-drush")
      INIT_OPTION_SKIP_CODER=$(option_is_set "--skip-coder")
      INIT_OPTION_SKIP_CUSTOM=$(option_is_set "--skip-custom")
      ;;

    *)
      # Other arguments not supported!
      message_warning "Argument ${LRED}${SCRIPT_ARGUMENT}${RED} not supported!"
      ;;

  esac
}

##
# Init info.
##
function init_info {
  echo
  markup_h1_divider
  markup_h1 " ${LWHITE}Initiate/update${LBLUE} environment for website ${WHITE}$SITE_NAME${LBLUE} ($ENVIRONMENT)"
  markup_h1_divider

  if [ $INIT_OPTION_SKIP_STRUCTURE -ne 1 ]; then
    markup_h1_li "Check if the project structure is in place (created if not)."
  fi
  if [ $INIT_OPTION_SKIP_DRULETON -ne 1 ]; then
    markup_h1_li "Update druleton if installed as submodule."
  fi
  if [ $INIT_OPTION_SKIP_CONFIG -ne 1 ]; then
    markup_h1_li "Set/Update configuration."
  fi
  if [ $INIT_OPTION_SKIP_COMPOSER -ne 1 ]; then
    markup_h1_li "Composer will be installed or updated in the bin/ directory."
  fi
  if [ $INIT_OPTION_SKIP_DRUSH -ne 1 ]; then
    markup_h1_li "Drush will be installed (or global installed drush will be used)."
  fi
  if [ $INIT_OPTION_SKIP_CODER -ne 1 ]; then
    markup_h1_li "Drupal coder will be installed or updated."
  fi
  if [ $INIT_OPTION_SKIP_CUSTOM -ne 1 ]; then
    markup_h1_li "Any custom command will be included in the bin/ directory."
  fi

  markup_h1_divider
  echo
}

##
# The init script is finished information.
##
function init_finished {
  markup_h1_divider
  markup_success " Finished"
  markup_h1_divider
  echo
}
