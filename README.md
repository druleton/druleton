# druleton

[![Author][icon-author]][link-author]
[![License : MIT][icon-license]][link-license]

Set of bash scripts and configuration files to install, reset, upgrade, backup,
restore and build a Drupal project without the need to have Core and Contributed
code in the repository.

The name "druleton" is a combination of **dru**pal and ske**leton**.

* [See the documentation about druleton][link-docs].



## Installation
[See the quick-start guide][link-quick-start] how to install druleton.


## Commands
Druleton provides commands to create a new site and support in development and
deployment.

Each command has a help section that explains the options for it. View the help
by running the command with the `-h` switch.

Example:

```Shell
$ bin/install -h
```


### bin/init
The `bin/init` command is used to setup the druleton environment.

It will check the project file structure and create the missing parts.

It will download tools like composer and add them to the `bin` directory. It
will also scan the `config/bin` directory if there are custom, project specific,
commands and add them to the `bin` directory.

You can run this command anytime, it will update the tools and rescan the
`config/bin` directory.

```Shell
$ bin/init
```

[More information about this command][link-command-init].


### bin/install
The `bin/install` command will download Core & Contributed (modules, themes &
libraries) as defined in the make file(s), and will install the website with
the settings in the config/config.sh file.

When the installation is finished, a browser will be opened and you will be
logged in as platform administrator (user 1).

If there is already a working installation, a backup of it will be taken.

```Shell
$ bin/install
```

[More information about this command][link-command-install].


### bin/reset
The `bin/reset` command will do the same as install without downloading the Core
and Contributed projects. Use this to reset an already installed website to its
fresh-install state.

A backup will be taken before the reset is run.

The `sites/default/settings.php` file, the `sites/default/files` directory and
the database will be removed before the site is reinstalled.

```bash
$ bin/reset
```

[More information about this command][link-command-reset].


### bin/upgrade
The `bin/upgrade` command will download Core & Contributed code based on the
make files and run the update-db command. Use this to update core and
contributed to their latest version or to apply a patch.

A backup will be taken before the reset is run.

The existing settings.php, files directory and database will be kept.

```bash
$ bin/upgrade
```

[More information about this command][link-command-upgrade].


### bin/build
The `bin/build` command will create a deployment package (code) in the `/build`
directory.

```bash
$ bin/build
```

[More information about this command][link-command-build].


### bin/backup
The `bin/backup` command will take a backup of the web directory and the
database. The backup will be stored in the `backup` directory.

You can limit the backup to just the web or files directory or just the database
by passing them as arguments.

```bash
$ bin/backup
```

[More information about this command][link-command-backup].


### bin/restore
The `bin/restore` command will list the available backups from the `backup`
directory and let you choose which one to restore. It will restore the `/web`
directory and the database.

If there is a working environment: a backup of it will be created before the
restore is run.

```bash
$ bin/restore
```

[More information about this command][link-command-restore].


### bin/composer
The `bin/composer` command is a wrapper around the composer.phar binary.

```bash
$ bin/composer
```

[More information about this command][link-command-composer].


### bin/drush
The `bin/drush` command is a wrapper around drush. It will always run the drush
command within the `web` directory.

```bash
$ bin/drush
```

[More information about this command][link-command-drush].


### bin/coder
The `bin/coder` command is a wrapper around the phpcs (PHP Code Sniffer)
binary. It has the proper default settings for the Drupal standards.

```bash
$ bin/coder
```

[More information about this command][link-command-coder].



## More commands

### Composer
The `bin/init` command will download and install composer locally. It can be
called using following command:

```
$ bin/composer
```

### Custom commands
It is possible to add your own, project specific, commands.

[See the custom commands documentation][link-config-bin].



## Alter commands by implementing hooks
Each command has a set of steps it runs trough. All the code related to those
steps are located in the `bin` and `bin/src` directories. This code should not
be altered/hacked.

Druleton provides hooks that are called before and after each step so
extra scripts can be added and run.

The hooks can be implemented only for specific environments by adding the
environment name as postfix to the hook.

See [hooks documentation][link-hooks].



[icon-author]: https://img.shields.io/badge/author-%40sgrame-blue.svg?style=flat-square
[icon-license]: https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square

[link-author]: https://twitter.com/sgrame
[link-license]: LICENSE.md

[link-drupal-requirements]: https://www.drupal.org/requirements
[link-drush]: https://github.com/drush-ops/drush
[link-drupalconsole]: http://drupalconsole.com/

[link-docs]: docs/README.md
[link-command-init]: docs/command-init.md
[link-command-install]: docs/command-install.md
[link-command-reset]: docs/command-reset.md
[link-command-upgrade]: docs/command-upgrade.md
[link-command-build]: docs/command-build.md
[link-command-backup]: docs/command-backup.md
[link-command-restore]: docs/command-restore.md
[link-command-composer]: docs/command-composer.md
[link-command-drush]: docs/command-drush.md
[link-command-coder]: docs/command-coder.md
[link-hooks]: docs/hooks.md
[link-config-bin]: docs/config-bin.sh
[link-quick-start]: docs/quick-start.md
