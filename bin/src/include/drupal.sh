################################################################################
# Include script that holds helper functions about Drupal.
################################################################################


##
# Run drush from within the Drupal root ($DIR_WEB folder).
#
# Use this if you need to run the drush command from within the actual web root.
# Do not use it when instaling the make files.
##
function drupal_drush {
  drush --root="$DIR_WEB" "$@"
}


##
# Check if there is a working Drupak installation.
#
# @return is installed 1/0
##
function drupal_is_installed {
  drupal_is_installed_string=`drupal_drush status grep "Drupal bootstrap" \
    | grep "Successful"`

  if [[ "$drupal_is_installed_string" != "" ]]; then
    echo 1
    return
  fi

  echo 0
}


##
# Remove the protection from the sites/default directory.
##
function drupal_sites_default_unprotect {
  if [ -d "$DIR_WEB/sites/default" ]; then
    chmod -R u+w "$DIR_WEB/sites/default"
  fi
}

##
# Restore the protection of the sites/default directory.
##
function drupal_sites_default_protect {
  if [ -f "$DIR_WEB/sites/default/settings.php" ]; then
    chmod a-w "$DIR_WEB/sites/default/settings.php"
  fi

  if [ -d "$DIR_WEB/sites/default" ]; then
    chmod a-w "$DIR_WEB/sites/default"
  fi
}
