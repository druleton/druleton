# Hook helpers
The skeleton provides helpers to make it easier to write hooks and to colorize
informational output.



## Markup helpers
The markup helpers support creating colorized output to the command line
interface.


### Pre defined markup functions
There is a set of markup functions that will output the string you pass to them
in a predefined color. This to make it easier to get an consistent output.

All these functions accept one parameter: the text to use in the output.

Overview:

#### markup
Use always the `markup` function (instead of `echo`) when you want to print
output to the screen. This command supports using color variables to output
parts of the text colorized.

```bash
markup "This is ${YELLOW}Yellow${RESTORE}."
```

The following colors are supported:

- `${RESTORE}` : This is a special one, this will always restore the color to
  the default (white text on transparent background).

  ```bash
  markup "${GREEN}This is green${RESTORE} this text is in the default color."
  ```

Colored text on transparent background:
- `${BLACK}` : Black.
- `${RED}` : Red.
- `${GREEN}` : Green.
- `${YELLOW}` : Yellow.
- `${BLUE}` : Blue.
- `${MAGENTA}` : Magenta.
- `${CYAN}` : Cyan.
- `${WHITE}` : White.
- `${GREY}` : Grey.
- `${LBLACK}` : Dark grey.
- `${LRED}` : Bright red.
- `${LGREEN}` : Bright green.
- `${LYELLOW}` : Bright yellow.
- `${LBLUE}` : Bright blue.
- `${LMAGENTA}` : Bright magenta.
- `${LCYAN}` : Brght cyan.
- `${LWHITE}` : Bright white.

Colored backrounds
- `${BGBLACK}` : White text on black background.
- `${BGRED}` : Black text on red background.
- `${BGGREEN}` : Black text on green background.
- `${BGYELLOW}` : Black text on yellow background.
- `${BGBLUE}` : Black text on blue background.
- `${BGMAGENTA}` : Black text on magento background.
- `${BGCYAN}` : Black text on cyan background.
- `${BGWHITE}` : Black text on white background.
- `${BGLBLACK}` : White text on grey background.
- `${BGLRED}` : Black text on bright red background.
- `${BGLGREEN}` : Black text on bright green background.
- `${BGLYELLOW}` : Black text on bright yellow background.
- `${BGLBLUE}` : Black text on bright blue background.
- `${BGLMAGENTA}` : Black text on bright magento background.
- `${BGLCYAN}` : Black text on bright cyan background.
- `${BGLWHITE}` : Black text on bright white background.

> **Tip** : The colors can be used in any `markup` and `message` function.



#### markup_h1
The `markup_h1` function is used to print headings in the output. Use this on
the begin and end of commands or large hooks. The line will be printed in blue
text.

```bash
markup_h1 "Heading 1 demo."
```

#### markup_h2
The `markup_h2` function is used to print secondary headings. The line will be
printed in bright-white text.

```bash
markup_h2 "Heading 2 demo."
```

#### markup_success
Use this to print a line in green text.

```bash
markup_success "Success demo."
```

#### markup_warning
Use this to print a line in yellow text.

```bash
markup_warning "Warning demo."
```

#### markup_error
Use this to print a line in red text.

```bash
markup_error "Error demo."
```

#### markup_li
Print a line as a list item. The line will be prefixed with a bullet.

```bash
markup_li "First item."
markup_li "Second item."
```

#### markup_h1_li
Use this to print a bullet in a heading 1 context. The line will be printed in
blue with a bullet prefix.

```bash
markup_h1_li "First item."
markup_h1_li "Second item."
```

#### markup_divider
This function will print out a line of `===` to the screen.

This function does not accept any parameters.

```bash
markup_divider
```

#### markup_h1_divider
This function will print out a line of `===` within the heading 1 context. The
divider will be printed in blue.

This function does not accept any parameters.

```bash
markup_h1_divider
```



## Print debug information
Use the `markup_debug` to output information to the screen that only will be
printed when the verbose option (`-v` or `--verbose`) is used on a command.

The text will be printed in light grey.

```bash
markup_debug "Debug demo."
```


## Messages
The message functions are used to print messages to the screen.

There are multiple message functions:

#### message_success
This function will print out the text prefixed with a green checkmark (✓).

```bash
message_success "Success demo."
```

#### message_warning
This function will print out the text prefixed with an yellow exclamation (!).

```bash
message_warning "Warning demo."
```

#### message_error
This function will print out the text prefixed with a red cross (✗).

```bash
message_error "Error demo."
```



## Drupal helpers
The skeleton provides several Drupal specific helpers:


#### drupal_drush
Running Drush commands require by default or opening a command line interface
within the web root of the platform or using a drush alias. The drupal_drush
function will always run the drush commands within the `web` directory.

You can the same arguments and options as calling drush directly.

Example to clear the cache:
```bash
drupal_drush cc
```

#### drupal_is_installed
Check if Drupal is installed (= there is a working Drupal platform). The
function will echo 1 when ok, 0 if not ok.

Use this in your code like this:
```bash
if [ `drupal_is_installed` -eq 1 ]; then
    # Run the code when Drupal is installed.
fi
```
Or:
```bash
if [ `drupal_is_installed` -ne 1 ]; then
    # Run the code when Drupal is not installed.
fi
```

#### drupal_sites_default_unprotect
The `web/sites/default` directory and `web/sites/default/settings.php` file are
by default write protected by Drupal. This function will unprotect both.

Use this when you want to alter the settings.php file or when you want to
add/edit/delete files within the `web/sites/default` directory.

#### drupal_sites_default_protect
Use this to restore the write protection on the `web/sites/default` directory
and `web/sites/default/settings.php` file.



## Command options
All commands have options that can be used to manipulate the functionality.
There are helper functions to access those command line options:

#### option_is_set
Check if a specific option is set by passing the name inclusif the `-` or `--`
prefix. The function will echo 1 or 0.

Example how to catch the value in a variable:
```bash
only_db=$( option_is_set "--only-db" )
```

#### option_get_value
Get the value of an option. This is only for options that pass a value like the
`--env=\<env_name\>` option.

Example to get the environment value:
```bash
environment=$(option_get_value "--env")
```

#### option_get_environment
This is a wrapper around the `option_get_value` function. It will return the
actual name or fall back to `dev` when no environment option was passed to the
command.

Example to store th variable option in a variable:
```bash
ENVIRONMENT=$(option_get_environment)
```

> **Tip** : This value is also accessible using the `$ENVIRONMENT` variable.
> See [variables documentation][link-hooks-variables].



## File helpers
File system related helper functions.

#### file_list_subdirectories
List all subdirectories within the given parent directories.

```bash
directories=$(file_list_subdirectories "path/to/parent_directory")
```

#### file_symlink_subdirectories
Create symlinks within the target directory to the subdirectories of the source
directory.

```bash
file_symlink_subdirectories "/path/to/source_directory" "/path/to/target_directory"
```

#### file_copy_subdirectories
Copy all directories within the source directory to the target directory.

```bash
file_copy_subdirectories "/path/to/source_directory" "/path/to/target_directory"
```



[Back to overview][link-overview]



[link-hooks-variables]: hooks-variables.md

[link-overview]: README.md
