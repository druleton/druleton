################################################################################
# Functionality to upgrade the site or project.
################################################################################

##
# Init the upgrade command.
##
function upgrade_init {
  # Check first if there is a Drupal core avaibale in the web folder.
  if [ "$DRUPAL_INSTALLED" -ne 1 ]; then
    markup_error "No drupal core available."
    echo "You need to run the bin/install script to install Drupal."
    exit
  fi
}

##
# Upgrade command information.
##
function upgrade_info {
  echo
  markup_h1_divider
  markup_h1 " ${LWHITE}Upgrade${LBLUE} website ${WHITE}$SITE_NAME${LBLUE} ($ENVIRONMENT)"
  markup_h1_divider
  markup_h1_li "A backup of the web directory and the database will be created."
  markup_h1_li "The web/sites/default dirctory will be put aside."
  markup_h1_li "The web directory will be deleted."
  markup_h1_li "Drupal core, contrib modules and themes will be downloaded."
  markup_h1_li "Drupal upgrade will be run."
  markup_h1_li "Drupal cache will be cleared."
  markup_h1_divider
  echo
}

##
# The upgrade script is finished information.
##
function upgrade_finished {
  markup_h1_divider
  markup_success " Finished"
  markup_h1_divider
  markup_h1_li "Site Code : ${LWHITE}$DIR_WEB${RESTORE}"
  markup_h1_li "Site URL  : ${LWHITE}$SITE_URL${RESTORE}"
  markup_h1_divider
  echo
}
