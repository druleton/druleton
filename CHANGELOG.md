# Changelog


## [1.x.x]
### Fixed
- #42 : Fixed error while saving a config variable with an /.



## [0.4.0] - 2016-01-22
### Changed
- #27 : Moved repository to the druleton organisation and renamed the project.
- #26 : Removed all project specific code from druleton and improve `bin/init`:
  - Move the bin directory to the root of the project so it can be included as a
    git submodule in druleton powered projects.
  - Extended the `bin/init` script so it creates the directory structure for a
    new project.
- #25 : Extended the `bin/init` script so it asks for the configuration variables
  and writes them to the `config/config.sh` file.



## [0.3.0] - 2015-12-26
### Added
- #19 : Added bin/drush command and its documentation.
- #20 : Added bin/init command and its documentation.
- #23 : Install composer locally by running the bin/init command.
- #23 : Install drush locally by running the bin/init command.
- #30 : Add the configuration option to use local or global composer binary.
- #32 : Add support to use drush.phar.
- #34 : Add bin/coder command as a wrapper around the phpcs binary using drupal
        coding standards.
- #35 : Add option to force installing 3th party packages (composer, drush,
        coder, ...).

### Fixed
- Error when there is no hook info available for a specific command.
- Added missing documentation about extending the skeleton command help.
- Added missing help information of wrapped commands like bin/drush and
  bin/composer.
- #36 : Fixed missing support for quoted parameters.


## [0.2.0] - 2015-12-02 Documentation
### Added
- #11 Add documentation : documented the drupal-skeleton, how everything works
  and how to extend it.
- bin/build : Added example build hook to copy the project modules & themes.
- bin/src/include : Added file helpers to make it easier to symlink and copy
  subdirectories.
- config : Refactored the implemented hooks to symlink and copy project
  subdirectories during install, upgrade and build.
- bin/restore : Make sure that the hooks are only called once a backup is
  selected to restore from.
- changelog : Moved the skeleton changelog to the bin directory. Added a global
  changelog file to be used for the project.

### Fixed
- #14 colored markup : each markup function should restore the default color.
- bin/restore : Added the missing backup creation during executing the restore
  command.
- bin/upgrade : Added the missing cleanup step to the upgrade command.



## [0.1.2] - 2015-10-30
### Fixed
- #9 Added missing `bin/backup` and `bin/build` scripts.



## [0.1.1] - 2015-10-30
### Added
- #6 drupal_install.sh : Add more verbose info about the install arguments.

### Fixed
- #3 backup.sh : Wrong comparison in backup script



## [0.1.0] - 2015-10-30 Initial release
### Added
- Working skeleton.
- Basic documentation.



[1.x.x]: https://github.com/zero2one/drupal-skeleton/compare/master...develop
[0.4.0]: https://github.com/druleton/druleton/compare/0.3.0...0.4.0
[0.3.0]: https://github.com/druleton/druleton/compare/0.2.0...0.3.0
[0.2.0]: https://github.com/druleton/druleton/compare/0.1.1...0.2.0
[0.1.2]: https://github.com/druleton/druleton/compare/0.1.1...0.1.2
[0.1.1]: https://github.com/druleton/druleton/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/druleton/druleton/releases/tag/0.1.0
