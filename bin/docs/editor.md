# Editor setup (IDE)

Configure your IDE so that it has the skeleton root directory as the root of the
project.

Exclude the following directories in your IDE:
- `backup`
- `bin`
- `build`
- All symlinked profiles within the `web/profiles` directory.
- All symlinked libraries within the `web/sites/all/libraries` directory.
- `web/sites/all/modules/custom`
- `web/sites/all/themes/custom`

Optional excludes (if you don't want to change the config in your IDE):
- `config`

This to avoid code being indexed by your IDE from 2 locations (the project
directory and the symlinked directories within the `web` directory).



[Back to overview][link-overview]



[link-overview]: README.md
