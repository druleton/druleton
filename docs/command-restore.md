# bin/restore command
The `bin/restore` command will list the available backups from the `backup`
directory and let you choose which one to restore. It will restore the `/web`
directory and the database.

If there is a working environment: a backup of it will be created before the
restore is run.

```bash
$ bin/restore
```



## What does this command do?
The command will perform following script steps:


#### 1. Create a backup
If there is already a working installation, a backup of it will be created and
stored in the `backup` directory.

If an partially restore is run (eg. only web directory or only the database)
only that part will be included in the backup.


#### 2. Restore the platform
Restore the local platform from a backup. You will be promted with a list of
backups to choose from. The list is build depending on what you want to restore
and if that backup has everything required (eg. no full restore possible from
partial backup).

By default a full restore of the `web` directory and the database will be done
based on a backup from the `backup` directory.

You can limit what should be included in the restore by combining following
command options:

- --only-db : Restore only the database.
- --only-files : Restore only the `web/sites/default/files` directory.
- --only-web : Restore only the `web` directory.


#### 3. Drupal login
A browser will be opened and pointed to the URL as specified in the
[config file][link-config-config].

It will log in using the administrator account.



## Command options
Command options documentation can be viewed in the command line interface by
running the command with the `-h` or `--help` option.

```bash
$ bin/restore -h
```

#### Arguments
There is only one (optional) argument: the name of the directory within the
backup directory that should be used as the source for the restore.
A list of all backups to choose from will be listed if no argument is passed.

#### Options
- --no-backup : Do not take a backup before the installation is run.
- --no-login : Do not open a webbrowser and login to the website when the
  installation is finished.
- --only-db : Restore only the database.
- --only-files : Restore only the `web/sites/default/files` directory.
- --only-web : Restore only the `web` directory.
- --env=\<name\> : The environment to run the script for (default : dev).
- --help (-h) : Show the command help.
- --hook-info : Show information about the available hooks.
- --no-color : Disable all colored output.
- --confirm (-y) : Skip the confirmation step when the script starts.
- --verbose (-v) : Verbose, show extra information while running the command.


## Command hooks
Each step in the scipt triggers "hooks". These hooks allow you to add extra
steps in between the restore script without having to alter (hack) the
`bin/restore` script as defined in druleton.

See [more info about the hook system][link-hooks].

The hooks for the `bin/restore` command should be located in the
`config/restore` directory.

The following hooks are supported (in the order as they will be included):


#### config/restore/script_before(_\<env\>).sh
This hook is included and run before the script will run its first step.

#### config/restore/backup_before(_\<env\>).sh
This hook is included and run before a backup is created.

Warning: this script will be not included if no backup has to be taken (e.g.
when there is no working environment to backup from or when the `--no-backup`
option is used).

#### config/restore/backup_after(_\<env\>).sh
This hook is included and run after a backup is created.

Warning: this script will be not included if no backup has to be taken (e.g.
when there is no working environment to backup from or when the `--no-backup`
option is used).

#### config/restore/restore_before(_\<env\>).sh
This hook is included and run before the restore is run.

Warning: this hook will only be called if a backup location is selected and if
that backup exists.

#### config/restore/restore_after(_\<env\>).sh
This hook is included and run after the restore is run.

Warning: this hook will only be called if a backup location is selected and if
that backup exists.

#### config/restore/drupal_login_before(_\<env\>).sh
This hook is included and run before a browser is opened and the admin user is
logged in.

Warning: This hook will not be included if the `--no-login` is used.

#### config/restore/drupal_login_after(_\<env\>).sh
This hook is included and run after a browser is opened and the admin user is
logged in.

Warning: This hook will not be included if the `--no-login` is used.

#### config/restore/script_after(_\<env\>).sh
This hook is included and run when the script is finished.



[Back to overview][link-overview]



[link-config-config]: config-config.md
[link-hooks]: hooks.md

[link-overview]: README.md
