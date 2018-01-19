source $(dirname "${BASH_SOURCE[0]}")/page.sh
source $(dirname "${BASH_SOURCE[0]}")/slug.sh

_asset_url() {
  echo "need to exand to fully qualified urls"
}

_asset_filename() {
  ref=$1
  slug=$(_slug "$(_page_heading)")
  dir=$(_asset_directory "${slug}")
  file="$(basename $(_asset_url "${ref}"))"
  echo "${dir}/${file}"
}

# vim: ft=sh
