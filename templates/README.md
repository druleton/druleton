# PROJECT NAME

[![Powered by Druleton][icon-druleton]][link-druleton]


> ADD HERE THE INTRODUCTION ABOUT THE PROJECT.


## Installation
This project uses [Druleton][link-druleton] command to install, reset and
upgrade the project.

[Druleton requires][link-requirements] at least bash to run.


### 1. Download druleton
Druleton is by default installed as a [git submodule][link-git-submodule] of the
project.

Run the git submodule commands to download druleton:

```bash
$ git submodule update
```

### 2. Initiate the druleton environment
Run the `bin/init` command to setup druleton and download composer, drush &
drupal coder.

It will ask you some configuration questions and store them in the
`config/config.sh` file.

```bash
$ bin/init
```

### 3. Install the project
Make sure that you have:
* You have a running webserver and the domain matches with the one entered
  during the `bin/init` command.
* A running MySQL server and the credentials match with the config you entered
  during the `bin/init` command.

> **Tip** : You can always change the configuration by running
> `bin/init -f config`

```bash
$ bin/install
```

Drupal core and modules will be downloaded, drupal will be installed, a browser
will open and load your website.


## Upgrade druleton, composer, drush and Drupal coder
You can upgrade druleton and the installed 3th-party tools by running the `init`
command:

```bash
$ bin/init
```


## Upgrade the project
You can upgrade your project by:

1. Pull in all changes from git

   ```bash
   $ git pull
   ```
2. Run the `upgrade` command:

   ```bash
   $ bin/upgrade
   ```

> **Tip** : The `upgrade` command will create a full backup of the current state
> before upgrading the project.


## Configuration
There is a directory with configuration files (`config`).

[See druleton configuration documentation][link-config].


## More commands
Druleton contains a set of bash scripts (commands):

- [`bin/init`][link-command-init] : Setup or update the druleton environment.
- [`bin/install`][link-command-install] : Download core and required contributed
  modules, themes and libraries and install the project.
- [`bin/reset`][link-command-reset] : Reset an installed project back to its
  freshly installed state.
- [`bin/upgrade`][link-command-upgrade]: Upgrade an installed project.
- [`bin/build`][link-command-build] : Create a package of the project.
- [`bin/backup`][link-command-backup] : Create a backup of the installed project.
- [`bin/restore`][link-command-restore] : Restore the project from one of the
  created backups.
- [`bin/composer`][link-command-composer] : A wrapper around a globally installed or
  local copy of the composer binary.
- [`bin/drush`][link-command-drush] : Run a drush command within the `web`
  directory.
- [`bin/coder`][link-command-coder] : Run code inspections using the
  drupal/coder standards.

[See druleton documentation][link-documentation].



[icon-druleton]: https://img.shields.io/badge/powered%20by-druleton-blue.svg?style=flat-square
[link-druleton]: https://github.com/druleton/druleton

[link-git-submodule]: https://git-scm.com/book/en/v2/Git-Tools-Submodules

[link-documentation]: https://github.com/druleton/druleton/blob/master/docs/README.md
[link-requirements]: https://github.com/druleton/druleton/blob/master/docs/requirements.md
[link-config]: https://github.com/druleton/druleton/blob/master/docs/config.md

[link-command-init]: https://github.com/druleton/druleton/blob/master/docs/command-init.md
[link-command-install]: https://github.com/druleton/druleton/blob/master/docs/command-install.md
[link-command-reset]: https://github.com/druleton/druleton/blob/master/docs/command-reset.md
[link-command-upgrade]: https://github.com/druleton/druleton/blob/master/docs/command-upgrade.md
[link-command-build]: https://github.com/druleton/druleton/blob/master/docs/command-build.md
[link-command-backup]: https://github.com/druleton/druleton/blob/master/docs/command-backup.md
[link-command-restore]: https://github.com/druleton/druleton/blob/master/docs/command-restore.md
[link-command-composer]: https://github.com/druleton/druleton/blob/master/docs/command-composer.md
[link-command-drush]: https://github.com/druleton/druleton/blob/master/docs/command-drush.md
[link-command-coder]: https://github.com/druleton/druleton/blob/master/docs/command-coder.md
