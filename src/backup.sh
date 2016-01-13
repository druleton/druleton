################################################################################
# Functionality to backup a local (working) Drupal environment.
################################################################################


##
# Function to run the actual backup (if not disabled).
#
# This function will trigger 2 "hooks" in the config/<script-name>/ directory:
# - backup_before : Scripts that should run before the backup is created.
# - backup_after  : Scripts that should run after the backup is created.
#
# The hooks will be called without and with environment suffix.
##
function backup_run {
  # Check if the backup is not disabled.
  if [ $(option_is_set "--no-backup") -eq 1 ]; then
    markup_debug "Backup is disabled (--no-backup)."
    return
  fi

  # Check if there is something to backup.
  if [ ! -d "$DIR_WEB" ]; then
    markup_debug "No web directory to backup."
    return
  fi

  # Check if there is a working Drupal installation.
  if [ `drupal_is_installed` -ne 1 ]; then
    markup_debug "No working Drupal installation to backup."
    return
  fi

  hook_invoke "backup_before"
  backup_run_all
  hook_invoke "backup_after"
}

##
# Function to create a backup of a working Drupal environment.
#
# @return The directory where the backup file(s) are saved.
##
function backup_run_all {
  markup_h1 "Create backup (can take a while...)"

  # Dir where the script is before backup is created.
  local backup_current_dir=$( pwd )

  # Create backup directory.
  if [ -z $SCRIPT_ARGUMENT ]; then
    local backup_timestamp=`date +%Y%m%d_%H%M%S`
    local backup_destination="$DIR_BACKUP/$backup_timestamp"
  else
    local backup_destination="$DIR_BACKUP/$SCRIPT_ARGUMENT"
  fi
  mkdir -p "$backup_destination"

  local only_db=$( option_is_set "--only-db" )
  local only_web=$( option_is_set "--only-web" )
  local only_files=$( option_is_set "--only-files" )

  # Backup default?
  local backup_default=1
  if [ $only_db -ne 0 ] || [ $only_web -ne 0 ] || [ $only_files -ne 0 ]; then
    backup_default=0
  fi

  # Backup only the sites/default/files.
  if [ $only_files -eq 1 ]; then
    backup_run_files_directory "$backup_destination"
  else
    markup_debug "Files directory backup skipped"
  fi

  # Backup the whole web directory.
  if [ $only_web -eq 1 ] || [ $backup_default -eq 1 ]; then
    backup_run_web_directory "$backup_destination"
  else
    markup_debug "Web directory backup skipped"
  fi

  # Backup only the database.
  if [ $only_db -eq 1 ] || [ $backup_default -eq 1 ]; then
    backup_run_database "$backup_destination"
  else
    markup_debug "Database backup skipped"
  fi

  # Back to where we started.
  cd "$backup_current_dir"

  # Inform about backup.
  echo
  markup_h1_divider
  markup_success " Backup created in"
  markup_h1 " ${LWHITE}$backup_destination${RESTORE}"
  markup_h1_divider
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

##
# Backup the sites/default directory of a working environment.
#
# This is not a backup like the files or web directory backups: it will move the
# directory to backup/sites-default. This is used to temporarely stroing the
# directory while performing a site upgrade.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - backup_sites_default_before : Scripts that should run before the backup is
#                                 taken.
# - backup_sites_default_after  : Scripts that should run after the backup is
#                                 taken.
#
# The hooks will be called without and with environment suffix.
##
function backup_run_sites_default_directory {
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
