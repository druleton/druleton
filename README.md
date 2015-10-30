# drupal-skeleton

[![Author][icon-author]][link-author]
[![License : MIT][icon-license]][link-license]

Set of bash scripts and configuration files to install, reset, upgrade, backup,
restore and build a Drupal project without the need to have Core and Contributed
code in the repository.


## 6 commands
The skeleton provides 6 commands to run the site locally.

Each command has a help section that explains the options for it. View the help
by running the command with the `-h` switch.

Example:

```Shell
$ bin/install -h
```


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

### bin/upgrade
The `bin/upgrade` command will download Core & Contributed code based on the
make files and run the update-db command. Use this to update core and 
contributed to their latest version or to apply a patch.

A backup will be taken before the reset is run.

The existing settings.php, files directory and database will be kept.

```bash
$ bin/upgrade
```

### bin/build
The `bin/build` command will create a deployment package (code) in the `/build`
directory.

```bash
$ bin/build
```

### bin/backup
The `bin/backup` command will take a backup of the web directory and the 
database. The backup will be stored in the `/backup` directory.

You can limit the backup to just the web or files directory or just the database
by passing them as arguments.

```bash
$ bin/backup
```

### bin/restore
The `bin/restore` command will list the available backups and let you choose 
which one to restore. It will restore the `/web` directory and the database.

If there is a working environment: a backup of it will be created before the 
restore is run.

```bash
$ bin/restore
```


## Requirements
This skeleton requires a working bash environment. This comes standard with 
Linux distributions and Mac OSX.

On top of that it requires you to have a working Apache, Mysql & PHP 
environment, see [minimal requirements to run Drupal][link-drupal-requirements].

You also need to have [drush][link-drush] installed. There is no support for 
[drupalconsole][link-drupalconsole] for Drupal 8 (yet).  


## Installation
* Download or clone this repository.
* Copy the `config/config_example.sh` file to `config/config.sh` and fill in the 
  details.
* Create an empty database with the credentials as set in the `config.sh` file. 
* Add one or more `.make` files in the `config/make` directory.
* Change the Drupal version (if required) in the `config/make/_core.make` file and
  add optional patches to apply to core.
* Run the `bin/install`  command.
* The necessary files will be downloaded, Drupal will be installed, a browser will
  be opened and you will be logged in.


## Alter commands by implementing hooks
Each command has a set of steps it runs trough. All the code related to those 
steps are located in the `bin` and `bin/src` directories. This code should not 
be altered/hacked.
 
The drupal-skeleton provides hooks that are called before and after each step so
extra scripts can be added and run. 

The hooks can be implemented only for specific environments by adding the 
environment name as postfix to the hook:

```
# Included on all environments:
config/install/drupal_install_after.sh

# Included only on the tst environment:
config/install/drupal_install_after_tst.sh
```

Each command has an argument to list the available hooks and where the hook 
files should be located.

Example for the install command:

```bash
$ bin/install --hook-info
```

Will output:

```
================================================================================
 Hook information for bin/install
================================================================================

The hook system allows you to plugin bash scripts before or after each step in
the script. You can implement hooks specific for your projects (eg. add
symlinks, delete files, set file permissions, ...).

You can implement a hook before (eg. backup_before.sh) and/or after
(eg. backup_after) a script step. You can implement a general hook
(eg. backup_before.sh) and/or a script specific for the environment the script
is run for (eg. backup_before_tst.sh).

All the hook scripts should be placed in the config/install/ directory.

Find out more about the bin/install by reading the help:
 $ bin/install -h


Available hooks:
(_dev) is optional. Fill in the environment name you want to run specific
hooks for. The hooks are listed in the order of the script steps.

Before the script is run
config/install/script_before(_dev).sh

Create backup of existing platform
config/install/backup_before(_dev).sh
config/install/backup_after(_dev).sh

Cleanup files and directories
config/install/cleanup_before(_dev).sh
config/install/cleanup_after(_dev).sh

Drupal Make file(s)
config/install/drupal_make_before(_dev).sh
config/install/drupal_make_after(_dev).sh

Install Drupal
config/install/drupal_install_before(_dev).sh
config/install/drupal_install_after(_dev).sh

Disable modules & themes
config/install/drupal_modules_disable_before(_dev).sh
config/install/drupal_modules_disable_after(_dev).sh

Enable modules & themes
config/install/drupal_modules_enable_before(_dev).sh
config/install/drupal_modules_enable_after(_dev).sh

Drupal login
config/install/drupal_login_before(_dev).sh
config/install/drupal_login_after(_dev).sh

After the script has run
config/install/script_after(_dev).sh
```


[icon-author]: https://img.shields.io/badge/author-%40sgrame-blue.svg?style=flat-square
[icon-license]: https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square

[link-author]: https://twitter.com/sgrame
[link-license]: LICENSE.md

[link-drupal-requirements]: https://www.drupal.org/requirements
[link-drush]: https://github.com/drush-ops/drush
[link-drupalconsole]: http://drupalconsole.com/
