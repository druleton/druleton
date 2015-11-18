# Project specific functionality
The actual project files (custom install profile, modules, themes, javascript
libraries, ...) are stored in the `project` directory.

This is the directory where the actual development is done.

> **Note** The code within the `project` directory is optional. You can setup a
> demo website with configuration and hooks only.

The skeleton has the `config/build/drupal_make_after.sh`,
`config/install/drupal_make_after.sh` and `config/upgrade/drupal_make_after.sh`
hook implemented. The code in those hooks will automatically copy (for build
command) or symlink (install & upgrade) the custom profiles, modules, themes and
libraries from within the project directory.

This will only work if you stick to the default project directory structure.

> **Note** : The proposed structure of the project directory is not mandatory.
> Defining your own directory structure will require to alter the implemented
> hooks so they fit the altered structure.



## Add the custom functionality to the platform
There are 2 common ways to develop custom functionality:
- Create an [install profile][link-install-profile] that contains also the
  custom modules, themes and libraries.
- Put functionality in `custom` directories within the `web/sites/all/modules`
  and `web/sites/all/themes` directories.


#### Build project with an install profile
When creating an [install profile][link-install-profile], the custom modules and
theme(s) are added as subdirectories to the profile:

```
# The directory where the profile is stored:
project/profiles/profile_name

# The directory where the profiles custom modules are stored:
project/profiles/profile_name/modules/custom
project/profiles/profile_name/modules/custom/module_name
project/profiles/profile_name/modules/custom/...
project/profiles/profile_name/modules/features
project/profiles/profile_name/modules/features/feature_name
project/profiles/profile_name/modules/features/...

# The directory where the profile custom theme(s) are stored:
project/profiles/profile_name/themes/theme_name
project/profiles/profile_name/themes/custom
project/profiles/profile_name/themes/custom/theme_name1
project/profiles/profile_name/themes/custom/theme_name2
project/profiles/profile_name/themes/custom/...

# The directory where the profile custom libraries are stored:
project/profiles/profile_name/libraries/library_name1
project/profiles/profile_name/libraries/library_name2
project/profiles/profile_name/libraries/...
```

Adding the custom install profile and its modules, themes and libraries is done
using the `config/install/drupal_make_after.sh` and
`config/upgrade/drupal_make_after.sh` hook:

```bash
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
```

The profile is copied during the build process:

```bash
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
```


#### Build project without install profile
If you develop a website without install profile you should put the custom
modules, themes and libraries in following directories:

```
# The directory where the custom modules are stored:
project/modules/custom
project/modules/custom/module_name
project/modules/features
project/modules/features/feature_name
project/modules/whatever
project/modules/whatever/module_name

# The directory where the custom themes are stored:
project/themes/theme_name
project/themes/custom
project/themes/custom/theme_name1
project/themes/custom/theme_name2

# The directory where the custom libraries are stored:
project/libraries
project/libraries/library_name1
project/libraries/library_name2
```

Adding the custom modules, themes and libraries is done using the
`config/install/drupal_make_after.sh` and `config/upgrade/drupal_make_after.sh`
hook:

```bash
# Symlink modules.
project_modules=$(ls -l "$DIR_PROJECT/modules" | grep "^d" | awk -F" " '{print $9}')
if [ "$project_modules" ]; then
  mkdir -p "$DIR_WEB/sites/all/modules"

  for project_module in $project_modules
  do
    ln -s "$DIR_PROJECT/modules/$project_module" "$DIR_WEB/sites/all/modules/$project_module"
    message_success "Symlinked module directory $project_profile."
  done
else
  message_warning "No project modules available."
fi

# Symlink themes.
project_themes=$(ls -l "$DIR_PROJECT/themes" | grep "^d" | awk -F" " '{print $9}')
if [ "$project_themes" ]; then
  mkdir -p "$DIR_WEB/sites/all/themes"

  for project_theme in $project_themes
  do
    ln -s "$DIR_PROJECT/themes/$project_theme" "$DIR_WEB/sites/all/themes/$project_theme"
    message_success "Symlinked theme directory $project_theme."
  done
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
    message_success "Symlinked library directory $project_library."
  done
else
  message_warning "No project libraries available."
fi
```

The modules, themes and libraries are copied during the build process:

```bash
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
```



[Back to overview][link-overview]



[link-install-profile]: https://www.drupal.org/developing/distributions

[link-overview]: README.md
