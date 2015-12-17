# bin/init command
The `bin/init` command is used to setup the skeleton and project environment.
It will download tools like composer and add them to the `bin` directory. It
will also scan the `config/bin` directory if there are custom, project specific,
commands and add them to the `bin` directory.

You can run this command anytime, it will update the tools and rescan the
`config/bin` directory.

```bash
$ bin/init
```



## What does this command do?
This command prepares the environment by installing dependencies for the
skeleton and allows initiation of project specific dependencies by the provided
hooks.

The command will perform following script steps:

#### 1. Download or update composer
[Composer][link-composer] is a package manager for PHP. It is used to download
and install tools like drush.

Composer will be downloaded or updated into the `bin` directory. It can be
called using the following command:

```bash
$ bin/composer
```

#### 2. Install drush
[Drush][link-drush] is a command line interface to perform actions on drupal. It
is used by the skeleton to install and interact with the drupal installation in
the `web` directory.

By default the [dev-master][link-drush-master] branch of drush will be used as
the version to install locally. You can set a custom version by defining this in
the [`$DRUSH_VERSION`][link-config-config-drush-version] variable in the config
file. You can also use a globally installed drush version by setting the
`$DRUSH_VERSION` variable to "global".


#### 3. Install drupal/coder
The [`bin/coder`][link-command-coder] command is a wrapper around
PHP_CodeSniffer (phpcs) using the drupal/coder code standards.

The required libraries will be downloaded (or updated) when the `bin/init`
command is run.

> Note: Not all environments require this to be installed. Set the
> [`$CODER_DISABLED`][link-config-config-coder-disabled] variable to 1 to skip
> the installation of the required packages.


#### 4. Add custom commands to the `bin` directory
The skeleton allows to define custom commands in the `config/bin` directory.
This step will create a symlink for each custom command to the `bin` directory.
This so all commands are run from the same directory.

See [custom commands documentation][link-config-bin]



## Command options
Command options documentation can be viewed in the command line interface by
running the command with the `-h` or `--help` option.

```bash
$ bin/init -h
```

#### Arguments
There are no arguments for this command.

#### Options
- --env=\<name\> : The environment to run the script for (default : dev).
- --help (-h) : Show the command help.
- --hook-info : Show information about the available hooks.
- --no-color : Disable all colored output.
- --confirm (-y) : Skip the confirmation step when the script starts.
- --verbose (-v) : Verbose, show extra information while running the command.


## Command hooks
Each step in the scipt triggers "hooks". These hooks allow you to add extra
steps in between the install script without having to alter (hack) the
`bin/backup` script as defined in the drupal-skeleton.

See [more info about the hook system][link-hooks].

The hooks for the `bin/init` command should be located in the
`config/init` directory.

The following hooks are supported (in the order as they will be included):


#### config/init/script_before(_\<env\>).sh
This hook is included and run before the script will run its first step.

#### config/init/init_composer_before(_\<env\>).sh
This hook is included and run before composer is installed or updated locally.

#### config/init/init_composer_after(_\<env\>).sh
This hook is included and run after composer is installed or updated locally.

#### config/init/init_drush_before(_\<env\>).sh
This hook is included and run before drush is installed or updated locally.

#### config/init/init_drush_after(_\<env\>).sh
This hook is included and run after drush is installed or updated locally.

#### config/init/init_custom_commands_before(_\<env\>).sh
This hook is included and run before the custom commands are added to the `bin`
directory.

> Warning: this script will be not included if no custom commands are defined.

#### config/init/init_custom_commands_before(_\<env\>).sh
This hook is included and run after the custom commands are added to the `bin`
directory.

> Warning: this script will be not included if no custom commands are defined.

#### config/init/script_after(_\<env\>).sh
This hook is included and run when the script is finished.



[Back to overview][link-overview]



[link-hooks]: hooks.md
[link-config-bin]: config-bin.sh
[link-composer]: https://getcomposer.org
[link-drush]: https://github.com/drush-ops/drush
[link-drush-master]: https://github.com/drush-ops/drush/tree/master
[link-config-config-drush-version]: config-config.md#drush-version
[link-command-coder]: command-drupal-coder.md
[link-config-config-coder-disabled]: config-config.md#coder

[link-overview]: README.md
