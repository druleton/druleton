markup_h2 "Coder specific help:"
source "$DIR_SRC/drupal_coder.sh"
output="$( drupal_coder_run -h )"
echo "${output//phpcs//bin/coder}"
