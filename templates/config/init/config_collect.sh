################################################################################
# When a project is initiated for the first time (bin/init), the config
# variables are collected trough the script and written to the config.sh file.
#
# Add in this script the code to collect those values.
# Use the markup_prompt helper to prompt the user for input.
# The helper has 2 parameters:
# - The prompt text (question)
# - An optional current value.
#
# Save the collected value by assigning the $REPLY value to the INIT_CONFIG_X
# variable.
# Example:
# INIT_CONFIG_CUSTOM_VARIABLE="${REPLY"
#
# You can set a default value (if no value entered) by adding
# :-default_value (variable substitution,
# http://tldp.org/LDP/abs/html/parameter-substitution.html) to the assignment:
# Example:
# INIT_CONFIG_CUSTOM_VARIABLE="${REPLY:-$INIT_CONFIG_CUSTOM_VARIABLE}"
################################################################################

#markup_h2 "Custom variables"
#markup_prompt "Custom variable" "$INIT_CONFIG_CUSTOM_VARIABLE"
#INIT_CONFIG_CUSTOM_VARIABLE="${REPLY:-$INIT_CONFIG_CUSTOM_VARIABLE}"
#echo
