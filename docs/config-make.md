# Make file(s)
Druleton uses drush make files to download and extract the Drupal
Core, contributed modules and themes as well as 3th party libraries.

[Read more about drush make files][link-drush-make].

The make file configuration is build around 2 parts:

1. Make files in the `config/make` directory to group modules to download for
   specific functionality in make bundles.
2. Make configuration arrays (`config/drupal_make.sh`,
   `config/drupal_make_\<env/>`) defining what make files should be used to
   download the dependencies.

Using make files gives us the advantage that we can:

- Define what version of a module/theme we want to use.
- Define what (optional) patches need to be applied to the downloaded module or
  theme.



## The `config/make` directory
This directory contains multiple `.make` files. By bundeling modules that
provide together required functionality makes it easier to reuse these files in
multiple projects.

Examples:
- A make file containing all modules and 3th party libraries to add a WYSIWYG
  editor to the platform (ckeditor module, ckeditor javascript library).
- A make file containing all modules and 3th party libraries to support media
  management (media, media_youtube, the dependencies for the media modules,
  the plupload javascript library, integration with the WYSIWYG editor, ...).


#### Make file structure
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

[See the make file syntax for further info][link-drush-make].

Example of a make file called `config/make/administration.make`.

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


#### _core.make
There is one file that is required for the platform and that is the
`config/make/_core.make` file.

This one will be used to determine what Drupal core should be downloaded and
what (optional) patches should be applied to it.

> **Note** : do not add any modules to this make file, use the make bundle files
  for it.

Example file:

```php
core = 7.x
api = 2

projects[drupal][version] = "7.39"
```


#### Upgrade core and modules
To upgrade a working platform:

- Update the version number in the make file for the core, module or theme you
  want to upgrade or define what patches that should be applied to them.
- Run the `bin/upgrade` command to download the versions as defined and apply
  the patches.



## The make configuration file(s)
The `config` directory contains one `drupal_make.sh` config array and optionally
environment specific config arrays (eg. `drupal_make_dev.sh`,
`drupal_make_prod.sh`).

These files list, in an array, what make file bundles from the `config/make`
directory should be used during the make step in the install and upgrade
commands. Do not include the `config/make/_core.make` file in these arrays as
that make file will always be run first.

The `drupal_make.sh` file will always be used to download and unpack the
required core, modules, themes and libraries. The environment specific will only
be used if they match the environment set when calling the commands who have
make steps.

Example:

```
MAKE_FILES=(
  "minimal.make"
  "administration.make"
)
```



[Back to overview][link-overview]



[link-drush-make]: http://www.drush.org/en/master/make/#the-make-file-format

[link-overview]: README.md
