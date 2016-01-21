################################################################################
# When a project is initiated for the first time (bin/init), the config
# variables are collected trough the script and written to the config.sh file.
#
# Add in this script the code to list the custom collected values.
# Use the markup_li_value to list the config variable name and value.
# The helper has 2 parameters:
# - The variable name.
# - The value.
#
# Use (variable substitution,
# http://tldp.org/LDP/abs/html/parameter-substitution.html) to show a - when no
# value has been entered (variable is empty):
#
# Example:
# markup_li_value "Custom variable" "${INIT_CONFIG_CUSTOM_VARIABLE:--}"
################################################################################

#markup_h2 "Custom variables"
#markup_li_value "Custom variable" "${INIT_CONFIG_CUSTOM_VARIABLE:--}"
