
################################################################################
# Use this file to add custom script steps that should run after the make files
# have run for the build script.
################################################################################


# Add the custom code from the project folder.
markup_h1 "Copy project profiles, modules, themes and libraries."

# Copy profiles.
project_profiles=$(ls -l "$DIR_PROJECT/profiles" | grep "^d" | awk -F" " '{print $9}')
if [ "$project_profiles" ]; then
  for project_profile in $project_profiles
  do
    cp -R "$DIR_PROJECT/profiles/$project_profile" "$DIR_BUILD/web/profiles/$project_profile"
    message_success "Copied profile $project_profile."
  done
else
  message_warning "No project profiles available."
fi

# Copy modules.
project_modules=$(ls -l "$DIR_PROJECT/modules" | grep "^d" | awk -F" " '{print $9}')
if [ "$project_modules" ]; then
  mkdir -p "$DIR_BUILD/web/sites/all/modules"

  for project_module in $project_modules
  do
    cp -R "$DIR_PROJECT/modules/$project_module" "$DIR_BUILD/web/sites/all/modules/$project_module"
    message_success "Copied modules directory $project_module."
  done
else
  message_warning "No project modules available."
fi

# Copy themes.
project_themes=$(ls -l "$DIR_PROJECT/themes" | grep "^d" | awk -F" " '{print $9}')
if [ "$project_themes" ]; then
  mkdir -p "$DIR_BUILD/web/sites/all/themes"

  for project_theme in $project_themes
  do
    cp -R "$DIR_PROJECT/themes/$project_theme" "$DIR_BUILD/web/sites/all/themes/$project_theme"
    message_success "Copied themes directory $project_theme."
  done
else
  message_warning "No project themes available."
fi

# Copy libraries.
project_libraries=$(ls -l "$DIR_PROJECT/libraries" | grep "^d" | awk -F" " '{print $9}')
if [ "$project_libraries" ]; then
  mkdir -p "$DIR_BUILD/web/sites/all/libraries"

  for project_library in $project_libraries
  do
    cp -R "$DIR_PROJECT/libraries/$project_library" "$DIR_WEB/sites/all/libraries/$project_library"
    message_success "Copied library $project_library."
  done
else
  message_warning "No project libraries available."
fi

echo
