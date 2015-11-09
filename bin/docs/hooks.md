# Hook system
The hook system allows you to insert extra scripts in the commands without
having to alter (hack) the command code. This makes it possible to update the
`bin` directory without overriding the added code.

- Running a command will trigger a hook when the command starts to run and when
  it is finished.
- Each step in a command has a before and after hook. See the
  [commands documentation][link-commands] for an overview of all available
  hooks.

All hooks are stored in the `config/<command-name>` directory. See the
[commands documentation][link-commands] for an overview of the hooks and their
location.

You can access this information also by running the command with the
`--hook-info` option:

```bash
$ bin/install --hook-info
```

Use the hook system to:
- Set configuration for specific modules.
- Symlink custom code from the `project` directory to the `web/sites/all/...`
  directories.
- ...

There is a general hook file (without an environment suffix), this one will be
included for all environments. The environment specific hook will only be
included when it matches the environment as set in the `--env=<env_name>`
option.

If both are available: the general hook will always included and run first
followed by the environment specific one.



## Writing hooks
The hook code is run by including the hook file before or after a step as
defined by the hook name.

All hooks should be written in [bash][link-bash].

The skeleton provides helper functions to format output, call drush commands,
...

See the [helper functions documentation][link-hooks-helpers]



[Back to overview][link-overview]



[link-commands]: README.md
[link-bash]: http://www.tldp.org/LDP/abs/html/
[link-hooks-helpers]: hooks-helpers.md

[link-overview]: README.md
