markup_h2 "Drush specific help:"
output="$( drupal_drush_run -h )"
echo "${output//drush//bin/drush}"
