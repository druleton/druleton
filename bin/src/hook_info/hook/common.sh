markup_h1_divider
markup_h1 " Hook information for ${LWHITE}bin/${SCRIPT_NAME}${RESTORE}"
markup_h1_divider

markup "
The hook system allows you to plugin bash scripts before or after each step in
the script. You can implement hooks specific for your projects (eg. add
symlinks, delete files, set file permissions, ...).

You can implement a hook before (eg. backup_before.sh) and/or after
(eg. backup_after) a script step. You can implement a general hook
(eg. backup_before.sh) and/or a script specific for the environment the script
is run for (eg. backup_before_tst.sh).

All the hook scripts should be placed in the ${LWHITE}config/$SCRIPT_NAME/${RESTORE} directory.

Find out more about the bin/${SCRIPT_NAME} by reading the help:
 ${GREY}\$${RESTORE} bin/${SCRIPT_NAME} -h
"

echo
markup_h1 "Available hooks:"
markup "${GREY}(_${ENVIRONMENT})${RESTORE} is optional. Fill in the environment name you want to run specific
hooks for. The hooks are listed in the order of the script steps.
"
