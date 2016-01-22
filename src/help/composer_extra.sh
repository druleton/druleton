markup_h2 "Composer specific help:"
output="$( composer_run -h )"
echo "${output//composer//bin/composer}"
