################################################################################
# Set the composer files that need to be run before the installation.
#
# !Do not not include _core/composer.json as this one is always installed first.
################################################################################

MAKE_FILES=(
  "minimal/composer.json"
  "administration/composer.json"
)
