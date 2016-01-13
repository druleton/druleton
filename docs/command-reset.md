# bin/reset command
The `bin/reset` command will do the same as `bin/install` without downloading
the Core and Contributed projects. Use this to reset an already installed
website to its fresh-install state.

A backup will be taken before the reset is run.

The `sites/default/settings.php` file, the `sites/default/files` directory and
the database will be removed before the site is reinstalled.

```bash
$ bin/reset
```


## What does this command do?
The command will perform following script steps:

#### 1. Create a backup
A backup of a working installation will be created and stored in the `backup`
directory.

#### 2. Cleanup
The directories, as defined in `config/reset/cleanup.sh` will be deleted.

#### 3. Drupal installation
Drupal will be installed using the installation profile and database credentials
as specified in the [config file][link-config-config].

The administrator account will be set based on the same configuration file.

All existing data in the database will be deleted and replaced by the data of
the new install.

#### 4. Modules disable
All modules as specified in the `config/drupal_modules_disable.sh` script will
be disabled.

If there is an environment specific config (eg.
`config/drupal_modules_disable_dev.sh`), modules listed in that file will also
be disabled.

#### 5. Modules enabled
All modules as specified in the `config/drupal_modules_enable.sh` script will
be enabled.

If there is an environment specific config (eg.
`config/drupal_modules_enable_dev.sh`), modules listed in that file will also
be enabled.

#### 6. Drupal login
A browser will be opened and pointed to the URL as specified in the
[config file][link-config-config].

It will log in using the administrator account.



## Command options
Command options documentation can be viewed in the command line interface by
running the command with the `-h` or `--help` option.

```bash
$ bin/reset -h
```

#### Arguments
This script has no arguments.

#### Options
- --no-backup : Do not take a backup before the reset is run.
- --no-login : Do not open a webbrowser and login to the website when the reset
  is finished.
- --env=\<name\> : The environment to run the script for (default : dev).
- --help (-h) : Show the command help.
- --hook-info : Show information about the available hooks.
- --no-color : Disable all colored output.
- --confirm (-y) : Skip the confirmation step when the script starts.
- --verbose (-v) : Verbose, show extra information while running the command.



## Command hooks
Each step in the scipt triggers "hooks". These hooks allow you to add extra
steps in between the reset script without having to alter (hack) the
`bin/reset` script as defined in druleton.

See [more info about the hook system][link-hooks].

The hooks for the `bin/reset` command should be located in the
`config/reset` directory.

The following hooks are supported (in the order as they will be included):


#### config/reset/script_before(_\<env\>).sh
This hook is included and run before the script will run its first step.

#### config/reset/backup_before(_\<env\>).sh
This hook is included and run before a backup is created.

Warning: this script will be not included if no backup has to be taken (e.g.
when there is no working environment to backup from or when the `--no-backup`
option is used).

#### config/reset/backup_after(_\<env\>).sh
This hook is included and run after a backup is created.

Warning: this script will be not included if no backup has to be taken (e.g.
when there is no working environment to backup from or when the `--no-backup`
option is used).

#### config/reset/cleanup_before(_\<env\>).sh
This hook is included and run before the cleanup of the directories is run.

#### config/reset/cleanup_after(_\<env\>).sh
This hook is included and run after the cleanup of the directories is run.

#### config/reset/drupal_install_before(_\<env\>).sh
This hook is included and run before the drupal installation is started.

#### config/reset/drupal_install_after(_\<dev\>).sh
This hook is included and run after the drupal installation has finished.

#### config/reset/drupal_modules_disable_before(_\<env\>).sh
This hook is included and run before the modules are disabled.

Warning: this hook is also run even if there are no modules to disable.

#### config/reset/drupal_modules_disable_after(_\<env\>).sh
This hook is included and run before the modules are enabled.

Warning: this hook is also run even if there are no modules to disable.

#### config/reset/drupal_modules_enable_before(_\<env\>).sh
This hook is included and run before the modules are enabled.

Warning: this hook is also run even if there are no modules to enable.

#### config/reset/drupal_modules_enable_after(_\<env\>).sh
This hook is included and run after the modules are enabled.

Warning: this hook is also run even if there are no modules to enable.

#### config/reset/drupal_login_before(_\<env\>).sh
This hook is included and run before a browser is opened and the admin user is
logged in.

Warning: This hook will not be included if the `--no-login` is used.

#### config/reset/drupal_login_after(_\<env\>).sh
This hook is included and run after a browser is opened and the admin user is
logged in.

Warning: This hook will not be included if the `--no-login` is used.

#### config/reset/script_after(_\<env\>).sh
This hook is included and run when the script is finished.



[Back to overview][link-overview]



[link-config-config]: config-config.md
[link-hooks]: hooks.md

[link-overview]: README.md
