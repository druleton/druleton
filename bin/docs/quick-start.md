# Quick Start
The drupal-skeleton has a everything to startup fast. This quick-start guide
explains how.


## Requirements
Make sure that your environment meets the
[minimal requirements][link-requirements].


## Configuration
Create the `config/config.sh` file by creating a copy of the
`config/config_example.sh` file.

Open the file and fill in the blanks.

See [configuration documentation][link-config-config].



## Create a database
Create a MySQL or MariaDB database with the name and credentials as entered in
the config file.



## Create a vhost
Add an Apache vHost (or use a subdirectory of an existing vhost) and point it
to the `web` directory (who does not exist yet) within the root of this
directory structure. Use the same vhost URL as defined in the config file.



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

From now on the [other 5 commands][link-commands] can be used.



## Next steps
Now that you have a running installation you can start extending the project:

- [Add extra required modules by adding make files][link-config-make].
- [Enable extra modules after the installation process][link-config-modules].
- [Add custom install profiles, modules, themes and libraries][link-project].
- [Extend the commands by implementing their hooks][link-hooks].



[Back to overview][link-overview]



[link-requirements]: requirements.md
[link-config-config]: config-config.md
[link-documentation]: README.md
[link-commands]: README.md#commands
[link-config-make]: config-make.sh
[link-config-modules]: config-modules.md
[link-project]: project.md
[link-hooks]: hooks.md

[link-overview]: README.md
