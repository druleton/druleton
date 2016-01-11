# Module configuration
When installing a platform disabeling by-default installed modules and enabeling
extra modules can be required. Druleton provides two optional configuration
files to define what modules should be disabled and enabled.


## Disable modules
The `config/drupal_modules_disable.sh` file contains an array of module names
that should be disabled once the platform is installed. This list will be
processed for all environments.

Example:
```bash
MODULES_DISABLE=(
  "color"
  "overlay"
  "search"
  "shortcut"
  "update"
)
```

There is the option to define a list for each environments (dev, tst, prod, ...)
by adding a config file with an environment suffix.

Example for the production environment (`config/drupal_modules_disable_prd.sh`):
```bash
MODULES_DISABLE=(
  "field_ui"
)
```



## Enable modules
The `config/drupal_modules_enable.sh` file contains an array of module names
that should be enabled once the platform is installed. This list will be
processed for all environments.

Example:
```bash
MODULES_ENABLE=(
  # Administration.
  "admin_views"
  "adminimal"
  "adminimal_admin_menu"
  "module_filter"
  # Minimal.
  "ctools"
  "entity"
  "entityreference"
  "jquery_update"
  "libraries"
  "pathauto"
  "redirect"
  "token"
  "transliteration"
  "views"
  "views_bulk_operations"
)
```

There is the option to define a list for each environments (dev, tst, prod, ...)
by adding a config file with an environment suffix.

Example for the development environment (`config/drupal_modules_enable_dev.sh`):
```bash
MODULES_ENABLE=(
  "devel"
  "devel_generate"
  "views_ui"
)
```



[Back to overview][link-overview]



[link-overview]: README.md
