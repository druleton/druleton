
################################################################################
# Use this file to add custom script steps that should run before the
# installation of Drupal is started.
################################################################################


# Add symlinks from the project folder.
markup_h1 "Symlink custom modules and themes."

# Symlink modules.
if [ ! -L "$DIR_WEB/sites/all/modules/custom" ]; then
  ln -s "$DIR_PROJECT/modules/custom" "$DIR_WEB/sites/all/modules/custom"
  message_success "Symlinked custom modules."
else
  message_warning "Symlink already exists for modules."
fi

# Symlink themes.
if [ ! -L "$DIR_WEB/sites/all/themes/custom" ]; then
  ln -s "$DIR_PROJECT/themes/custom" "$DIR_WEB/sites/all/themes/custom"
  message_success "Symlinked custom themes."
else
  message_warning "Symlink already exists for themes."
fi

echo
