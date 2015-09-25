################################################################################
# Include script that enable modules as defined in the
# $MODULES_ENABLE array(s).
#
# This script will try to load the enable config from 4 files:
#   1. config/drupal_modules_enable.sh
#   2. config/drupal_modules_enable_<environment>.sh
#   3. config/<script-name>/drupal_modules_enable.sh
#   4. config/<script-name>/drupal_modules_enable_<environment>.sh
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - drupal_modules_enable_before : Scripts that should run before the modules
#                                  are enabled.
# - drupal_modules_enable_after  : Scripts that should run after the modules
#                                  are enabled.
################################################################################


# Run any script before we run the make files.
hook_invoke drupal_modules_enable_before


##
# Run the make files.
#
# @param The file name of the script that contains the config array.
##
function drupal_modules_enable_run {
  # Reset the variable.
  local MODULES_ENABLE=()
  local drupal_modules_enable_file="$1"

  # Check if file exists.
  if [ ! -f "$drupal_modules_enable_file" ]; then
    markup_debug "No modules enable file $drupal_modules_enable_file"
    return
  fi

  markup_h1 "Enable extra modules"
  source "$drupal_modules_enable_file"

  # Check if there are modules to enable.
  if [ ${#MODULES_ENABLE[@]} -eq 0 ]; then
    markup "No modules to enable."
    return
  fi

  # Enable all modules in configuration.
  for module_enable in ${MODULES_ENABLE[@]}; do
    drupal_drush -y en ${module_enable}
  done
  echo
}


# 1. Enable modules.
drupal_modules_enable_run "$DIR_CONFIG/drupal_modules_enable.sh"

# 2. Enable modules specific for the environment.
drupal_modules_enable_run "$DIR_CONFIG/drupal_modules_enable_$ENVIRONMENT.sh"

# 3. Enable modules specific for the script name.
drupal_modules_enable_run "$DIR_CONFIG/$SCRIPT_NAME/drupal_modules_enable.sh"

# 4. Enable modules specific for the script name and environment.
drupal_modules_enable_run "$DIR_CONFIG/$SCRIPT_NAME/drupal_modules_enable_$ENVIRONMENT.sh"


# Run any script after we did run the make files.
hook_invoke drupal_modules_enable_after
