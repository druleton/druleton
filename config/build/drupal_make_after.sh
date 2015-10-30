
################################################################################
# Use this file to add custom script steps that should run after the make files
# have run for the build script.
################################################################################


# Add symlinks from the project folder.
markup_h1 "Copy custom modules and themes code to build."

# Copy modules.
cp -R "$DIR_PROJECT/modules/custom" "$DIR_BUILD/web/sites/all/modules/custom"
if [ $? -ne 1 ]; then
  message_success "Copied custom modules."
else
  message_error "Could not copy custom modules."
fi

# Copy themes.
cp -R "$DIR_PROJECT/themes/custom" "$DIR_BUILD/web/sites/all/themes/custom"
if [ $? -ne 1 ]; then
  message_success "Copied custom themes."
else
  message_error "Could not copy custom themes."
fi


echo
