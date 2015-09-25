################################################################################
# Include script that restores the sites/default directory from
#   backup/sites-default
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - restore_sites_default_before : Scripts that should run before the restore is
#                                  performed.
# - restore_sites_default_after  : Scripts that should run after the backup is
#                                  performed.
################################################################################


# Run any script before we run the restore.
hook_invoke restore_sites_default_before


##
# Script to take the restore the sites/default directory
##
function restore_sites_default_run {
  markup_h1 "Move sites/default back into place."

  if [ -f "$DIR_BACKUP/sites-default" ]; then
    return 1
  fi

  if [ -d "$DIR_WEB/sites/default" ]; then
    drupal_sites_default_unprotect
    rm -R "$DIR_WEB/sites/default"
  fi

  mv "$DIR_BACKUP/sites-default" "$DIR_WEB/sites/default"
  drupal_sites_default_protect

  echo
}


# Run the restore.
restore_sites_default_run
if [[ $? -eq 1 ]]; then
  markup_error "Could not restore the sites-default directory."
  echo
  exit
fi


# Run any script after we did run the restore.
hook_invoke restore_sites_default_after
