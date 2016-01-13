# bin/coder command
The coder command is a wrapper around the [phpcs][link-phpcs] (PHP Code Sniffer)
binary.

```bash
$ bin/coder
```



## What does this command do?
This command uses [phpcs][link-phpcs] and the Drupal coding standards as
provided by the [drupal/coder][link-drupal-coder] project to inspect files and
directories if they don't contain code style violations.

It will by default do a code inspection on all directories as defined in the
[`$CODER_DIRECTORIES`][link-config-drupal-coder-directories] variable in the
[`config/drupal_coder.sh`][link-config-drupal-coder] configuration file.

It provides the option to configure
[extensions to scan][link-config-drupal-coder-extensions] and
[ignore patterns][link-config-drupal-coder-ignore] in the
[`config/drupal_coder.sh`][link-config-drupal-coder] configuration file.



## Command options
Command options documentation can be viewed in the command line interface by
running the command with the `-h` or `--help` option.

```bash
$ bin/coder -h
```

#### Arguments
All arguments will be passed to the phpcs command. Use this as calling phpcs
directly. See the [phpcs documentation][link-phpcs-doc].

#### Options
- --help (-h) : Show the command help.
- --hook-info : Show information about the available hooks.
- --no-color : Disable all colored output.
- --confirm (-y) : Skip the confirmation step when the script starts.
- --verbose (-v) : Verbose, show extra information while running the command.


## Command hooks
The `bin/coder` command does not support hooks.



[Back to overview][link-overview]

[link-config-drupal-coder]: config-drupal-coder.md
[link-config-drupal-coder-directories]: config-drupal-coder.md#directories
[link-config-drupal-coder-extensions]: config-drupal-coder.md#extensions
[link-config-drupal-coder-ignore]: config-drupal-coder.md#ignore
[link-drupal-coder]: https://www.drupal.org/project/coder
[link-phpcs]: https://github.com/squizlabs/PHP_CodeSniffer
[link-phpcs-doc]: https://github.com/squizlabs/PHP_CodeSniffer/wiki


[link-overview]: README.md
