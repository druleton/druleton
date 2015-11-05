# bin/upgrade command
The `bin/upgrade` command will download Core & Contributed code based on the
make files and run the update-db command. Use this to update core and
contributed to their latest version or to apply a patch.

A backup will be taken before the reset is run.

The existing `web/sites/default/settings.php`, `web/sites/default/files`
directory and the database will be kept.

```bash
$ bin/upgrade
```



## What does this command do?
The command will perform following script steps:

#### 1. Create a backup
A backup of a working installation will be created and stored in the `backup`
directory.

#### 2. Move web/sites/default directory to temporary location
The `web/sites/default` directory and its content is moved outside the web
directory. This because the fact that the web directory will be deleted and
replaced by running the make files.

#### 3. Cleanup
The directories, as defined in `config/upgrade/cleanup.sh` will be deleted.

#### 4. Make
Drupal core, contributed modules, themes and libraries will be downloaded and
unpacked in the `web` directory.

#### 5. Restore the sites/default directory from temporary location
The `sites/default` directory and its content is moved from the temporary
location back to the `web/sites/default` location.

#### 6. Upgrade drupal
The drupal upgrade script is run using the `drush -y updb` command.

#### 7. Drupal login
A browser will be opened and pointed to the URL as specified in the
[config file][link-config-config].

It will log in using the administrator account.



## Command options
Command options documentation can be viewed in the command line interface by
running the command with the `-h` or `--help` option.

```bash
$ bin/upgrade -h
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
steps in between the reset script without having to alter (hack) the
`bin/upgrade` script as defined in the drupal-skeleton.

See [more info about the hook system][link-hooks].

The hooks for the `bin/upgrade` command should be located in the
`config/upgrade` directory.

The following hooks are supported (in the order as they will be included):


#### config/upgrade/script_before(_\<env\>).sh
This hook is included and run before the script will run its first step.

#### config/upgrade/backup_before(_\<env\>).sh
This hook is included and run before a backup is created.

Warning: this script will be not included if no backup has to be taken (e.g.
when there is no working environment to backup from or when the `--no-backup`
option is used).

#### config/upgrade/backup_after(_\<env\>).sh
This hook is included and run after a backup is created.

Warning: this script will be not included if no backup has to be taken (e.g.
when there is no working environment to backup from or when the `--no-backup`
option is used).

#### config/upgrade/backup_sites_default_before(_\<env\>).sh
This hook is included and run before the `sites/default` directory is moved to
its temporary location.

#### config/upgrade/backup_sites_default_after(_\<env\>).sh
This hook is included and run after the `sites/default` directory is moved to
its temporary location.

#### config/upgrade/cleanup_before(_\<env\>).sh
This hook is included and run before the cleanup of the directories is run.

#### config/upgrade/cleanup_after(_\<env\>).sh
This hook is included and run after the cleanup of the directories is run.

#### config/upgrade/drupal_make_before(_\<env\>).sh
This hook is included and run before the make files are processed, downloaded
and unpacked.

#### config/upgrade/drupal_make_after(_\<env\>).sh
This hook is included and run after the make files are processed, downloaded
and unpacked.

#### config/upgrade/restore_sites_default_before(_\<env\>).sh
This hook is included and run before the `sites/default` directory is moved from
its temporary location to `web/sites/default`.

#### config/upgrade/restore_sites_default_after(_\<env\>).sh
This hook is included and run after the `sites/default` directory is moved from
its temporary location to `web/sites/default`.

#### config/upgrade/drupal_upgrade_before(_\<env\>).sh
This hook is included and run before the drupal update script (`drush -y updb`)
is run.

#### config/upgrade/drupal_upgrade_after(_\<env\>).sh
This hook is included and run after the drupal update script (`drush -y updb`)
is run.

#### config/upgrade/drupal_login_before(_\<env\>).sh
This hook is included and run before a browser is opened and the admin user is
logged in.

Warning: This hook will not be included if the `--no-login` is used.

#### config/upgrade/drupal_login_after(_\<env\>).sh
This hook is included and run after a browser is opened and the admin user is
logged in.

Warning: This hook will not be included if the `--no-login` is used.

#### config/upgrade/script_after(_\<env\>).sh
This hook is included and run when the script is finished.



[Back to overview][link-overview]



[link-config-config]: config-config.md
[link-hooks]: hooks.md

[link-overview]: README.md
