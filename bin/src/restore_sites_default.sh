################################################################################
# Include script that restores the sites/default directory from
#   backup/sites-default
################################################################################


##
# Function to run the sites/default restore process.
#
# This will move the sites/default directory from backup/sites-default back to
# web/sites/default.
# Existing web/sites/default directory will be deleted before restore.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - restore_sites_default_before : Scripts that should run before the restore is
#                                  performed.
# - restore_sites_default_after  : Scripts that should run after the backup is
#                                  performed.
#
# The hooks will be called without and with environment suffix.
##
function restore_sites_default_run {
  # Trigger the before hook(s).
  hook_invoke restore_sites_default_before

  markup_h1 "Move sites/default back into place."

  if [ -f "$DIR_BACKUP/sites-default" ]; then
    markup_error "The sites/default backup does not exists."
    echo
    return 1
  fi

  if [ -d "$DIR_WEB/sites/default" ]; then
    drupal_sites_default_unprotect
    rm -R "$DIR_WEB/sites/default"
  fi

  mv "$DIR_BACKUP/sites-default" "$DIR_WEB/sites/default"
  drupal_sites_default_protect

  if [[ $? -eq 1 ]]; then
    markup_error "Could not restore the sites-default directory."
    echo
    exit
  else
    message_success "Directory restored."
    echo
  fi

  # Trigger the after hook(s).
  hook_invoke restore_sites_default_after
}


restore_sites_default_run
