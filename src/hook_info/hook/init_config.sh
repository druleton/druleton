markup_h2 "Collect and update custom config file variables"
markup "4 hooks need to be implemented:"
markup

markup "1. Load the current custom variables values:"
markup "${GREY}config/${SCRIPT_NAME}/${RESTORE}config_load_current${GREY}(_${ENVIRONMENT})${RESTORE}.sh"
markup

markup "2. Fill in the custom variables:"
markup "${GREY}config/${SCRIPT_NAME}/${RESTORE}config_collect${GREY}(_${ENVIRONMENT})${RESTORE}.sh"
markup

markup "3. Show overview of collected data:"
markup "${GREY}config/${SCRIPT_NAME}/${RESTORE}config_confirm${GREY}(_${ENVIRONMENT})${RESTORE}.sh"
markup

markup "4. Save custom variables to the config/config.sh file:"
markup "${GREY}config/${SCRIPT_NAME}/${RESTORE}config_save${GREY}(_${ENVIRONMENT})${RESTORE}.sh"
markup
