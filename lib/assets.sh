source $(dirname "${BASH_SOURCE[0]}")/page.sh

_asset_url() {
  ref=$1
  echo "${MARKDOWN}" \
    | awk '/^\['${ref}'\]:\ .*/ { print $2 }'
}

_asset_filename() {
  ref=$1
  slug=$(_slug "$(_page_heading)")
  dir=$(_asset_directory "${slug}")
  file="$(basename $(_asset_url "${ref}"))"
  echo "${dir}/${file}"
}

# vim: ft=sh
