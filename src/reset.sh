################################################################################
# Functionality to reset a site or project.
################################################################################

##
# Pre reset script steps.
##
function reset_init {
  if [ "$DRUPAL_INSTALLED" -ne 1 ]; then
    markup_error "No drupal core available."
    echo "You need to run the bin/install script to install Drupal."
    exit
  fi
}

##
# Reset command information.
##
function reset_info {
  echo
  markup_h1_divider
  markup_h1 " ${LWHITE}Reset${LBLUE} website ${WHITE}$SITE_NAME${LBLUE} ($ENVIRONMENT)"
  markup_h1_divider
  markup_h1_li "The database will be deleted."
  markup_h1_li "The files directory will be deleted, all files will be destroyed."
  markup_h1_li "The settings.php file will be deleted."
  markup_h1_li "The database will be overwritten."
  markup_h1_li "This will install the website."
  markup_h1_divider
  echo
}

##
# The reset command is finished information.
##
function reset_finished {
  markup_h1_divider
  markup_success " Finished"
  markup_h1_divider
  markup_h1_li "Site Code : ${LWHITE}$DIR_WEB${RESTORE}"
  markup_h1_li "Site URL  : ${LWHITE}$SITE_URL${RESTORE}"
  markup_h1_divider
  echo
}

