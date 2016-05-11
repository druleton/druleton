# Composer file(s)
Druleton uses composer files to download and extract the Drupal
Core, contributed modules and themes as well as 3th party libraries.

[Read more about composer files][link-composer].

The composer file configuration is build around 2 parts:

1. Composer files in the `config/composer` directory to group modules to download for
   specific functionality in composer bundles.
2. Composer configuration arrays (`config/drupal_composer.sh`,
   `config/drupal_composer_\<env/>`) defining what composer files should be used to
   download the dependencies.

Using composer files gives us the advantage that we can:

- Define what version of a module/theme we want to use.
- Define what (optional) patches need to be applied to the downloaded module or
  theme.



## The `config/composer` directory
This directory contains multiple `composer` files. By bundeling modules that
provide together required functionality makes it easier to reuse these files in
multiple projects.

Examples:
- A composer file containing all modules and 3th party libraries to add a WYSIWYG
  editor to the platform (ckeditor module, ckeditor javascript library).
- A composer file containing all modules and 3th party libraries to support media
  management (media, media_youtube, the dependencies for the media modules,
  the plupload javascript library, integration with the WYSIWYG editor, ...).


#### Composer file structure
Each file should start by defining the Drupal version to download for followed
with a short description what kind of functionality it will add.

List then for each module and or theme the version you want followed with the
directory (within the `sites/all` directory) where the module or theme should be
saved.

The path will be automatically prefixed with the type of download:
- For a module with subdir = contrib set : the module will be extracted to
  `web/sites/all/modules/contrib/MODULE_NAME`.
- For a theme with subdir = contrib set : the theme will be extracted to
  `web/sites/all/theme/contrib/THEME_NAME`.

[See the composer file syntax for further info][link-composer].

Example of a composer file called `config/composer/administration/composer.json`.

```php
core = 7.x
api = 2

; Modules to make the life of a Drupal admin more pleasant.

projects[admin_menu][subdir] = "contrib"
projects[admin_menu][version] = "3.0-rc5"

projects[admin_views][subdir] = "contrib"
projects[admin_views][version] = "1.5"
...

...
; Themes to upgrade the admin backend.

projects[adminimal_theme][subdir] = "contrib"
projects[adminimal_theme][version] = "1.22"
projects[adminimal_theme][type] = "theme"
```


#### _core/composer.json
There is one file that is required for the platform and that is the
`config/composer/_core/composer.json` file.

This one will be used to determine what Drupal core should be downloaded and
what (optional) patches should be applied to it.

> **Note** : do not add any modules to this composer file, use the make bundle files
  for it.

Example file:

```php
core = 7.x
api = 2

projects[drupal][version] = "7.39"
```


#### Upgrade core and modules
To upgrade a working platform:

- Update the version number in the composer file for the core, module or theme you
  want to upgrade or define what patches that should be applied to them.
- Run the `bin/upgrade` command to download the versions as defined and apply
  the patches.



## The make configuration file(s)
The `config` directory contains one `drupal_composer.sh` config array and optionally
environment specific config arrays (eg. `drupal_composer_dev.sh`,
`drupal_composer_prod.sh`).

These files list, in an array, what composer file bundles from the `config/composer`
directory should be used during the make step in the install and upgrade
commands. Do not include the `config/composer/_core/composer.json` file in these arrays as
that composer file will always be run first.

The `drupal_composer.sh` file will always be used to download and unpack the
required core, modules, themes and libraries. The environment specific will only
be used if they match the environment set when calling the commands who have
make steps.

Example:

```
MAKE_FILES=(
  "minimal/composer.json"
  "administration/composer.json"
)
```



[Back to overview][link-overview]



[link-composer]: https://getcomposer.org/doc/01-basic-usage.md

[link-overview]: README.md
