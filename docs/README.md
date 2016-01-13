# Druleton documentation

Overview of all druleton documentation:


## Quick Start
- [Quick start](quick-start.md) : Short guide to get you started within minutes.


## Requirements
- [Requirements](requirements.md) : Minimal requirements to use druleton.


## Commands
- [bin/init](command-init.md) : Setup the druleton environment.
- [bin/install](command-install.md) : Install the project.
- [bin/reset](command-reset.md) : Reset an existing project back to the
  fresh-installed state.
- [bin/upgrade](command-upgrade.md) : Upgrade an existing project by downloading
  core & contributed as defined in the make files, and update drupal by running
  `drush updb` command afterwards.
- [bin/build](command-build.md) : Create a package of the project ready to be
  deployed on production.
- [bin/backup](command-backup.md) : Create a backup of the installed project.
- [bin/restore](command-restore.md) : Restore one of the backups.
- [bin/composer](command-composer.md) : A wrapper around a globally installed or
  local copy of the composer binary.
- [bin/drush](command-drush.md) : Run a drush command within the `web`
  directory.
- [bin/coder](command-coder.md) : Wrapper around the phpcs (PHP Code Sniffer)
  binary. It has the proper default settings for the Drupal standards.

Commands installed during the init command:
- [bin/...](config-bin.md) : Any custom command as defined in the `config/bin`
  directory.


## Configuration
- [config](config.md) : The structure of the `config` directory.
- [config.sh](config-config.md) : The global configuration file.
- [make files](config-make.md) : How to add contrib modules, themes and
  libraries using the make file configuration.
- [modules](config-modules.md) : Enable and Disable modules during install and
  reset.
- [cleanup](config-cleanup.md) : Delete directories and files when the `web`
  directory is (re)built.
- [custom commands](config-bin.md) : Add custom commands to the `config/bin` so
  `bin/init` command can detect them and add them to the `bin` directory.
- [coder](config-drupal-coder.md) : Configuration for the `config/coder`
  command.


## Hooks
- [hook system](hooks.md) : More information about the hook system: add
  your own script steps before and/or after the existing command steps.
- [hook helpers](hooks-helpers.md) : Overview of all helper functions that can
  be used when writing hooks.
- [predefined variables](hooks-variables.md) : Overview of all variables that
  can be accessed and used when writing hooks.


## Project
- [project](project.md) : Add custom install profiles, modules, themes and
  libraries to the project.


## Editor (IDE)
- [Editor setup](editor.md) : Info how to setup your editor (IDE).
