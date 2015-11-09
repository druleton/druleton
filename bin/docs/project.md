# Project specific functionality
The actual project files (custom install profile, modules, themes, javascript
libraries, ...) are stored in the `project` directory.

This is the directory where the actual development is done.

> **Note** : The proposed structure of the project directory is not mandatory.
> It's up to the implementation, configuration and implemented hooks what is
> stored where and how it is added to the `web` and `build` directories.

> **Tip** : Configure your IDE so that it has the skeleton root directory as
> the root of the project. Exclude the `backup`, `build` and the symlinks to the
> `project` directories. This to avoid duplicated code being indexed in the IDE.

The code within the `project` directory is optional. You can setup a demo
website with configuration and hooks only.


## Add the custom functionality to the platform
The custom code is added to the platform by added symlinks to the `web`
directory for non-production environments (dev, tst, acc, ...) and copy the
directories and files when building the platform.

#### Symlink a profile
When creating an [install profile][link-install-profile], the custom modules and
theme(s) are added as subdirectories to the profile:

```
# The directory where the profile is stored:
project/profiles/profile-name

# The directory where the profiles custom modules are stored:
project/profiles/profile_name/modules/custom
project/profiles/profile_name/modules/custom/module_name1
project/profiles/profile_name/modules/custom/module_name2
project/profiles/profile_name/modules/custom/...


# The directory where the profile custom theme(s) are stored:
project/profiles/profile_name/themes/custom
project/profiles/profile_name/themes/custom/theme_name1
project/profiles/profile_name/themes/custom/theme_name2
project/profiles/profile_name/themes/custom/...

# The directory where the profile custom libraies are stored:
project/profiles/profile_name/libraries/library_name1
project/profiles/profile_name/libraries/library_name2
project/profiles/profile_name/libraries/...
```

Adding the custom install profile and its modules, themes and libraries is done
using the `config/install/drupal_make_after.sh` and
`config/upgrade/drupal_make_after.sh` hook:

```bash
# Add symlinks from the project folder.
markup_h1 "Symlink custom modules and themes."

# Symlink modules.
if [ ! -L "$DIR_WEB/profiles/profile_name" ]; then
  ln -s "$DIR_PROJECT/profiles/profile_name" "$DIR_WEB/profiles/profile_name"
  message_success "Symlinked profile_name."
else
  message_warning "Symlink already exists for profile_name."
fi

echo
```

#### Build profile
Building a platform with install profile is done by implementing the
`config/build/drupal_make_after.sh` hook:

```bash
# Add the code from the project folder.
markup_h1 "Copy custom install profile to build."

# Copy modules.
cp -R "$DIR_PROJECT/profile/profile_name" "$DIR_BUILD/web/profiles/profile_name"
if [ $? -ne 1 ]; then
  message_success "Copied profile_name."
else
  message_error "Could not copy profile_name."
fi
```


#### Symlink modules and themes
If you develop a website without install profile you should put the custom code
and themes in following directories:

```
# The directory where the custom modules are stored:
project/modules/custom
project/modules/custom/module_name1
project/modules/custom/module_name2

# The directory where the custom themes are stored:
project/themes/custom
project/themes/custom/theme_name1
project/themes/custom/theme_name2
```

Adding the custom themes and libraries is done by implementing the
`config/install/drupal_make_after.sh` and `config/upgrade/drupal_make_after.sh`
hook:


```bash
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
```

#### Build with modules and themes
Building a platform without install profile is done by implementing the
`config/build/drupal_make_after.sh` hook:

```build
# Copy from the project folder.
markup_h1 "Copy custom modules and themes."

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
```



[Back to overview][link-overview]



[link-install-profile]: https://www.drupal.org/developing/distributions

[link-overview]: README.md
