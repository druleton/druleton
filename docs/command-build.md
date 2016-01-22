# bin/build command
The `bin/build` command will create a deployment package (code) in the `/build`
directory.

```bash
$ bin/build
```



## What does this command do?
The command will perform following script steps:

#### 1. Make
Drupal core, contributed modules, themes and libraries will be downloaded and
unpacked in the `build/web` directory as defined in the
[make file(s)][link-config-make].

#### 2. Create package
The build in the `build/web` directory will be packed in an archive file
(tar.gz).

If no package name is given, an unique name will be created using:

- The site name (`$SITE_NAME`) as defined in the
  [config file][link-config-config].
- The date + time stamp when the package was build.

Example:

```
druleton-20151107_110452.tar.gz
```



## Command options
Command options documentation can be viewed in the command line interface by
running the command with the `-h` or `--help` option.

```bash
$ bin/build -h
```

#### Arguments
This script has only one (optional) argument: the name for the package without
the extension. Example: "my_site_v1.0" will become "my_site_v1.0.tar.gz".
If no package name is given, an unique name will be created using the site_name
as defined in the config file and the date-time stamp when the package was
created.

#### Options
- --no-package : Do not compress the package once build.
- --env=\<name\> : The environment to run the script for (default : dev).
- --help (-h) : Show the command help.
- --hook-info : Show information about the available hooks.
- --no-color : Disable all colored output.
- --confirm (-y) : Skip the confirmation step when the script starts.
- --verbose (-v) : Verbose, show extra information while running the command.



## Command hooks
Each step in the scipt triggers "hooks". These hooks allow you to add extra
steps in between the build script without having to alter (hack) the
`bin/build` script as defined in druleton.

See [more info about the hook system][link-hooks].

The hooks for the `bin/build` command should be located in the
`config/build` directory.

The following hooks are supported (in the order as they will be included):


#### config/build/script_before(_\<env\>).sh
This hook is included and run before the script will run its first step.

#### config/build/drupal_make_before(_\<env\>).sh
This hook is included and run before the make files are processed, downloaded
and unpacked.

#### config/build/drupal_make_after(_\<env\>).sh
This hook is included and run after the make files are processed, downloaded
and unpacked.

> **Tip**: This is the proper hook to copy the custom functionality from the
> `project` directory into the build. Without this copy, the custom logic will
> not be included in the package.

#### config/build/build_package_before(_\<env\>).sh
This hook is included and run before the package is created.

#### config/build/build_package_after(_\<env\>).sh
This hook is included and run after the package is created.

#### config/build/script_after(_\<env\>).sh
This hook is included and run when the script is finished.



[Back to overview][link-overview]



[link-config-config]: config-config.md
[link-config-make]: config-make.md
[link-hooks]: hooks.md

[link-overview]: README.md
