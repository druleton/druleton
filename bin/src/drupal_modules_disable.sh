################################################################################
# Include script that disables modules as defined in the
# $MODULES_DISABLE array(s).
#
# This script will try to load the disable config from 4 files:
#   1. config/drupal_modules_disable.sh
#   2. config/drupal_modules_disable_<environment>.sh
#   3. config/<script-name>/drupal_modules_disabme.sh
#   4. config/<script-name>/drupal_modules_disable_<environment>.sh
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - drupal_modules_disable_before : Scripts that should run before the modules
#                                   are disabled.
# - drupal_modules_disable_after  : Scripts that should run after the modules
#                                   are disabled.
################################################################################


# Run any script before we run the make files.
hook_invoke drupal_modules_disable_before


##
# Run the make files.
#
# @param The file name of the script that contains the config array.
##
function drupal_modules_disable_run {
  # Reset the variable.
  local MODULES_DISABLE=()
  local drupal_modules_disabe_file="$1"

  # Check if file exists.
  if [ ! -f "$drupal_modules_disabe_file" ]; then
    markup_debug "No modules disable file $drupal_modules_disabe_file"
    return
  fi

  markup_h1 "Disable unwated modules"
  source "$drupal_modules_disabe_file"

  # Check if there are modules to disable.
  if [ ${#MODULES_DISABLE[@]} -eq 0 ]; then
    markup "No modules to disable."
    return
  fi

  # Disable all modules in configuration.
  for module_disable in ${MODULES_DISABLE[@]}; do
    drupal_drush -y dis ${module_disable}
  done
  echo
}


# 1. Disable modules.
drupal_modules_disable_run "$DIR_CONFIG/drupal_modules_disable.sh"

# 2. Disable modules specific for the environment.
drupal_modules_disable_run "$DIR_CONFIG/drupal_modules_disable_$ENVIRONMENT.sh"

# 3. Disable modules specific for the script name.
drupal_modules_disable_run "$DIR_CONFIG/$SCRIPT_NAME/drupal_modules_disable.sh"

# 4. Disable modules specific for the script name and environment.
drupal_modules_disable_run "$DIR_CONFIG/$SCRIPT_NAME/drupal_modules_disable_$ENVIRONMENT.sh"


# Run any script after we did run the make files.
hook_invoke drupal_modules_disable_after
