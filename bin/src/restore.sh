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

  local backup_directory="$1"
  if [ ! -d "$DIR_BACKUP/$backup_directory" ]; then
    message_error "The backup directory does not exist."
    echo
    return 1
  fi

  # ! Create a backup of the current active environment.
  echo
  source "$DIR_SRC/backup.sh"

  markup_h1 "Restore from backup (can take a while...)"

  # Get the options.
  local only_db=$( option_is_set "--only-db" )
  local only_web=$( option_is_set "--only-web" )
  local only_files=$( option_is_set "--only-files" )

  # Restore default?
  local restore_default=1
  if [ $only_db -ne 0 ] || [ $only_web -ne 0 ] || [ $only_files -ne 0 ]; then
    restore_default=0
  fi

  # Restore only the database.
  if [ $only_db -eq 1 ] || [ $restore_default -eq 1 ]; then
    restore_run_database "$backup_directory"
    if [ $? -ne 0 ]; then
      exit
    fi
  fi

  # Restore only the whole web directory.
  if [ $only_web -eq 1 ] || [ $restore_default -eq 1 ]; then
    restore_run_web "$backup_directory"
    if [ $? -ne 0 ]; then
      exit
    fi
  fi

  # Restore only the sites/default/files.
  if [ $only_files -eq 1 ]; then
    restore_run_files "$backup_directory"
    if [ $? -ne 0 ]; then
      exit
    fi
  fi

  echo
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
    local directory_is_valid=$(restore_run_directory_has_backup "$directory")
    if [ $directory_is_valid -eq 1 ]; then
      BACKUP_DIRECTORIES+=("$directory")
    fi
  done
}

##
# Restore the database.
#
# @param The backup directory from where to restore the database.
##
function restore_run_database {
  local backup_directory="$DIR_BACKUP/$1"

  # We can only restore if we have the proper backup file.
  if [ ! -f "$backup_directory/db.tar.gz" ]; then
    message_error "The database backup file does not exist."
    echo
    return 1
  fi

  # Delete the database content.
  drupal_drush -y sql-drop

  # Restore the database from the backup.
  cd "$backup_directory"
  tar -xzf "db.tar.gz"
  drupal_drush sql-cli < "db.sql"

  # Return the result.
  if [ $? -ne 0 ]; then
    message_error "Can not restore database."
    return 1
  fi
  message_success "Database is restored."
}

##
# Restore the files directory.
#
# @param The backup directory from where to restore the database.
##
function restore_run_files {
  local directory="$1"
  local backup_directory="$DIR_BACKUP/$directory"

  # We can only restore if we have the proper backup file.
  if [ $(restore_run_directory_has_files_backup "$directory") -eq 0 ]; then
    message_error "The files directory backup file does not exist."
    echo
    return 1
  fi

  # Delete the files directory.
  drupal_sites_default_unprotect
  rm -R "$DIR_WEB/sites/default/files"

  # Restore the files directory from the backup.
  cd "$DIR_WEB/sites/default"
  if [ -f "$backup_directory/files.tar.gz" ]; then
    tar -xzf "$backup_directory/files.tar.gz"
  else
    tar --strip-components=3 -xzf "$backup_directory/web.tar.gz" "web/sites/default/files"
  fi

  # Return the result.
  if [ $? -ne 0 ]; then
    message_error "Can not restore files directory."
    return 1
  fi
  message_success "Files directory is restored."
}

##
# Restore the web directory.
#
# @param The backup directory from where to restore the web directory.
##
function restore_run_web {
  local backup_directory="$DIR_BACKUP/$1"

  # We can only restore if we have the proper backup file.
  if [ ! -f "$backup_directory/web.tar.gz" ]; then
    message_error "The web directory backup file does not exist."
    echo
    return 1
  fi

  # Delete the web directory.
  drupal_sites_default_unprotect
  rm -R "$DIR_WEB"

  # Restore the web directory from the backup.
  cd "$DIR_ROOT"
  tar -xzf "$backup_directory/web.tar.gz"

  # Return the result.
  if [ $? -ne 0 ]; then
    message_error "Can not restore web directory."
    return 1
  fi
  message_success "Web directory is restored."
}

##
# Check if the given directory has a full backup.
#
# @param the directory name within the backup directory.
##
function restore_run_directory_has_backup {
  local directory="$1"

  local only_db=$( option_is_set "--only-db" )
  local only_web=$( option_is_set "--only-web" )
  local only_files=$( option_is_set "--only-files" )

  # Restore default?
  local restore_default=1
  if [ $only_db -ne 0 ] || [ $only_web -ne 0 ] || [ $only_files -ne 0 ]; then
    restore_default=0
  fi

  # Restore only the database.
  if [ $only_db -eq 1 ] || [ $restore_default -eq 1 ]; then
    if [ $(restore_run_directory_has_db_backup "$directory") -eq 0 ]; then
      echo 0
      return
    fi
  fi

  # Restore only the sites/default/files.
  if [ $only_files -eq 1 ]; then
    if [ $(restore_run_directory_has_files_backup "$directory") -eq 0 ]; then
      echo 0
      return
    fi
  fi

  # Restore only the whole web directory.
  if [ $only_web -eq 1 ] || [ $restore_default -eq 1 ]; then
    if [ $(restore_run_directory_has_web_backup "$directory") -eq 0 ]; then
      echo 0
      return
    fi
  fi

  echo 1
}

##
# Check if the given directory has a db backup.
#
# @param the directory name within the backup directory.
##
function restore_run_directory_has_db_backup {
  local directory="$1"

  if [ -f "$DIR_BACKUP/$directory/db.tar.gz" ]; then
    echo 1
    return
  fi

  echo 0
}

##
# Check if the given directory has a files backup.
#
# @param the directory name within the backup directory.
##
function restore_run_directory_has_files_backup {
  local directory="$1"

  if [ -f "$DIR_BACKUP/$directory/files.tar.gz" ] || [ $(restore_run_directory_has_web_backup "$directory") -eq 1 ]; then
    echo 1
    return
  fi

  echo 0
}

##
# Check if the given directory has a web backup.
#
# @param the directory name within the backup directory.
##
function restore_run_directory_has_web_backup {
  local directory="$1"

  if [ -f "$DIR_BACKUP/$directory/web.tar.gz" ]; then
    echo 1
    return
  fi

  echo 0
}



# Run a restore for the requested directory name.
if [ ! -z "$SCRIPT_ARGUMENT" ]; then
  restore_run_directory "$SCRIPT_ARGUMENT"
# Or show a list to choose from.
else
  restore_run
fi

if [ "$?" -eq 1 ]; then
  exit
fi


# Run any script after we login into Drupal.
hook_invoke "restore_after"
