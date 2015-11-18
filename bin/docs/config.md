# Config directory
The `config` directory contains the settings and configuration for the project.

The config directory has following structure:


### config.sh
The `config.sh` file contains the global configuration for the project. It is
specific for the environment where the scripts are run (eg. local development,
test, acceptance, production, ...).

> **Warning** : Don't include this file in the versioning system as it is
> environment specific!

Use the config_example.sh script to give an example of the expected
configuration variables.

**This is the only required file within the `config` directory.**

[Read more about the config.sh file][link-config-config].


### config_example.sh
This file is used to give an example and document the required and optional
configuration variables. Copy this example file per environment where these
scripts are deployed and fill in the actual values.

> **Warning** : Don't store any real usernames and passwords in this file!


### drupal_make.sh
The drupal make file contains an array of make files (from within the
`config/make` directory) that should be included when the make step is run
within a command.

Use the `drupal_make.sh` file to set the global list of make files. These will
be included in all environments.

[Read more about the make files][link-config-make]


### drupal_make_\<env\>.sh
On top of the global make files list, you can also define modules that should be
included only for specific environment.

Example:

- devel module for the `dev` environment.
- memcache module for the `prod` environment.


### drupal_modules_enable.sh
An array of modules that should be enabled after an install or reset command is
run.

Use the `drupal_modules_enable.sh` file to set the global list of modules. These
will be enabled for all environments.

[Read more about the modules configuration][link-config-modules]


### drupal_modules_enable_\<env\>.sh
Use this to enable environment specific modules.

Example:

- devel, field_ui and views_ui modules for the `dev` environment.
- memcache and dfs modules for the `prod` environment.


### drupal_modules_disable.sh
An array of modules that should be disabled after an install or reset command is
run.

Use the `drupal_modules_disable.sh` file to set the global list of modules.
These will be disabled for all environments.

[Read more about the modules configuration][link-config-modules]


### drupal_modules_disable_\<env\>.sh
Use this to disable environment specific modules.


### Subdirectory for each command
Each command has its own configuration subdirectory within the `config`
directory with the same name as the command. These directories contain also
the [implemented hooks][link-hooks] for that command.

The directories are not mandatory, they only need to be created when a hook
implementation or specific configuration file is needed.

The possible command configuration directories are:

- `config/install` : Configuration and hooks for the
  [`bin/install`][link-command-install] command.
- `config/reset` : Configuration and hooks for the
  [`bin/reset`][link-command-reset] command.
- `config/upgrade` : Configuration and hooks for the
  [`bin/upgrade`][link-command-upgrade] command.
- `config/build` : Configuration and hooks for the
  [`bin/build`][link-command-build] command.
- `config/backup` : Configuration and hooks for the
  [`bin/backup`][link-command-backup] command.
- `config/restore` : Configuration and hooks for the
  [`bin/restore`][link-command-restore] command.



[Back to overview][link-overview]



[link-config-config]: config-config.md
[link-config-make]: config-make.md
[link-config-modules]: config-modules.md

[link-command-install]: command-install.md
[link-command-reset]: command-reset.md
[link-command-upgrade]: command-upgrade.md
[link-command-build]: command-build.md
[link-command-backup]: command-backup.md
[link-command-restore]: command-restore.md
[link-hooks]: hooks.md

[link-overview]: README.md

