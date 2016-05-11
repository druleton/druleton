################################################################################
# Functionality to install druleton.
################################################################################

##
# Install druleton.
##
function init_structure_run {
  if [ $INIT_OPTION_SKIP_STRUCTURE -eq 1 ]; then
    markup_debug "Skipped : Structure setup/update."
    markup_debug
    return
  fi

  markup_h1 "Structure"
  init_structure_root
  init_structure_config
  init_structure_project
  init_structure_scripts
  echo
}

##
# Copy git & editor configuration files to the root of the project.
##
function init_structure_root {
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

  if [ ! -f "${DIR_ROOT}/composer.json" ]; then
    cp "${DIR_BIN}/templates/composer.json" "${DIR_ROOT}/"
    message_success "Copied composer.json file to the root of the project."
  else
    message_warning "There is already a composer.json file."
  fi

  if [ ! -f "${DIR_ROOT}/README.md" ]; then
    cp "${DIR_BIN}/templates/README.md" "${DIR_ROOT}/"
    message_success "Copied README.md file to the root of the project."
  else
    message_warning "There is already a README.md file."
  fi
}

##
# Copy the template config directory to the root of the project.
##
function init_structure_config {
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
function init_structure_project {
  if [ ! -d "${DIR_PROJECT}" ]; then
    cp -R "${DIR_BIN}/templates/project" "${DIR_PROJECT}"
    message_success "Copied the project directory to the root of the project."
  else
    message_warning "There is already a project directory."
  fi
}

##
# Copy the example scripts directory to the root of the project.
##
function init_structure_scripts {
  if [ ! -d "${DIR_PROJECT}" ]; then
    cp -R "${DIR_BIN}/templates/scripts" "${DIR_PROJECT}"
    message_success "Copied the scripts directory to the root of the project."
  else
    message_warning "There is already a scripts directory."
  fi
}
