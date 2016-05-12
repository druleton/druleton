# Composer file
Druleton uses a composer file to download and extract the Drupal
Core, contributed modules and themes as well as 3th party libraries.

[Read more about composer files][link-composer].

The composer file configuration is build around 2 parts:

1. Composer files in the `config/composer` directory to group modules to download for
   specific functionality in composer bundles.
2. Composer configuration arrays (`config/drupal_composer.sh`,
   `config/drupal_composer_\<env/>`) defining what composer files should be used to
   download the dependencies.

Using composer files gives us the advantage that we can:

- Define what version of a module/theme we want to use.
- Define what (optional) patches need to be applied to the downloaded module or
  theme.


#### Composer file structure
A starting point for the general `composer.json` file can be found in the templates
folder of Druleton.
This file is copied automatically to the root of your project when running the
command `bin/init` for the first time.

The `composer.json` file must contain all requirements of the project as well as
eventual patches to be applied to those requirements.

Requirements in this context means either Drupal modules, Drupal themes, Drupal
profiles, libraries or other 3rd party code.

The installer-paths section (to be found in the extra section of the
composer.json file) defines where each type of requirement will be extracted to:
- Drupal Core (which is a requirement too) will be extraced to `web/core`.
- Drupal Contributed modules will be extracted to `web/modules/contrib/{$name}`.
- Drupal Contributed Profiles will be extracted to `web/profiles/contrib/{$name}`.
- Drupal Contributed Themes will be extracted to `web/profiles/contrib/{$name}`.

[See the composer file syntax for further info][link-composer].

Example of a composer file called `templates/composer.json`.

```json
{
  "name": "Druleton",
  "description": "Druleton project template with composer",
  "type": "project",
  "minimum-stability": "dev",
  "prefer-stable": true,
  "repositories": [
    {
      "type": "composer",
      "url": "https://packagist.drupal-composer.org"
    }
  ],
  "require": {
    "composer/installers": "^1.0.20",
    "drupal-composer/drupal-scaffold": "^1.3.1",
    "cweagans/composer-patches": "~1.0",
    "drupal/core": "~8.1"
  },
  "conflict": {
    "drupal/drupal": "*"
  },
  "autoload": {
    "classmap": [
      "scripts/composer/ScriptHandler.php"
    ]
  },
  "scripts": {
    "drupal-scaffold": "DrupalComposer\\DrupalScaffold\\Plugin::scaffold",
    "post-install-cmd": [
      "DrupalProject\\composer\\ScriptHandler::buildScaffold",
      "DrupalProject\\composer\\ScriptHandler::createRequiredFiles"
    ],
    "post-update-cmd": [
      "DrupalProject\\composer\\ScriptHandler::buildScaffold",
      "DrupalProject\\composer\\ScriptHandler::createRequiredFiles"
    ]
  },
  "extra": {
    "installer-paths": {
      "web/core": ["type:drupal-core"],
      "web/modules/contrib/{$name}": ["type:drupal-module"],
      "web/profiles/contrib/{$name}": ["type:drupal-profile"],
      "web/themes/contrib/{$name}": ["type:drupal-theme"]
    },
    "enable-patching": true
  }
}
```


#### Upgrade core and modules
To upgrade a working platform:

- Update the version number in the composer file for the core, module or theme you
  want to upgrade or define what patches that should be applied to them.
- Run the `bin/upgrade` command to download the versions as defined and apply
  the patches.



[Back to overview][link-overview]



[link-composer]: https://getcomposer.org/doc/01-basic-usage.md

[link-overview]: README.md
