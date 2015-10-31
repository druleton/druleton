# bin/install command
The `bin/install` command will download Core & Contributed (modules, themes & 
libraries) as defined in the [make file(s)][link-config-make], and will install
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

#### 3. Make
Drupal core, contributed modules, themes and libraries will be downloaded and
unpacked in the `web` directory.

The core version and the modules, themes and libraries as well as optional 
patches that needs to be applied to them, are defined in the make files.
See [make configuration documentation][link-config-make].

#### 4. Drupal installation
Drupal will be installed using the installation profile and database credentials 
as specified in the [config file][link-config-config]. 

The administrator account will be set based on the same configuration file.

#### 5. Modules disable
All modules as specified in the `config/drupal_modules_disable.sh` script will
be disabled. 

If there is an environment specific config (eg.
`config/drupal_modules_disable_dev.sh`); modules listed in that file will also
be disabled.

#### 6. Modules enabled
All modules as specified in the `config/drupal_modules_enable.sh` script will
be enabled. 

If there is an environment specific config (eg. 
`config/drupal_modules_enable_dev.sh`); modules listed in that file will also
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
- --env=<name> : The environment to run the script for (default : dev).
- --help (-h) : Show the command help.
- --hook-info : Show information about the available hooks.
- --no-color : Disable all colored output.
- --confirm (-y) : Skip the confirmation step when the script starts.
- --verbose (-v) : Verbose, show extra information while running the command.



## Command hooks



[Back to overview](README.md)


[link-config-config]: config-config.md
[link-config-make]: config-make.md
