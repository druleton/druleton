################################################################################
# Include script that backups the current active Drupal installation (if any).
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - backup_before : Scripts that should run before the backup is created.
# - backup_after  : Scripts that should run after the backup is created.
################################################################################


# Do we need to and can we run a backup?
backup_run_active=1
if [ $(option_is_set "--no-backup") -eq 1 ]; then
  backup_run_active=0
fi
if [ $(drupal_is_installed) -eq 0 ]; then
  backup_run_active=0
fi


# Run any script before we create backups.
if [ $backup_run_active -eq 1 ]; then
  hook_invoke "backup_before"
fi


##
# Function to create a backup of a working Drupal environment.
##
function backup_run {
  markup_h1 "Create backup (can take a while...)"

  # Dir where the script is before backup is created.
  local backup_current_dir=$( pwd )

  # Create backup directory.
  local backup_timestamp=`date +%Y%m%d_%H%M%S`
  local backup_destination="$DIR_BACKUP/$backup_timestamp"
  mkdir -p "$backup_destination"


  # Backup only the database.
  local only_db=$( option_is_set "--only-db" )
  if [ $only_db -eq 1 ]; then
    backup_run_database "$backup_destination"
  fi

  # Backup only the sites/default/files.
  local only_files=$( option_is_set "--only-files" )
  if [ $only_files -eq 1 ]; then
    backup_run_files_directory "$backup_destination"
  fi

  # Backup the whole web directory.
  local only_web=$( option_is_set "--only-web" )
  if [ $only_web -eq 1 ]; then
    backup_run_web_directory "$backup_destination"
  fi

  # Default backup DB & Web directory.
  if [ $only_db -eq 0 ] && [ $only_web -eq 0 ] && [ $only_files -eq 0 ]; then
    backup_run_database "$backup_destination"
    backup_run_web_directory "$backup_destination"
  fi

  # Back to where we started.
  cd "$backup_current_dir"


  # Inform about backup.
  echo
  markup_h1_devider
  markup_success " Backup created in"
  markup_h1 " ${LWHITE}$backup_destination${RESTORE}"
  markup_h1_devider
  echo
}

##
# Backup the database.
#
# @param Directory (path) where the backup should be stored.
##
function backup_run_database {
  local backup_destination="$1"

  cd "$backup_destination"
  drupal_drush sql-dump > "$backup_destination/db.sql"
  if [[ $? -eq 0 ]]; then
    tar -czf "db.tar.gz" "db.sql"
    rm "$backup_destination/db.sql"
    message_success "Backup database."
    return 0
  else
    message_error "Can not backup database."
    return 1
  fi
}

##
# Backup the files directory.
#
# @param Directory (path) where the backup should be stored.
##
function backup_run_files_directory {
  local backup_destination="$1"

  # Take a backup of the web directory.
  cd "$DIR_WEB/sites/default"
  tar -czf "$backup_destination/files.tar.gz" "files"
  if [[ $? -eq 0 ]]; then
    message_success "Backup files directory."
    return 0
  else
    message_error "Can not backup files directory."
    return 1
  fi
}

##
# Backup the web directory.
#
# @param Directory (path) where the backup should be stored.
##
function backup_run_web_directory {
  local backup_destination="$1"

  # Take a backup of the web directory.
  cd "$DIR_ROOT"
  tar -czf "$backup_destination/web.tar.gz" "web"
  if [[ $? -eq 0 ]]; then
    message_success "Backup web directory."
    return 0
  else
    message_error "Can not backup web directory."
    return 1
  fi
}



if [ $backup_run_active -eq 1 ]; then

  # Run the backup function.
  backup_run


  # Run any script after we took the backup.
  hook_invoke "backup_after"

fi
