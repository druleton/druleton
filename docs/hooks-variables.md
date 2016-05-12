# Hook variables
Druleton defines a set of variables when the command is run. These variables
are global and can be used in the hooks.

> **Tip** : Use variables always surrounded with "" to avoid breaking scripts
> when a variable contains a string with spaces or special characters:
> ```bash
> DIR_SITES_DEFAULT="$DIR_WEB/sites/default
> ```

## Variables from the config file
Each variable as defined in the config file is available in the hook scripts.
You can add extra variables to the config file.

[See documentation about the config file][link-config-config].


## Variables created during the command bootstrap

#### `$SCRIPT_NAME`
This variable contains the name of the called command (install, reset, upgrade,
build, backup and restore).

#### `$ENVIRONMENT`
The environment for who we are running this script as set using the
`--env=\<env_name\>` option.

#### `$DIR_CURRENT`
The path from where the command is called.

#### `$DIR_BIN`
The `bin` directory where all the commands are located.

#### `$DIR_SRC`
The directory within the bin directory (`bin/src`) where all the command sources
and helpers are located. Use this if you want to include a include script that
is not loaded yet.

#### `$DIR_ROOT`
This is the full directory path to the root of druleton. This is where the
`bin`, `config` and `project` directories are located.

#### `$DIR_PROJECT`
The full directory path where the custom projects profiles, modules and themes
are located. Use this to symlink or copy these resources to the web directory:

```bash
ln -s "$DIR_PROJECT/modules/custom" "$DIR_WEB/sites/all/modules/custom"
```

#### `$DIR_CONFIG`
The full directory path where all the config files are located.

#### `$DIR_CONFIG_BIN`
The full directory path where all the custom commands are located.

#### `$DIR_CONFIG_SRC`
The full directory path where all shared custom scripts are stored. These are
included within hooks and custom commands.

#### `$DIR_WEB`
The full directory path where Drupal will be installed (web root).

#### `$DIR_BACKUP`
The full directory path where backups will be stored. This is the root of the
backups `backup`. Each backup will be stored in its own subdirectory.

#### `$DIR_BUILD`
The full directory path where the build will be stored. Each build will by
default be compressed in a tar.gz file within this folder. The build itself
will happen in the `build/current` directory.

#### `$DRUPAL_INSTALLED`
Is there a working Drupal installation 1/0.

#### `$CONFIRMED`
Is the --confirm or -y option passed to the script.

#### `$COMPOSER_USE_GLOBAL`
Should the globally (1) or locally (0) installed composer binary be used for the
`bin/composer` command.

[see configuration documentation][link-config-config-composer].

#### `$DRUSH_VERSION`
What drush version to install and use.

[see configuration documentation][link-config-config-drush-version].



## Command argument
Some commands have one argument (build, backup & restore). The value of that
argument is accessible using the `$SCRIPT_ARGUMENT` variable.



## Variables from the command options
The variables from the command line are accessible using the
[option helpers][link-hooks-helpers].



[Back to overview][link-overview]



[link-config-config]: config-config.md
[link-config-config-composer]: config-config.md#composer
[link-config-config-drush-version]: config-config.md#drush-version
[link-hooks-helpers]: hooks-helpers.md

[link-overview]: README.md
