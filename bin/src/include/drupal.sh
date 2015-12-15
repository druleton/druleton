################################################################################
# Include script that holds helper functions about Drupal.
################################################################################


##
# Run drush from within the Drupal root ($DIR_WEB folder).
#
# Use this if you need to run the drush command from within the actual web root.
# Do not use it when installing the make files.
#
#
##
function drupal_drush {
  drupal_drush_run "$@" --root="$DIR_WEB"
}

##
# Run drush.
#
# This command will run by default the globally installed drush.
# If the $DRUSH_VERSION is set to a specific version, then it will expect drush
# to be installed using composer and will run drush from within the
# bin/vendor/bin directory.
##
function drupal_drush_run {
  local cmd_drush=""

  if [ -z "$DRUSH_VERSION" ] || [ "$DRUSH_VERSION" == "phar" ]; then
    cmd_drush="$DIR_BIN/packagist/drush.phar"
  elif [ "$DRUSH_VERSION" == "global" ]; then
    cmd_drush="drush"
  else
    cmd_drush="$DIR_BIN/packagist/vendor/bin/drush"
  fi

  $cmd_drush "$@"
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
