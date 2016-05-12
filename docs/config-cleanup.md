# Cleanup
When a `bin/install` or `bin/upgrade` command is run, a cleanup step is
included.

This cleanup deletes the directories and/or files that will be recreated during
the command run. Example: remove the `web` directory before the command
recreates it by processing the composer files.

Define what directories and/or files by adding them to the `CLEANUP_DIRECTORIES`
and/or `CLEANUP_FILES` arrays in the `config/install/cleanup.sh` and/or
`config/upgrade/cleanup.sh` files.

You can use the [path variables][link-hooks-variables] to prefix the paths.

Example:
```bash
# Files to be deleted before the script is run.
CLEANUP_FILES=(
  "$DIR_WEB/sites/default/settings.php"
)

# Directories to be deleted before the script is run.
CLEANUP_DIRECTORIES=(
  "$DIR_WEB"
)
```

> **Note** : The files are deleted before the directories.

It is possible to define another set per environment by implementing the config
file with an environment suffix:

- `config/install/cleanup.sh` : General cleanup configuration, will be processed
  for all environments.
- `config/install/cleanup_dev.sh` : Will only be processed if the environment is
  *dev*.

> **Note** : The general file will be processed before the environment specific
  one.



[Back to overview][link-overview]



[link-hooks-variables]: hooks-variables.md

[link-overview]: README.md
