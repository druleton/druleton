# bin/backup command
The `bin/backup` command will take a backup of the web directory and the
database. The backup will be stored in the `backup` directory.

You can limit the backup to only the `web` or `web/default/files` directory or
only the database by passing them as arguments.

```bash
$ bin/backup
```



## What does this command do?
This command has only one task: taking a backup of the currently installed
platform. By default a backup of the full `web` directory and the database will
be taken.

You can limit what should be included in the backup by combining following
command options:

- --only-db : Backup only the database.
- --only-files : Backup only the `web/sites/default/files` directory.
- --only-web : Backup only the `web` directory.



## Command options
Command options documentation can be viewed in the command line interface by
running the command with the `-h` or `--help` option.

```bash
$ bin/backup -h
```

#### Arguments
There is only one argument for the backup script: the name of the directory
within the backup directory where the backup files should be stored. The current
timestamp will be used if no argument is passed.

#### Options
- --only-db : Backup only the database.
- --only-files : Backup only the `web/sites/default/files` directory.
- --only-web : Backup only the `web` directory.
- --env=\<name\> : The environment to run the script for (default : dev).
- --help (-h) : Show the command help.
- --hook-info : Show information about the available hooks.
- --no-color : Disable all colored output.
- --confirm (-y) : Skip the confirmation step when the script starts.
- --verbose (-v) : Verbose, show extra information while running the command.


## Command hooks
Each step in the scipt triggers "hooks". These hooks allow you to add extra
steps in between the install script without having to alter (hack) the
`bin/backup` script as defined in druleton.

See [more info about the hook system][link-hooks].

The hooks for the `bin/backup` command should be located in the
`config/backup` directory.

The following hooks are supported (in the order as they will be included):


#### config/backup/script_before(_\<env\>).sh
This hook is included and run before the script will run its first step.

#### config/backup/backup_before(_\<env\>).sh
This hook is included and run before a backup is created.

Warning: this script will be not included if no backup can be taken (e.g.
when there is no working environment to backup from).

#### config/backup/backup_after(_\<env\>).sh
This hook is included and run after a backup is created.

Warning: this script will be not included if no backup can be taken (e.g.
when there is no working environment to backup from).

#### config/backup/script_after(_\<env\>).sh
This hook is included and run when the script is finished.



[Back to overview][link-overview]



[link-hooks]: hooks.md

[link-overview]: README.md
