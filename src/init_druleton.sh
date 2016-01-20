################################################################################
# Functionality to install druleton.
################################################################################

##
# Install druleton.
##
function init_druleton_run {
  if [ $INIT_DRULETON_INSTALLED -ne 1 ]; then
    init_druleton_run_install
  else
    init_druleton_run_update
  fi

  echo
}

##
# Check if already installed.
#
# @return int
#   1 if installed.
##
function init_druleton_check {
  if [ ! -d "$DIR_CONFIG" ]; then
    echo "0"
    return
  fi

  if [ ! -d "$DIR_PROJECT" ]; then
    echo "0"
    return
  fi

  echo "1"
}

##
# Install druleton.
##
function init_druleton_run_install {
  markup_h1 "Install druleton"
  init_druleton_git
  init_druleton_config
  init_druleton_project
}

##
# Update druleton.
##
function init_druleton_run_update {
  markup_h1 "Update druleton"
  if [ -f "$DIR_BIN/.git" ]; then
    markup_h2 "Update the druleton project from github."
    cd "$DIR_BIN"
    git pull
    cd "$DIR_ROOT"
    message_success "Updated from git."
  else
    message_error "Druleton not installed as submodule."
  fi
}


##
# Copy git & editor configuration files.
##
function init_druleton_git {
  if [ ! -f "${DIR_ROOT}/.editorconfig" ]; then
    cp "${DIR_BIN}/templates/.editorconfig" "${DIR_ROOT}/"
    message_success "Copied .editorconfig file to the root of the project."
  else
    message_warning "There is already an .editorconfig file."
  fi

  if [ ! -f "${DIR_ROOT}/.gitattributes" ]; then
    cp "${DIR_BIN}/templates/.gitattributes" "${DIR_ROOT}/"
    message_success "Copied .gitattributes file to the root of the project."
  else
    message_warning "There is already a .gitattributes file."
  fi

  if [ ! -f "${DIR_ROOT}/.gitignore" ]; then
    cp "${DIR_BIN}/templates/.gitignore" "${DIR_ROOT}/"
    message_success "Copied .gitignore file to the root of the project."
  else
    message_warning "There is already a .gitignore file."
  fi
}

##
# Copy the template config directory to the root of the project.
##
function init_druleton_config {
  if [ ! -d "${DIR_CONFIG}" ]; then
    cp -R "${DIR_BIN}/templates/config" "${DIR_CONFIG}"
    message_success "Copied the config directory to the root of the project."
  else
    message_warning "There is already a config directory."
  fi
}

##
# Copy the example project directory to the root of the project.
##
function init_druleton_project {
  if [ ! -d "${DIR_PROJECT}" ]; then
    cp -R "${DIR_BIN}/templates/project" "${DIR_PROJECT}"
    message_success "Copied the project directory to the root of the project."
  else
    message_warning "There is already a project directory."
  fi
}
