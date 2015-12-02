# Custom commands (config/bin)
The skeleton allows to create extra, custom, commands. These can be platform
specific, that is why they are not stored within the skeleton `bin` directory.

The custom commands need to be stored in the `config/bin` directory.

The `bin/init` directory scans these commands and adds symlinks to them from
within the `bin` directory.

So creating a custom command `hello` in de `config/bin` directory will be
available as `bin/hello` once the `bin/init` script is called.



## Create custom commands
Each custom command should be build as the base base commands: they should use
the path variables and skeleton variables as documented in the
[variables documentation][hooks-variables].


### Open with shebang
Start the script by letting the CLI know that it is a bash script:
```
#!/bin/bash
```


### Check if script is symlinked
The script should not be called within its original location. Check this by
adding the following code to the beginning of the command:
```
# Check if on the proper place (symlinked from within the bin directory).
if [ ! -f "$(dirname $0)/src/bootstrap.sh" ]; then
  echo "ERROR : This script should be called from within the bin directory!"
  echo
  exit 1
fi
```


### Include the bootstrap
Include the bootstrap script, this will include the skeleton helpers and create
all global variables.
```
# Bootstrap the skeleton.
source $(dirname $0)/src/bootstrap.sh
```


### Show some information about the command
Inform users what the script will do by adding an informational header to the
output (optional):
```
# Show some output explaining what the command will do.
echo
markup_h1_divider
markup_h1 " Hello world example command"
markup_h1_divider
markup_h1_li "Running without argument will use 'world' as default."
markup_h1_li "Pass the name by giving it as an argument (eg. bin/hello name)."
markup_h1_divider
echo
```


### Include scripts
Include scripts providing the functions needed in the script.
```
# Includes.
source "$DIR_SRC/script.sh"
```

If you have functionality for the custom commands that is shared: save it into
the `config/bin/src` directory and include it using the `$DIR_CONFIG_SRC`
variable:
```
source "$DIR_CONFIG_SRC/shared_functionailty.sh"
```


### The actual script
Add the actual script steps.

Add the global `script_before_run` & `script_after_run` hook triggers.
[`hook_invoke` function][link-hook-invoke].


> **Note** : Try to put the actual step code into included scripts.

```
# START Script -----------------------------------------------------------------

script_before_run

hello_name="$SCRIPT_ARGUMENT"
if [ -z "$hello_name" ]; then
  hello_name="World"
fi

markup "Hello ${LWHITE}$hello_name${RESTORE}"
echo

script_after_run

# END Script -------------------------------------------------------------------
```

Each step in the custom command can trigger its own hooks by using the
`hook_invoke <hook_name>` syntax.
```

# Before the script step:
hook_invoke "hello_greeting_before"

# Actual script step code...

# After the script step:
hook_invoke "hello_greeting_after"
```


### Terminate the script
Terminate the script by return 0 ex exit code:
```
exit 0
```


### Full example
Full example of a custo command (`config/bin/hello`):
```
#!/bin/bash

################################################################################
# Hello is a demonstration of a custom command.
#
# Do not run this command directly from within the config/bin directory; it will
# fail.
################################################################################

# Check if on the proper place (symlinked from within the bin directory).
if [ ! -f "$(dirname $0)/src/bootstrap.sh" ]; then
  echo "ERROR : This script should be called from within the bin directory!"
  echo
  exit 1
fi

# Bootstrap the script.
source $(dirname $0)/src/bootstrap.sh


# Show some output explaining what the command will do.
echo
markup_h1_divider
markup_h1 " Hello world example command"
markup_h1_divider
markup_h1_li "Running without argument will use 'world' as default."
markup_h1_li "Pass the name by giving it as an argument (eg. bin/hello name)."
markup_h1_divider
echo


# Includes.
source "$DIR_SRC/script.sh"


# START Script -----------------------------------------------------------------

script_before_run

hello_name="$SCRIPT_ARGUMENT"
if [ -z "$hello_name" ]; then
  hello_name="World"
fi

markup "Hello ${LWHITE}$hello_name${RESTORE}"
echo

script_after_run

# END Script -------------------------------------------------------------------


exit 0
```



[Back to overview][link-overview]



[hooks-variables]: hooks-variables.md

[link-overview]: README.md
