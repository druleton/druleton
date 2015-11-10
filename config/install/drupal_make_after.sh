
################################################################################
# Use this file to add custom script steps that should run before the
# installation of Drupal is started.
################################################################################


# Add symlinks from the project directory.
markup_h1 "Symlink project profiles, modules, themes and libraries."

# Symlink profiles.
project_profiles=$(ls -l "$DIR_PROJECT/profiles" | grep "^d" | awk -F" " '{print $9}')
if [ "$project_profiles" ]; then
  for project_profile in $project_profiles
  do
    ln -s "$DIR_PROJECT/profiles/$project_profile" "$DIR_WEB/profiles/$project_profile"
    message_success "Symlinked profile $project_profile."
  done
else
  message_warning "No project profiles available."
fi

# Symlink modules.
project_modules=$(ls -l "$DIR_PROJECT/modules/custom" | grep "^d" | awk -F" " '{print $9}')
if [ "$project_modules" ]; then
  mkdir -p "$DIR_WEB/sites/all/modules"
  ln -s "$DIR_PROJECT/modules/custom" "$DIR_WEB/sites/all/modules/custom"
  message_success "Symlinked custom modules."
else
  message_warning "No project modules available."
fi

# Symlink themes.
project_themes=$(ls -l "$DIR_PROJECT/themes/custom" | grep "^d" | awk -F" " '{print $9}')
if [ "$project_themes" ]; then
  mkdir -p "$DIR_WEB/sites/all/themes"
  ln -s "$DIR_PROJECT/themes/custom" "$DIR_WEB/sites/all/themes/custom"
  message_success "Symlinked custom themes."
else
  message_warning "No project themes available."
fi

# Symlink libraries.
project_libraries=$(ls -l "$DIR_PROJECT/libraries" | grep "^d" | awk -F" " '{print $9}')
if [ "$project_libraries" ]; then
  mkdir -p "$DIR_WEB/sites/all/libraries"
  for project_library in $project_libraries
  do
    ln -s "$DIR_PROJECT/libraries/$project_library" "$DIR_WEB/sites/all/libraries/$project_library"
    message_success "Symlinked library $project_library."
  done
else
  message_warning "No project libraries available."
fi

echo
