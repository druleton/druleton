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
The skeleton requires at least a bash to run.

[See skeleton requirements][link-requirements].


## Commands
The drupal-skeleton contains a set of bash scripts (commands):

- [`bin/install`][link-command-install] : Install the project.
- [`bin/reset`][link-command-reset] : Reset an installed project back to its
  freshly installed state.
- [`bin/upgrade`][link-command-upgrade]: Upgrade an installed project.
- [`bin/build`][link-command-build]: Build a package ready to deploy to a
  production environment.
- [`bin/backup`][link-command-backup]: Create a backup of the installed project.
- [`bin/restore`][link-command-restore]: Restore the project from one of the
  created backups.

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
[link-command-install]: bin/docs/command-install.md
[link-command-reset]: bin/docs/command-reset.md
[link-command-upgrade]: bin/docs/command-upgrade.md
[link-command-build]: bin/docs/command-build.md
[link-command-backup]: bin/docs/command-backup.md
[link-command-restore]: bin/docs/command-restore.md