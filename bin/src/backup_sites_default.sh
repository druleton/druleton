################################################################################
# Include script that backups the neccesary files before performing an upgrade.
################################################################################


##
# Script to take the actual backup before the upgrade.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - backup_sites_default_before : Scripts that should run before the backup is
#                                 taken.
# - backup_sites_default_after  : Scripts that should run after the backup is
#                                 taken.
#
# The hooks will be called without and with environment suffix.
##
function _backup_sites_default_run {
  hook_invoke backup_sites_default_before

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
  if [[ $? -eq 1 ]]; then
    markup_error "Error while moving the sites/default directory."
    echo
    exit
  else
    message_success "Success."
    echo
  fi

  hook_invoke backup_sites_default_after
}
