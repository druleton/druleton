################################################################################
# Include script that restores the web folder and the database from a backup.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - restore_before : Scripts that should run before the restore is run.
# - restore_after  : Scripts that should run after the restore has run.
################################################################################


# Run any script before we login into Drupal.
hook_invoke "restore_before"


##
# Function to restore a backup.
#
# This will read the backup folder and list the available backups.
##
function restore_run {
  markup_h1 "Available backups"
  if [ ! -d "$DIR_BACKUP" ]; then
    message_error "No backups available."
    echo
    return 1
  fi

  # Scan the backup directory.
  restore_run_scan_directory

  # We should have at minimum one full backup.
  if [ ${#BACKUP_DIRECTORIES[@]} -eq 0 ]; then
    message_error "No backups available."
    echo
    return 1
  fi

  # Show the select menu.
  PS3="Please enter your choice: "
  markup_h2 "Select the backup to restore from:"
  select opt in "${BACKUP_DIRECTORIES[@]}" "Cancel"; do
    case $opt in
      "Cancel")
        echo
        markup_warning "Restore canceled."
        echo
        exit
        ;;

      *)
        # Check if one of the allowed choises is selected.
        for backup_directory_i in ${BACKUP_DIRECTORIES[@]}; do
          if [ "$backup_directory_i" = "$opt" ]; then
            backup_directory="$backup_directory_i"
            break
          fi
        done

        if [ "$backup_directory" != "" ]; then
          break
        fi
        message_warning "Illegal choise"
        ;;

    esac
  done

  echo
  restore_run_directory "$backup_directory"
  echo
}

##
# Function to restore the backup from the given backup file.
#
# @param The directory name with the /backups directory where the backup files
#        are located.
##
function restore_run_directory {
  markup_h1 "Backup directory : ${LWHITE}$1${LBLUE}"

  local backup_directory="$DIR_BACKUP/$1"
  if [ ! -d "$backup_directory" ]; then
    message_error "The backup directory does not exist."
    return 1
  fi

  if [ ! -f "$backup_directory/db.tar.gz" ]; then
    message_error "The database backup file does not exist."
    return 1
  fi

  if [ ! -f "$backup_directory/web.tar.gz" ]; then
    message_error "The web directory backup file does not exist."
    return 1
  fi


  # ! Create a backup of the current active environment.
  echo
  source "$DIR_SRC/backup.sh"

  markup_h1 "Restore from backup (can take a while...)"

  # Delete the database content.
  drupal_drush -y sql-drop

  # Delete the web directory.
  drupal_sites_default_unprotect
  rm -R "$DIR_WEB"

  # Restore the web directory from the backup.
  cd "$DIR_ROOT"
  tar -xzf "$backup_directory/web.tar.gz"
  if [ $? -eq 0 ]; then
    message_success "Web directory is restored."
  else
    message_error "Can not restore web directory."
    return 1
  fi

  # Restore the database from the backup.
  cd "$backup_directory"
  tar -xzf "db.tar.gz"
  drupal_drush sql-cli < "db.sql"
  if [ $? -eq 0 ]; then
    message_success "Database is restored."
  else
    message_error "Can not restore database."
    return 1
  fi

  return 0
}

##
# Scan the backup directory for full backups.
#
# Only directories who have a db & web backup will be listed.
# The result will be stored in the $BACKUP_DIRECTORIES variable.
##
function restore_run_scan_directory {
  BACKUP_DIRECTORIES=()

  local directories=( $( ls -r "$DIR_BACKUP" ) )
  for directory in ${directories[@]}; do
    local directory_is_valid=$(restore_run_directory_has_full_backup "$directory")
    if [ $directory_is_valid -eq 1 ]; then
      BACKUP_DIRECTORIES+=("$directory")
    fi
  done
}

##
# Helper to check if the directory has a full backup.
#
# @param the directory name within the backup directory.
##
function restore_run_directory_has_full_backup {
  local directory="$1"

  if [ -f "$DIR_BACKUP/$directory/db.tar.gz" ] && [ -f "$DIR_BACKUP/$directory/web.tar.gz" ]; then
    echo 1
    return
  fi

  echo 0
}


# Run the restore function.
restore_run
if [ "$?" -eq 1 ]; then
  exit
fi


# Run any script after we login into Drupal.
hook_invoke "restore_after"
