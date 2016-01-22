# Hook helpers
Druleton provides helpers to make it easier to write hooks and to colorize
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

![markup][img-markup]


The following colors are supported:

- `${RESTORE}` : This is a special one, this will always restore the color to
  the default (white text on transparent background).

  ```bash
  markup "${GREEN}This is green${RESTORE} this text is in the default color."
  ```

![markup][img-color-restore]


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

![foreground colors][img-color-fg]

Highlighted colored text on transparent background:
- `${LBLACK}` : Dark grey.
- `${LRED}` : Bright red.
- `${LGREEN}` : Bright green.
- `${LYELLOW}` : Bright yellow.
- `${LBLUE}` : Bright blue.
- `${LMAGENTA}` : Bright magenta.
- `${LCYAN}` : Brght cyan.
- `${LWHITE}` : Bright white.

![highlighted foreground colors][img-color-fg-highlight]


Colored backgrounds:
- `${BGBLACK}` : White text on black background.
- `${BGRED}` : Black text on red background.
- `${BGGREEN}` : Black text on green background.
- `${BGYELLOW}` : Black text on yellow background.
- `${BGBLUE}` : Black text on blue background.
- `${BGMAGENTA}` : Black text on magento background.
- `${BGCYAN}` : Black text on cyan background.
- `${BGWHITE}` : Black text on white background.

![background colors][img-color-bg]

Highlighted colored backgrounds:
- `${BGLBLACK}` : White text on grey background.
- `${BGLRED}` : Black text on bright red background.
- `${BGLGREEN}` : Black text on bright green background.
- `${BGLYELLOW}` : Black text on bright yellow background.
- `${BGLBLUE}` : Black text on bright blue background.
- `${BGLMAGENTA}` : Black text on bright magento background.
- `${BGLCYAN}` : Black text on bright cyan background.
- `${BGLWHITE}` : Black text on bright white background.

![highlighted background colors][img-color-bg-highlight]

> **Tip** : The colors can be used in any `markup` and `message` function.



#### markup_h1
The `markup_h1` function is used to print headings in the output. Use this on
the begin and end of commands or large hooks. The line will be printed in blue
text.

```bash
markup_h1 "Heading 1 demo."
```

![markup_h1][img-markup_h1]

#### markup_h2
The `markup_h2` function is used to print secondary headings. The line will be
printed in yellow text.

```bash
markup_h2 "Heading 2 demo."
```

![markup_h2][img-markup_h2]

#### markup_h3
The `markup_h3` function is used to print tertiary headings. The line will be
printed in magenta text.

```bash
markup_h2 "Heading 3 demo."
```

![markup_h3][img-markup_h3]

#### markup_success
Use this to print a line in green text.

```bash
markup_success "Success demo."
```

![markup_success][img-markup_success]

#### markup_warning
Use this to print a line in yellow text.

```bash
markup_warning "Warning demo."
```

![markup_warning][img-markup_warning]

#### markup_error
Use this to print a line in red text.

```bash
markup_error "Error demo."
```

![markup_error][img-markup_error]

#### markup_info
Use this to print a line in cyan.

```bash
markup_info "Info demo."
```

![markup_info][img-markup_info]

#### markup_li
Print a line as a list item. The line will be prefixed with a bullet.

```bash
markup_li "First item."
markup_li "Second item."
```

![markup_li][img-markup_li]

#### markup_h1_li
Use this to print a bullet in a heading 1 context. The line will be printed in
blue with a bullet prefix.

```bash
markup_h1_li "First item."
markup_h1_li "Second item."
```

![markup_h1_li][img-markup_h1_li]

#### markup_li_value
Use this to print a list of text with a colored value.

```bash
markup_li_value "Label 1" "Value 1"
markup_li_value "Label 2" "Value 2"
```

![markup_li_value][img-markup_li_value]

#### markup_divider
This function will print out a line of `===` to the screen.

This function does not accept any parameters.

```bash
markup_divider
```

![markup_divider][img-markup_divider]

#### markup_h1_divider
This function will print out a line of `===` within the heading 1 context. The
divider will be printed in blue.

This function does not accept any parameters.

```bash
markup_h1_divider
```

![markup_h1_divider][img-markup_h1_divider]



## Print debug information
Use the `markup_debug` to output information to the screen that only will be
printed when the verbose option (`-v` or `--verbose`) is used on a command.

The text will be printed in light grey.

```bash
markup_debug "Debug demo."
```

![markup][img-markup_debug]


## Messages
The message functions are used to print messages to the screen.

There are multiple message functions:

#### message_success
This function will print out the text prefixed with a green checkmark (✓).

```bash
message_success "Success demo."
```

![message_success][img-message_success]

#### message_warning
This function will print out the text prefixed with an yellow exclamation (!).

```bash
message_warning "Warning demo."
```

![message_warning][img-message_warning]

#### message_error
This function will print out the text prefixed with a red cross (✗).

```bash
message_error "Error demo."
```

![message_error][img-message_error]

#### message_info
This function will print out the text prefixed with an i (ⓘ). All text will be
printed in cyan.

```bash
message_info "Information or tip message."
```

![message_info][img-message_info]


## Ask for input
Scripts may require input from the user. These functions help to collect that
input:

#### prompt
Ask for user input. The helper has 2 parameters:
* Question : The question text to ask to the user.
* Default : optional default value. This will be shown in grey behind the
  question. This value will be used as the REPLY when the user hits enter
  without entering any answer.

The collected answer will be stored in the `$REPLY` variable.

```bash
# Ask the question with a default value.
prompt "Question text" "default value"
# Store the answer in the "$ANSWER" variable.
ANSWER="$REPLY"
```

![markup_prompt][img-prompt]


#### prompt_yn
Ask the user a Yes/No question. The helper has 2 parameters:
* Question : The question text to ask to the user.
* Default : The (optional) default value. The default value will be translated
  to "n" (if 0, n, N) or "y" (if 1, y or Y).

The helper will accept 0, n or N as no, 1, y, Y as yes. Any other value will
trigger an error message and the question will be asked again.

The $REPLY variable will always be an integer:
* 0 : When no is the answered.
* 1 : When yes is the answer.


```bash
prompt_yn "Are you sure" "n"
ANSWER=$REPLY
```

![markup_prompt][img-prompt_yn]

#### prompt_confirm
This is the same functionality as the `prompt_yn` helper but the question will
printed in another color (magenta) to attract more attention.

```bash
prompt_confirm "Are you sure" "n"
ANSWER=$REPLY
```

![markup_prompt][img-prompt_confirm]

#### prompt_confirm_or_exit
This is the same functionality as the `prompt_confirm` helper but:
* A negative answer will terminate the command.
* The confirm question will automatically be confirmed if the -y (confirm) option
  is used when calling the command.
* The default answer will always be No.
* If no arguments are passed the default question "Are you sure" will be asked.
* An abort message will be printed if negative confirmation was received.

The helper accepts 2 arguments:
* (optional) The question to ask ("Are you sure" is the fallback).
* (optional) The abort message ("Command_name aborted" is the fallback).

```bash
prompt_confirm_or_exit
```

![markup_prompt][img-prompt_confirm_or_exit]


## Composer helpers
Druleton provides several Composer helpers:

#### composer_run
Run the composer binary. This will automatically use the locally or globally
installed composer. What composer binary will be used depeneds on the
configuration [`$COMPOSER_USE_GLOBAL`][link-config-config-composer] variable.

#### composer_skeleton_run
Run a composer command using the `bin/packagist` directory as working directory.
This directory is used to download and store php packages as needed by druleton.

> Note this function is a wrapper around the [`composer_run`](#composer_run)
> function.


## Drupal helpers
Druleton provides several Drupal specific helpers:


#### drupal_drush
Running Drush commands require by default or opening a command line interface
within the web root of the platform or using a drush alias. The drupal_drush
function will always run the drush commands within the `web` directory.

You can the same arguments and options as calling drush directly.

Example to clear the cache:
```bash
drupal_drush cc
```

> Note: this function is a wrapper around
> [`drupal_drush_run`](#drupal_drush_run). It will always use the same global or
> local drush as defined in the configuration.

#### drupal_drush_run
Druleton provides the option to use a locally (default) or globally
installed drush command. This function will check what to use based on the
configuration variable [`$DRUSH_VERSION`][link-config-config-drush-version].
If that variable is set to "global" then the globally installed drush will be
used by druleton.

The difference between this function and `drupal_drush` is that this command
will not use by default `web` as the working directory.

```bash
drupal_drush_run cc drush
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

This function will output:
- A success message for each symlinked directory.
- or A warning message if there are no directories to symlink.
- or An error message if the target directory does not exists.

```bash
file_symlink_subdirectories "/path/to/source_directory" "/path/to/target_directory"
```

#### file_copy_subdirectories
Copy all directories within the source directory to the target directory.

This function will output:
- A success message for each copied directory.
- or A warning message if there are no directories to copy.
- or An error message if the target directory does not exists.

```bash
file_copy_subdirectories "/path/to/source_directory" "/path/to/target_directory"
```



[Back to overview][link-overview]



[link-hooks-variables]: hooks-variables.md
[link-config-config-composer]: config-config.md#composer
[link-config-config-drush-version]: config-config.md#drush-version

[link-overview]: README.md

[img-color-restore]: ./img/hooks-helpers-color-restore.png
[img-color-fg]: ./img/hooks-helpers-color-fg.png
[img-color-fg-highlight]: ./img/hooks-helpers-color-fg-highlight.png
[img-color-bg]: ./img/hooks-helpers-color-bg.png
[img-color-bg-highlight]: ./img/hooks-helpers-color-bg-highlight.png
[img-markup]: ./img/hooks-helpers-markup.png
[img-markup_h1]: ./img/hooks-helpers-markup_h1.png
[img-markup_h1_li]: ./img/hooks-helpers-markup_h1_li.png
[img-markup_h1_divider]: ./img/hooks-helpers-markup_h1_divider.png
[img-markup_h2]: ./img/hooks-helpers-markup_h2.png
[img-markup_h3]: ./img/hooks-helpers-markup_h3.png
[img-markup_success]: ./img/hooks-helpers-markup_success.png
[img-markup_warning]: ./img/hooks-helpers-markup_warning.png
[img-markup_error]: ./img/hooks-helpers-markup_error.png
[img-markup_info]: ./img/hooks-helpers-markup_info.png
[img-markup_li]: ./img/hooks-helpers-markup_li.png
[img-markup_li_value]: ./img/hooks-helpers-markup_li_value.png
[img-markup_divider]: ./img/hooks-helpers-markup_divider.png
[img-markup_debug]: ./img/hooks-helpers-markup_debug.png
[img-message_success]: ./img/hooks-helpers-message_success.png
[img-message_warning]: ./img/hooks-helpers-message_warning.png
[img-message_error]: ./img/hooks-helpers-message_error.png
[img-message_info]: ./img/hooks-helpers-message_info.png
[img-prompt]: ./img/hooks-helpers-prompt.png
[img-prompt_yn]: ./img/hooks-helpers-prompt_yn.png
[img-prompt_confirm]: ./img/hooks-helpers-prompt_confirm.png
[img-prompt_confirm_or_exit]: ./img/hooks-helpers-prompt_confirm_or_exit.png
