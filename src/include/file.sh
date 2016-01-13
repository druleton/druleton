################################################################################
# Include script that holds helper functions about the file system.
################################################################################

##
# Get a list of directories within the given path.
#
# @param string The path to list the directories in.
#
# @return The directory names: 1 directory name per directory.
##
function file_list_subdirectories {
  if [ -z "$1" ]; then
    return
  fi

  ls -l "$1" | grep "^d" | awk -F" " '{print $NF}'
}

##
# Symlink all directories within the source directory to the target directory.
#
# @param string $1
#   The source directory.
# @param string $2
#   The target directory.
##
function file_symlink_subdirectories {
  local directories=$(file_list_subdirectories "$1")
  if [ -z "$directories" ]; then
    message_warning "No directories to link."
    return
  fi

  if [ ! -d "$2" ]; then
    message_error "Target directory does not exists."
  fi

  for directory in $directories
  do
    ln -s "$1/$directory" "$2/$directory"
    message_success "$directory"
  done
}

##
# Copy all directories within the source directory to the target directory.
#
# @param string $1
#   The source directory.
# @param string $2
#   The target directory.
##
function file_copy_subdirectories {
  local directories=$(file_list_subdirectories "$1")
  if [ -z "$directories" ]; then
    message_warning "No directories to copy."
    return
  fi

  if [ ! -d "$2" ]; then
    message_error "Target directory does not exists."
  fi

  for directory in $directories
  do
    cp -R "$1/$directory" "$2/$directory"
    message_success "$directory"
  done
}
