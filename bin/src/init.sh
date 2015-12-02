################################################################################
# Functionality to initiate the environment.
################################################################################


##
# Function to initiate the project environment.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - drupal_login_before : Scripts that should run before the user is logged in.
# - drupal_login_after  : Scripts that should run after the user id logged in.
#
# The hooks will be called without and with environment suffix.
##
function init_run {
  # Run hooks before we login into Drupal.
  hook_invoke "init_before"

  init_custom_commands
  echo

  # Run hooks after we login into Drupal.
  hook_invoke "init_after"
}

##
# Symlink the custom commands.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - init_custom_commands_before : Scripts that should run before custom commands
#   are symlinked within the bin directory.
# - init_custom_commands_after : Scripts that should run after the custom
#   commands are symlinked.
#
# The hooks will only be triggered if there are commands to symlink to.
##
function init_custom_commands {
  markup_h1 "Symlink custom commands"
  if [ ! -d "$DIR_CONFIG_BIN" ]; then
    message_warning "There is no config/bin directory to symlink from."
    return
  fi

  local commands=$(find "$DIR_CONFIG_BIN" -maxdepth 1 -type f | awk -F"/" '{print $NF}' | grep -v '\.')
  if [ -z "$commands" ]; then
    message_warning "There are no commands within the config/bin directory to symlink to."
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

  hook_invoke "init_custom_commands_after"
}