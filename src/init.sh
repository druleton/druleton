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
# Confirm the init process.
##
function init_confirm {
  if [ $CONFIRMED -ne 1 ]; then
    markup_prompt "Are you sure [y/n]?" "n"

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      markup_warning "! Init aborted"
      echo
      exit 1
    fi
    echo
  fi
}
