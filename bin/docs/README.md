# Drupal Skeleton documentation

Overview off all Skeleton Documentation:

## Commands
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

  
## Configuration
- [config.sh](config-config.md) : The global configuration file.
- [make files](config-make.md) : How to add contrib modules, themes and 
  libraries using the make file configuration.
- [modules](config-modules.md) : Enable and Disable modules during install and
  reset.


## Hooks
- [hook system](hooks.md) : More information about the hook system: add
  your own script steps before and/or after the existing command steps.
- [bin/install hooks](hooks-install.md) : Available hooks for the `bin/install` 
  script.
- [bin/reset hooks](hooks-reset.md) : Available hooks for the `bin/install` 
  script.
- [bin/upgrade hooks](hooks-upgrade.md) : Available hooks for the `bin/upgrade` 
  script.
- [bin/build hooks](hooks-build.md) : Available hooks for the `bin/build` 
  script.
- [bin/backup hooks](hooks-backup.md) : Available hooks for the `bin/backup`
  script.
- [bin/restore hooks](hooks-restore.md) : Available hooks for the `bin/restore`
  script.
