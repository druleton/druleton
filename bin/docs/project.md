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
markup_h2 "Profiles"
file_symlink_subdirectories "$DIR_PROJECT/profiles" "$DIR_WEB/profiles"
```

The profile is copied during the build process:

```bash
markup_h2 "Profiles"
file_copy_subdirectories "$DIR_PROJECT/profiles" "$DIR_WEB/profiles"
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
markup_h2 "Modules"
mkdir -p "$DIR_WEB/sites/all/modules"
file_symlink_subdirectories "$DIR_PROJECT/modules" "$DIR_WEB/sites/all/modules"

markup_h2 "Themes"
mkdir -p "$DIR_WEB/sites/all/themes"
file_symlink_subdirectories "$DIR_PROJECT/themes" "$DIR_WEB/sites/all/themes"

markup_h2 "Libraries"
mkdir -p "$DIR_WEB/sites/all/libraries"
file_symlink_subdirectories "$DIR_PROJECT/libraries" "$DIR_WEB/sites/all/libraries"
```

The modules, themes and libraries are copied during the build process:

```bash
markup_h2 "Modules"
mkdir -p "$DIR_WEB/sites/all/modules"
file_copy_subdirectories "$DIR_PROJECT/modules" "$DIR_WEB/sites/all/modules"

markup_h2 "Themes"
mkdir -p "$DIR_WEB/sites/all/themes"
file_copy_subdirectories "$DIR_PROJECT/themes" "$DIR_WEB/sites/all/themes"

markup_h2 "Libraries"
mkdir -p "$DIR_WEB/sites/all/libraries"
file_copy_subdirectories "$DIR_PROJECT/libraries" "$DIR_WEB/sites/all/libraries"
```



[Back to overview][link-overview]



[link-install-profile]: https://www.drupal.org/developing/distributions

[link-overview]: README.md
