################################################################################
# Functionality to restore a local Drupal installation from backup files.
################################################################################

##
# Init the restore command.
##
function restore_init {
  # Get the backup options.
  OPTION_RESTORE_ONLY_DB=$( option_is_set "--only-db" )
  OPTION_RESTORE_ONLY_FILES=$( option_is_set "--only-files" )
  OPTION_RESTORE_ONLY_WEB=$( option_is_set "--only-web" )
}

##
# Show information about the restore command.
##
function restore_info {
  echo
  markup_h1_divider
  markup_h1 " ${LWHITE}Restore${LBLUE} website ${WHITE}$SITE_NAME${LBLUE} ($ENVIRONMENT)"
  markup_h1_divider
  markup_h1 " This will restore:"

  # Restore parts.
  if [ $OPTION_RESTORE_ONLY_DB -eq 1 ]; then
    markup_h1_li "The database."
  fi
  if [ $OPTION_RESTORE_ONLY_FILES -eq 1 ]; then
    markup_h1_li "The sites/default/files directory."
  fi
  if [ $OPTION_RESTORE_ONLY_WEB -eq 1 ]; then
    markup_h1_li "The /web directory."
  fi
  if [ $OPTION_RESTORE_ONLY_DB -ne 1 ] && [ $OPTION_RESTORE_ONLY_FILES -ne 1 ] && [ $OPTION_RESTORE_ONLY_WEB -ne 1 ]; then
    markup_h1_li "The database."
    markup_h1_li "The /web directory."
  fi

  # Restore from given backup directory?
  if [ ! -z "$SCRIPT_ARGUMENT" ]; then
    echo
    markup_h1 " The backup will be restored from backup/${LWHITE}$SCRIPT_ARGUMENT${LBLUE}"
  fi

  markup_h1_divider
  echo
}

##
# Restore command has finished.
##
function restore_finished {
  markup_h1_divider
  markup_success " Finished"
  markup_h1_divider
  markup_h1_li "Site Code : ${LWHITE}$DIR_WEB${RESTORE}"
  markup_h1_li "Site URL  : ${LWHITE}$SITE_URL${RESTORE}"
  markup_h1_divider
  echo
}

##
# Function to run the restore process.
##
function restore_run {
  # Run a restore for the requested directory name.
  if [ ! -z "$SCRIPT_ARGUMENT" ]; then
    restore_run_directory "$SCRIPT_ARGUMENT"

  # Or show a list to choose from.
  else
    restore_run_from_selection
  fi

  if [ "$?" -eq 1 ]; then
    exit
  fi
}

##
# Function to restore a backup from a list of available backups.
##
function restore_run_from_selection {
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
#
# This script will first take a backup of the currently installed platform.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - restore_before : Scripts that should run before the restore is run.
# - restore_after  : Scripts that should run after the restore has run.
#
# The hooks will be called without and with environment suffix.
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
  backup_run

  # Run the before hook(s).
  hook_invoke "restore_before"

  # Restore.
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

  # Restore only the whole web directory.
  if [ $only_web -eq 1 ] || [ $restore_default -eq 1 ]; then
    restore_run_web_directory "$backup_directory"
    if [ $? -ne 0 ]; then
      exit
    fi
  else
    markup_debug "Web directory restore skipped"
  fi

  # Restore only the sites/default/files.
  if [ $only_files -eq 1 ]; then
    restore_run_files_directory "$backup_directory"
    if [ $? -ne 0 ]; then
      exit
    fi
  else
    markup_debug "Files directory restore skipped"
  fi

  # Restore only the database.
  if [ $only_db -eq 1 ] || [ $restore_default -eq 1 ]; then
    restore_run_database "$backup_directory"
    if [ $? -ne 0 ]; then
      exit
    fi
  else
    markup_debug "Database restore skipped"
  fi

  echo

  # Run the after hook(s).
  hook_invoke "restore_after"
}

##
# Scan the backup directory for full backups.
#
# Only directories who have the neccesary backup parts (eg. db, web, files) will
# be included.
##
function restore_run_scan_directory {
  BACKUP_DIRECTORIES=()

  local directories=( $( ls -r "$DIR_BACKUP" ) )
  for directory in ${directories[@]}; do
    local directory_is_valid=$(restore_run_directory_has_backup "$directory")
    if [ $directory_is_valid -eq 1 ]; then
      BACKUP_DIRECTORIES+=("$directory")
    else
      markup_debug "Directory does not have the backup ($directory)."
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
  drupal_console database:drop

  # Restore the database from the backup.
  cd "$backup_directory"
  tar -xzf "db.tar.gz"
  drupal_console database:restore --file="db.sql"

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
function restore_run_files_directory {
  local directory="$1"
  local backup_directory="$DIR_BACKUP/$directory"

  # We can only restore if we have the proper backup file.
  if [ $(restore_run_directory_has_files_directory_backup "$directory") -eq 0 ]; then
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
function restore_run_web_directory {
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
function restore_run_sites_default_directory {
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
    if [ $(restore_run_directory_has_files_directory_backup "$directory") -eq 0 ]; then
      echo 0
      return
    fi
  fi

  # Restore only the whole web directory.
  if [ $only_web -eq 1 ] || [ $restore_default -eq 1 ]; then
    if [ $(restore_run_directory_has_web_directory_backup "$directory") -eq 0 ]; then
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
function restore_run_directory_has_files_directory_backup {
  local directory="$1"

  if [ -f "$DIR_BACKUP/$directory/files.tar.gz" ] \
    || [ $(restore_run_directory_has_web_directory_backup "$directory") -eq 1 ]; then
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
function restore_run_directory_has_web_directory_backup {
  local directory="$1"

  if [ -f "$DIR_BACKUP/$directory/web.tar.gz" ]; then
    echo 1
    return
  fi

  echo 0
}
