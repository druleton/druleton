# bin/drush command
The `bin/drush` command is a wrapper around the drush command. It allows to run
drush commands from within the root of the project.

```bash
$ bin/drush
```



## What does this command do?
This command has only one task: running drush within the `web` directory and
pass all arguments as used when the `bin/drush` command is called.



## Command options
Command options documentation can be viewed in the command line interface by
running the command with the `-h` or `--help` option.

```bash
$ bin/drush -h
```

#### Arguments
All arguments will be passed to the drush command. Use this as calling drush
directly. See the [drush documentation][link-drush].

#### Options
- --help (-h) : Show the command help.
- --hook-info : Show information about the available hooks.
- --no-color : Disable all colored output.
- --confirm (-y) : Skip the confirmation step when the script starts.
- --verbose (-v) : Verbose, show extra information while running the command.


## Command hooks
The `bin/drush` command does not support hooks.



[Back to overview][link-overview]



[link-drush]: https://github.com/drush-ops/drush

[link-overview]: README.md
