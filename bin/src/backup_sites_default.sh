################################################################################
# Include script that backups the neccesary files before performing an upgrade.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - backup_sites_default_before : Scripts that should run before the backup is
#                                 taken.
# - backup_sites_default_after  : Scripts that should run after the backup is
#                                 taken.
################################################################################


# Run any script before we run the backup.
hook_invoke backup_sites_default_before


##
# Script to take the actual backup before the upgrade.
##
function backup_sites_default_run {
  markup_h1 "Move sites/default into safety."
  local backup_directory="$DIR_BACKUP"
  if [ -d "$backup_directory" ]; then
    mkdir -p "$backup_directory"
  fi

  if [ -f "$backup_directory/sites-default" ]; then
    rm -R "$backup_directory/sites-default"
  fi

  drupal_sites_default_unprotect
  mv "$DIR_WEB/sites/default" "$backup_directory/sites-default"

  echo
}


# Run the backup.
backup_sites_default_run
if [[ $? -eq 1 ]]; then
  markup_error "Error while moving the sites/default directory."
  echo
  exit
fi


# Run any script after we did run the backup.
hook_invoke backup_sites_default_after
