# drupal-skeleton

[![Author][icon-author]][link-author]
[![License : MIT][icon-license]][link-license]

The drupal-skeleton provides a skeleton directory structure, a configuration
directory and a set of commands to easily set up an environment to develop,
test, and deploy a Drupal based project. This without the need to include Drupal
core, contrib modules, themes and libraries in the repository of this project.

> This README file is a placeholder.
> Replace the content of this file with the project specific documentation.

The [drupal-skeleton documentation][link-documentation] is located within the
[`bin/docs`][link-documentation] directory.



## Requirements
The skeleton requires at least bash to run.

[See skeleton requirements][link-requirements].


## Commands
The drupal-skeleton contains a set of bash scripts (commands):

- [`bin/init`][link-command-init] : Setup or update the skeleton environment.
- [`bin/install`][link-command-install] : Download core and required contributed
  modules, themes and libraries and install the project.
- [`bin/reset`][link-command-reset] : Reset an installed project back to its
  freshly installed state.
- [`bin/upgrade`][link-command-upgrade]: Upgrade an installed project.
- [`bin/build`][link-command-build] : Create a package of the project.
- [`bin/backup`][link-command-backup] : Create a backup of the installed project.
- [`bin/restore`][link-command-restore] : Restore the project from one of the
  created backups.
- [`bin/composer`][link-command-composer] : A wrapper around a globally installed or
  local copy of the composer binary.
- [`bin/drush`][link-command-drush] : Run a drush command within the `web`
  directory.
- [`bin/coder`][link-command-coder] : Run code inspections using the
  drupal/coder standards.

[See skeleton documentation][link-documentation].



## Configuration
The drupal-skeleton requires a minimal configuration to get started.

[See skeleton configuration documentation][link-config].



[icon-author]: https://img.shields.io/badge/author-%40sgrame-blue.svg?style=flat-square
[icon-license]: https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square

[link-author]: https://twitter.com/sgrame
[link-license]: bin/LICENSE.md

[link-documentation]: bin/docs/README.md
[link-config]: bin/docs/config.md
[link-requirements]: bin/docs/requirements.md
[link-command-init]: bin/docs/command-init.md
[link-command-install]: bin/docs/command-install.md
[link-command-reset]: bin/docs/command-reset.md
[link-command-upgrade]: bin/docs/command-upgrade.md
[link-command-build]: bin/docs/command-build.md
[link-command-backup]: bin/docs/command-backup.md
[link-command-restore]: bin/docs/command-restore.md
[link-command-composer]: bin/docs/command-composer.md
[link-command-drush]: bin/docs/command-drush.md
[link-command-coder]: bin/docs/command-coder.md
