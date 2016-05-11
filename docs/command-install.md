# bin/install command
The `bin/install` command will download Core & Contributed (modules, themes &
libraries) as defined in the [composer file(s)][link-config-composer], and will install
the website with the settings in the [`config/config.sh`][link-config-config]
file.

When the installation is finished, a browser will be opened and you will be
logged in as platform administrator (user 1).

If there is already a working installation, a backup of it will be taken.

```Shell
$ bin/install
```



## What does this command do?

The command will perform following script steps:

#### 1. Create a backup
If there is already a working installation, a backup of it will be created and
stored in the `backup` directory.

#### 2. Cleanup
The directories, as defined in `config/install/cleanup.sh` will be deleted.

#### 3. Composer
Drupal core, contributed modules, themes and libraries will be downloaded and
unpacked in the `web` directory.

The core version and the modules, themes and libraries as well as optional
patches that needs to be applied to them, are defined in the composer files.
See [composer configuration documentation][link-config-composer].

#### 4. Drupal installation
Drupal will be installed using the installation profile and database credentials
as specified in the [config file][link-config-config].

The administrator account will be set based on the same configuration file.

An existing database will be wiped and replaced by the data of the new install.

#### 5. Modules disable
All modules as specified in the `config/drupal_modules_disable.sh` script will
be disabled.

If there is an environment specific config (eg.
`config/drupal_modules_disable_dev.sh`), modules listed in that file will also
be disabled.

#### 6. Modules enabled
All modules as specified in the `config/drupal_modules_enable.sh` script will
be enabled.

If there is an environment specific config (eg.
`config/drupal_modules_enable_dev.sh`), modules listed in that file will also
be enabled.

#### 7. Drupal login
A browser will be opened and pointed to the URL as specified in the
[config file][link-config-config].

It will log in using the administrator account.



## Command options
Command options documentation can be viewed in the command line interface by
running the command with the `-h` or `--help` option.

```bash
$ bin/install -h
```

#### Arguments
This script has no arguments.

#### Options
- --no-backup : Do not take a backup before the installation is run.
- --no-login : Do not open a webbrowser and login to the website when the
  installation is finished.
- --env=\<name\> : The environment to run the script for (default : dev).
- --help (-h) : Show the command help.
- --hook-info : Show information about the available hooks.
- --no-color : Disable all colored output.
- --confirm (-y) : Skip the confirmation step when the script starts.
- --verbose (-v) : Verbose, show extra information while running the command.



## Command hooks
Each step in the scipt triggers "hooks". These hooks allow you to add extra
steps in between the install script without having to alter (hack) the
`bin/install` script as defined in druleton.

See [more info about the hook system][link-hooks].

The hooks for the `bin/install` command should be located in the
`config/install` directory.

The following hooks are supported (in the order as they will be included):


#### config/install/script_before(_\<env\>).sh
This hook is included and run before the script will run its first step.

#### config/install/backup_before(_\<env\>).sh
This hook is included and run before a backup is created.

Warning: this script will be not included if no backup has to be taken (e.g.
when there is no working environment to backup from or when the `--no-backup`
option is used).

#### config/install/backup_after(_\<env\>).sh
This hook is included and run after a backup is created.

Warning: this script will be not included if no backup has to be taken (e.g.
when there is no working environment to backup from or when the `--no-backup`
option is used).

#### config/install/cleanup_before(_\<env\>).sh
This hook is included and run before the cleanup of the directories is run.

#### config/install/cleanup_after(_\<env\>).sh
This hook is included and run after the cleanup of the directories is run.

#### config/install/drupal_composer_before(_\<env\>).sh
This hook is included and run before the composer files are processed, downloaded
and unpacked.

#### config/install/drupal_composer_after(_\<env\>).sh
This hook is included and run after the composer files are processed, downloaded
and unpacked.

#### config/install/drupal_install_before(_\<env\>).sh
This hook is included and run before the drupal installation is started.

#### config/install/drupal_install_after(_\<dev\>).sh
This hook is included and run after the drupal installation has finished.

#### config/install/drupal_modules_disable_before(_\<env\>).sh
This hook is included and run before the modules are disabled.

Warning: this hook is also run even if there are no modules to disable.

#### config/install/drupal_modules_disable_after(_\<env\>).sh
This hook is included and run before the modules are enabled.

Warning: this hook is also run even if there are no modules to disable.

#### config/install/drupal_modules_enable_before(_\<env\>).sh
This hook is included and run before the modules are enabled.

Warning: this hook is also run even if there are no modules to enable.

#### config/install/drupal_modules_enable_after(_\<env\>).sh
This hook is included and run after the modules are enabled.

Warning: this hook is also run even if there are no modules to enable.

#### config/install/drupal_login_before(_\<env\>).sh
This hook is included and run before a browser is opened and the admin user is
logged in.

Warning: This hook will not be included if the `--no-login` is used.

#### config/install/drupal_login_after(_\<env\>).sh
This hook is included and run after a browser is opened and the admin user is
logged in.

Warning: This hook will not be included if the `--no-login` is used.

#### config/install/script_after(_\<env\>).sh
This hook is included and run when the script is finished.



[Back to overview][link-overview]



[link-config-config]: config-config.md
[link-config-composer]: config-composer.md
[link-hooks]: hooks.md

[link-overview]: README.md
