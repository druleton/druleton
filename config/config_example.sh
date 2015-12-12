################################################################################
# This is the global configuration file.
#
# ! It contains sensitive data and should never be comitted to a repository.
#
# Copy this example to config/config.sh and fill in the values.
# You can add extra config variables if you need them in your scripts.
################################################################################

# The name of the site.
SITE_NAME="My Website"

# URL where the site is hosted.
SITE_URL="my-site.dev"

# The install profile that shouls be installed.
SITE_PROFILE="standard"

# Database connection parameters.
DB_USER=""
DB_PASS=""
DB_NAME="my_site_db"
DB_HOST="localhost"

# Administrator account (user 1).
ACCOUNT_NAME="admin"
ACCOUNT_PASS="drupal"
ACCOUNT_MAIL="$ACCOUNT_NAME@$SITE_URL"

# The Drush version to use.
#
# Use "global" if you want to use the globally installed drush command (outside
# the skeleton project.
# Or set the branch or tag name from https://github.com/drush-ops/drush.
#
# If the variable is not set, dev-master will be used.
DRUSH_VERSION="dev-master"
