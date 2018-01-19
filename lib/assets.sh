source $(dirname "${BASH_SOURCE[0]}")/page.sh
source $(dirname "${BASH_SOURCE[0]}")/slug.sh

_asset_url() {
  ref_source=$(_page_ref_source $1)
  if [[ "${ref_source}" =~ ^https ]]; then
    echo "${ref_source}"
  else
    echo "$(_page_source)$(_page_ref_source $1)"
  fi
}

_asset_filename() {
  ref=$1
  slug=$(_slug "$(_page_heading)")
  dir=$(_asset_directory "${slug}")
  file="$(basename $(_asset_url "${ref}"))"
  echo "${dir}/${file}"
}

# vim: ft=sh
