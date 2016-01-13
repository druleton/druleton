# bin/composer command
The `bin/composer` command is a wrapper around the
[composer binary][link-composer]. It allows to use a globally installed composer
or a locally copy.

What composer binary to use is defined in the `config/config.sh` file using the
[`$COMPOSER_USE_GLOBAL`][link-config-config-composer] variable.

```bash
$ bin/composer
```



## What does this command do?
This command has only one task: running composer and pass all arguments as used
when the `bin/composer` command is called.



## Command options
Command options documentation can be viewed in the command line interface by
running the command with the `-h` or `--help` option.

```bash
$ bin/composer -h
```

#### Arguments
All arguments will be passed to the composer command. Use this as calling
composer directly. See the [composer documentation][link-composer].

#### Options
- --help (-h) : Show the command help.
- --hook-info : Show information about the available hooks.
- --no-color : Disable all colored output.
- --confirm (-y) : Skip the confirmation step when the script starts.
- --verbose (-v) : Verbose, show extra information while running the command.



## Command hooks
The `bin/composer` command does not support hooks.



[Back to overview][link-overview]



[link-composer]: https://getcomposer.org/
[link-config-config-composer]: config-config.md#composer

[link-overview]: README.md
