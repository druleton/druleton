################################################################################
# Functionality to symlink custom commands.
################################################################################


##
# Function to symlink custom commands from the config/bin to the bin directory.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - init_custom_commands_before : Scripts that should run before custom commands
#   are symlinked within the bin directory.
# - init_custom_commands_after : Scripts that should run after the custom
#   commands are symlinked.
#
# The hooks will only be triggered if there are commands to symlink to.
# The hooks will be called without and with environment suffix.
##
function init_custom_commands_run {
  # Check if skipped.
  if [ $INIT_OPTION_SKIP_CUSTOM -eq 1 ]; then
    markup_debug "Skipped : Symlinking custom commands."
    markup_debug
    return
  fi

  markup_h1 "Symlink custom commands"

  if [ ! -d "$DIR_CONFIG_BIN" ]; then
    message_warning "There is no config/bin directory to symlink from."
    return
  fi

  local commands=$(find "$DIR_CONFIG_BIN" -maxdepth 1 -type f | awk -F"/" '{print $NF}' | grep -v '\.')
  if [ -z "$commands" ]; then
    message_warning "There are no commands within the config/bin directory to symlink to."
    echo
    return
  fi

  hook_invoke "init_custom_commands_before"

  for command in $commands
  do
    if [ -L "$DIR_BIN/$command" ]; then
      message_success "bin/$command"
    elif [ -f "$DIR_BIN/$command" ]; then
      message_error "bin/$command : There is already a command with the same name."
    else
      ln -s "$DIR_CONFIG_BIN/$command" "$DIR_BIN/$command"
      message_success "bin/$command"
    fi
  done
  echo

  hook_invoke "init_custom_commands_after"
}
