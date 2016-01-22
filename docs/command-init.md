# bin/init command
The `bin/init` command is used to setup druleton and project environment.

It will check the project file structure and create the missing parts.

It will download tools like composer and add them to the `bin` directory. It
will also scan the `config/bin` directory if there are custom, project specific,
commands and add them to the `bin` directory.

You can run this command anytime, it will update the tools and rescan the
`config/bin` directory.

```Shell
$ bin/init
```



## What does this command do?
This command prepares the environment by installing dependencies for druleton
and allows initiation of project specific dependencies by the provided hooks.

The command will perform following script steps:


#### 1. Check if the project structure is in place
The `init` script can be used to start a new project. It will check the root of
the project to see if the neccesary file structure is in place (`config` &
`project` directories).

If not it will create them.

#### 2. Check if druleton is up-to-date
If druleton is installed as a submodule; the init script will do a pull of the
latest version of druleton.

#### 3. Check if config file is in place
If no `config/config.sh` file is available, it will create one based on the
`config/config_example.sh` file.

It will ask for the configuration variables and store them in the
`config/config.sh` file.

#### 4. Download or update composer
[Composer][link-composer] is a package manager for PHP. It is used to download
and install tools like drush.

Composer will be downloaded or updated into the `bin` directory. It can be
called using the following command:

```Shell
$ bin/composer
```

#### 5. Install drush
[Drush][link-drush] is a command line interface to perform actions on drupal. It
is used by druleton to install and interact with the drupal installation in the
`web` directory.

By default the [dev-master][link-drush-master] branch of drush will be used as
the version to install locally. You can set a custom version by defining this in
the [`$DRUSH_VERSION`][link-config-config-drush-version] variable in the config
file. You can also use a globally installed drush version by setting the
`$DRUSH_VERSION` variable to "global".


#### 6. Install drupal/coder
The [`bin/coder`][link-command-coder] command is a wrapper around
PHP_CodeSniffer (phpcs) using the drupal/coder code standards.

The required libraries will be downloaded (or updated) when the `bin/init`
command is run.

> Note: Not all environments require this to be installed. Set the
> [`$CODER_DISABLED`][link-config-config-coder-disabled] variable to 1 to skip
> the installation of the required packages.


#### 7. Add custom commands to the `bin` directory
Druleton allows to define custom commands in the `config/bin` directory.
This step will create a symlink for each custom command to the `bin` directory.
This so all commands are run from the same directory.

See [custom commands documentation][link-config-bin]



## Command options
Command options documentation can be viewed in the command line interface by
running the command with the `-h` or `--help` option.

```Shell
$ bin/init -h
```

#### Arguments
Without argumunt all init steps will run.

Use argument to run the init command with a single step:
- structure : Only check and add missing structure elements.
- druleton : Only update druleton.
- config : Only create or update the config file.
- composer : Only install or update composer.
- drush : Only install or update drush.
- coder : Only install or update drupal coder.
- custom : Only create the custom commands symlinks.

#### Options
Skip steps when running the full command:
- --skip-structure : Do not check and/or create the file structure.
- --skip-druleton : Do not check and/or update drulaton submodule.
- --skip-config : Do not check and/or set the config file.
- --skip-composer : Do not install/update composer.
- --skip-drush : Do not check and install drush.
- --skip-coder : Do not install/update composer.
- --skip-custom : Do not check and symlink custom commands.

- --force (-f) : The init script will only download dependencies if they are not
  yet downloaded. The force option will delete the files and download them
  again. It will also foce the config file step to prompt for all the variables.

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

The hooks for the `bin/init` command should be located in the
`config/init` directory.

The following hooks are supported (in the order as they will be included):


#### config/init/script_before(_\<env\>).sh
This hook is included and run before the script will run its first step.

#### config/init/init_structure_before(_\<env\>).sh
This hook is included and run before the project file structure is checked and
created.

#### config/init/init_structur_after(_\<env\>).sh
This hook is included and run after the project file structure is checked and
created.

#### config/init/init_druleton_before(_\<env\>).sh
This hook is included and run before the druleton git submodule is updated.

#### config/init/init_druleton_after(_\<env\>).sh
This hook is included and run after the druleton git submodule is updated.

#### config/init/config_X(_\<env\>).sh
When the `bin/init` command is run, the config variables are collected and
written to the `config.sh` file.

Four hooks must be implemented to load, collect, review and save custom config
variables to the `config.sh` file:

##### 1. config/init/config_load_current(_\<env\>).sh
This file is used to load the current config variables and store them in
temporary script variables.

> Prefix the variable to store the loaded value with **INIT_CONFIG_**.

```bash
INIT_CONFIG_CUSTOM_VARIABLE="${CUSTOM_VARIABLE}"
```

You can set a default value (if no value is found in the config file) by
adding `:-default_value` ([variable substitution][link-substitution]) to the
assignment:

```bash
INIT_CONFIG_CUSTOM_VARIABLE="${CUSTOM_VARIABLE:-no value yet}"
```

##### 2. config/init/config_collect(_\<env\>).sh
This file is used to prompt for the custom configuration values.

Use the [`prompt`][hooks-helpers-prompt] helper to ask the user for input.
The helper has 2 parameters:

- The question text.
- An optional current value.

Save the collected value by assigning the $REPLY value to the INIT_CONFIG_X
variable:

```bash
markup_h2 "Custom variables"
prompt "Custom variable" "$INIT_CONFIG_CUSTOM_VARIABLE"
INIT_CONFIG_CUSTOM_VARIABLE="${REPLY}"
echo
```

##### 3. config/init/config_confirm(_\<env\>).sh
This file prints out the collected custom variables so the user can review them.

Use the [`markup_li_value`][hooks-helpers-markup_li_value] helper to list the
config variable name and value.

The helper has 2 parameters:
- The variable name.
- The value.

Use variable substitution [variable substitution][link-substitution] to show a -
when no value has been entered (variable is empty):

```bash
markup_h2 "Custom variables"
markup_li_value "Custom variable" "${INIT_CONFIG_CUSTOM_VARIABLE:--}"
```

##### 4. config/init/config_save(_\<env\>).sh
Add in this file the code to save the custom variables to the config file.

Use the `init_config_save_variable` function to save the variable to the config
file.

This function has 2 arguments:
- The variable confg key.
- The variable value.

```bash
init_config_save_variable "CUSTOM_VARIABLE" "${INIT_CONFIG_CUSTOM_VARIABLE}"
```


#### config/init/init_composer_before(_\<env\>).sh
This hook is included and run before composer is installed or updated locally.

#### config/init/init_composer_after(_\<env\>).sh
This hook is included and run after composer is installed or updated locally.

#### config/init/init_drush_before(_\<env\>).sh
This hook is included and run before drush is installed or updated locally.

#### config/init/init_drush_after(_\<env\>).sh
This hook is included and run after drush is installed or updated locally.

#### config/init/init_coder_before(_\<env\>).sh
This hook is included and run before drupal coder is installed or updated
locally.

> Warning: this script will be not included if the installation of coder is
> disabled.

#### config/init/init_coder_after(_\<env\>).sh
This hook is included and run after drupal coder is installed or updated
locally.

> Warning: this script will be not included if the installation of coder is
> disabled.

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
[link-substitution]: http://tldp.org/LDP/abs/html/parameter-substitution.html

[hooks-helpers-prompt]: hooks-helpers.md#prompt
[hooks-helpers-markup_li_value]: hooks-helpers.md#markup_li_value

[link-overview]: README.md
