################################################################################
# Functionality to install the site or project.
################################################################################

##
# Install command information.
##
function install_info {
  echo
  markup_h1_divider
  markup_h1 " ${LWHITE}Install${LBLUE} website ${WHITE}$SITE_NAME${LBLUE} ($ENVIRONMENT)"
  markup_h1_divider

  if [ -d "$DIR_WEB" ]; then
    markup_h1_li "A backup of the web directory and the database will be created."
    markup_h1_li "The web directory will be deleted and all files will be destroyed."
    markup_h1_li "The database will be overwritten."
  fi

  markup_h1_li "Drupal core, contrib modules and themes will be downloaded."
  markup_h1_li "Drupal will be installed using the $SITE_PROFILE profile."
  markup_h1_divider
  echo
}

##
# The install script is finished information.
##
function install_finished {
  markup_h1_divider
  markup_success " Finished"
  markup_h1_divider
  markup_h1_li "Site Code : ${LWHITE}$DIR_WEB${RESTORE}"
  markup_h1_li "Site URL  : ${LWHITE}$SITE_URL${RESTORE}"
  markup_h1_divider
  echo
}
