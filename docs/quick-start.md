# Quick Start
Druleton has a everything to startup fast. This quick-start guide
explains how.


## Requirements
Make sure that your environment meets the
[minimal requirements][link-requirements].


## Installation

### Preparation

#### Create a directory
Create a directory as working space for your project.

#### Init git for your project
This is optional: if you use git, this is the time to initiate it in the newly
created directory.

```Shell
$ cd /path/to/your/project/directory
$ git init
```

#### Create a database
Create a MySQL or MariaDB database. Grant a user access to it.

#### Create a vhost
Add an Apache vHost (or use a subdirectory of an existing vhost) and point it
to the `web` directory (who does not exist yet) within the root of this
directory structure.


### Add druleton to your project
There are 2 options to add druleton:

##### 1. As a GIT submodule
Druleton [code is hosted on github][link-druleton-github]. If git is used to
version your project code, you can add druleton as a submodule to that project.

Add druleton submodule as bin directory in your project:

```Shell
$ git submodule add -b master https://github.com/druleton/druleton bin
$ git commit -m "Added druleton as submodule"
```

By default the master branch is used. This is always the latest version.

Optionaly you can switch to the develop branch:
```Shell
$ cd bin
$ git checkout develop
```

Or specific tag:
```Shell
$ cd bin
$ git checkout tags/0.4.0
```

> **Warning** : The directory structure of druleton drastically changed between
> version 0.3.0 and 0.4.0. Do not install druleton as a submodule with an
> older version then 0.4.0.

##### 2. Download zip file
[Download the latest druleton version][link-druleton-version-latest] from
GitHub. Or [download a specific version][link-druleton-versions].

Extract it within your project directory and rename the druleton directory to
`bin`.



## Run the init command
The `bin/init` command will setup the project file structure for you.

```bash
$ bin/init
```

This command will:
- Setup the config & project directories within your project workspace.
- It will ask you for the website details and database credentials and save them
  to the `config/config.sh` file.
- Download Composer and install it in the `bin` directory.
- Use composer to download and install Drush (and its dependencies)locally in
  the `bin/vendor` directory.
- Use composer to download and install Drupal coder (and its dependencies).
- Create symlinks from within the `bin` directory to the optional custom
  commands as defined in the `config/bin` directory.



## Run the install command
Install the project by running the `bin/install` command:

```bash
$ bin/install
```

- Drupal core and some contrib modules and themes will be downloaded and
  extracted within the `web` directory.
- Drupal will be installed with the install profile as defined in the config
  file.
- Modules will be disabled as defined in the `config/drupal_modules_disable.md`
  file.
- Modules will be enabled as defined in the `config/drupal_modules_disable.md`
  file.
- The default browser will open the URL as specified in the config file and you
  will be logged in as the admin user.

The new site is ready to start developing.

From now on [all commands][link-commands] can be used.



## Next steps
Now that you have a running installation you can start extending the project:

- [Add extra required modules by adding make files][link-config-make].
- [Enable extra modules after the installation process][link-config-modules].
- [Add custom install profiles, modules, themes and libraries][link-project].
- [Extend the commands by implementing their hooks][link-hooks].
- [Add extra commands specific for the project][link-config-bin].



[Back to overview][link-overview]



[link-requirements]: requirements.md
[link-config-config]: config-config.md
[link-documentation]: README.md
[link-commands]: README.md#commands
[link-config-bin]: config-bin.md
[link-config-make]: config-make.sh
[link-config-modules]: config-modules.md
[link-project]: project.md
[link-hooks]: hooks.md

[link-druleton-github]: https://github.com/druleton/druleton/tree/master
[link-druleton-versions]: https://github.com/druleton/druleton/releases
[link-druleton-version-latest]: https://github.com/druleton/druleton/releases/latest

[link-overview]: README.md
