################################################################################
# Include script that holds the code to cleanup files and directories based
# on an array of $CLEANUP_FILES and $CLEANUP_DIRECTORIES.
#
# This script will try to load the cleanup from 2 files:
#   3. config/<script-name>/cleanup.sh
#   4. config/<script-name>/cleanup_<environment>.sh
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - cleanup_before : Scripts that should run before the cleanup is run.
# - cleanup_after  : Scripts that should run after the cleanup is run.
################################################################################


hook_invoke "cleanup_before"


##
# Cleanup based on the given configuration file.
#
# @param The file name of the script that contains the config array.
##
function cleanup_run {
  # Reset the variables.
  CLEANUP_FILES=()
  CLEANUP_DIRECTORIES=()

  # Check if file exists.
  cleanup_file="$1"
  if [ ! -f "$cleanup_file" ]; then
    return
  fi;

  # Load the file and run cleanup.
  source "$cleanup_file"

  markup_h1 "Cleanup loaded from $cleanup_file"
  cleanup_run_files $CLEANUP_FILES
  cleanup_run_directories $CLEANUP_DIRECTORIES
  echo
}

##
# Cleanup files based on an array of file paths.
#
# @param Array of file paths that need to be deleted.
##
function cleanup_run_files {
  CLEANUP_FILES_CONFIG=$1

  if [ ${#CLEANUP_FILES_CONFIG[@]} -eq 0 ]; then
    massage_warning "No files to cleanup"
    return
  fi

  for cleanup_file in ${CLEANUP_FILES_CONFIG[@]}; do
    markup_h2 "File : ${cleanup_file}"

    # Delete the file.
    if [ -f "${cleanup_file}" ]; then
      chmod +w "${cleanup_file}"
      rm "${cleanup_file}"

      # Check if the file is deleted.
      if [ -f "${cleanup_file}" ]; then
        message_error "Can't delete file."
      else
        message_success "File is deleted."
      fi
    else
      message_warning "File does not exists."
    fi

  done
}

##
# Cleanup files based on an array of file paths.
#
# @param Array of file paths that need to be deleted.
##
function cleanup_run_directories {
  CLEANUP_DIRECTORIES_CONFIG=$1

  if [ ${#CLEANUP_DIRECTORIES_CONFIG[@]} -eq 0 ]; then
    massage_warning "No directories to cleanup"
    return
  fi

  for cleanup_directory in ${CLEANUP_DIRECTORIES_CONFIG[@]}; do
    markup_h2 "Directory : ${cleanup_directory}"

    # Delete the directory.
    if [ -d "${cleanup_directory}" ]; then
      chmod -R +w "${cleanup_directory}"
      rm -R "${cleanup_directory}"

      # Check if the directory is deleted.
      if [ -d "${cleanup_directory}" ]; then
        message_warning "Can't delete directory."
      else
        message_success "Directory is deleted."
      fi
    else
      message_warning "Directory does not exists."
    fi

  done
}


# Make the default directory and its content writable.
if [ -d "$DIR_WEB/sites/default" ]; then
  chmod -R u+w "$DIR_WEB/sites/default"
fi


# Cleanup based on script.
cleanup_run "$DIR_CONFIG/$SCRIPT_NAME/cleanup.sh"

# Cleanup based on script and environment.
cleanup_run "$DIR_CONFIG/$SCRIPT_NAME/cleanup_$ENVIRONMENT.sh"


hook_invoke "cleanup_after"
