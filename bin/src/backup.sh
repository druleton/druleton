################################################################################
# Include script that backups the current active Drupal installation (if any).
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - backup_before : Scripts that should run before the backup is created.
# - backup_after  : Scripts that should run after the backup is created.
################################################################################


# Run any script before we login into Drupal.
hook_invoke "backup_before"


##
# Function to create a backup of a working Drupal environment.
##
function backup_run {
  markup_h1 "Create backup (can take a while...)"

  # Dir where the script is before backup is created.
  backup_current_dir=$( pwd )

  # Create backup directory.
  BACKUP_TIMESTAMP=`date +%Y%m%d_%H%M%S`
  BACKUP_DESTINATION="$DIR_BACKUP/$BACKUP_TIMESTAMP"
  mkdir -p "$BACKUP_DESTINATION"

  # Take a backup of the database.
  cd "$BACKUP_DESTINATION"
  drush --root="$DIR_WEB" sql-dump > "$BACKUP_DESTINATION/db.sql"
  if [[ $? -eq 0 ]]; then
    tar -czf "db.tar.gz" "db.sql"
    rm "$BACKUP_DESTINATION/db.sql"
    message_success "Backup database."
  else
    message_error "Can not backup database."
  fi

  # Take a backup of the web directory.
  cd "$DIR_ROOT"
  tar -czf "$BACKUP_DESTINATION/web.tar.gz" "web"
  if [[ $? -eq 0 ]]; then
    message_success "Backup web directory."
  else
    message_error "Can not backup web directory."
  fi

  # Back to where we started.
  cd "$backup_current_dir"


  # Inform about backup.
  echo
  markup_h1_devider
  markup_success " Backup created in"
  markup_h1 " ${LWHITE}$BACKUP_DESTINATION${RESTORE}"
  markup_h1_devider
  echo
}


# Check if there is a working Drupal.
if [ `drupal_is_installed` -eq 1 ]; then
  backup_run
  echo
fi


# Run any script after we login into Drupal.
hook_invoke "backup_after"
