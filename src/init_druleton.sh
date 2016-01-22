################################################################################
# Functionality to install druleton.
################################################################################

##
# Install druleton.
##
function init_druleton_run {
  # Check if skipped.
  if [ $INIT_OPTION_SKIP_DRULETON -eq 1 ]; then
    markup_debug "Skipped : Update druleton."
    markup_debug
    return
  fi

  markup_h1 "Update druleton"

  hook_invoke "init_druleton_before"

  if [ -f "$DIR_BIN/.git" ]; then
    markup_h2 "Update the druleton project from github."
    cd "$DIR_BIN"
    git pull
    cd "$DIR_ROOT"
    message_success "Updated from git."
  else
    message_error "Druleton not installed as submodule."
  fi

  echo

  hook_invoke "init_druleton_after"
}
