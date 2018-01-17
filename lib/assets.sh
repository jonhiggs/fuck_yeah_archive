source $(dirname "${BASH_SOURCE[0]}")/slug.sh

_image_refs() {
  if [[ -z "${MARKDOWN}" ]]; then
    echo "MARKDOWN is undefined" >&2
    return 1
  fi

  echo "${MARKDOWN}" \
    | grep -o -e '!\[.*\]\[.*\]' \
    | sed -E 's/!\[.*\]\[([0-9]+)\]$/\1/g' \
    | sort -n \
    | uniq
}

_asset_url() {
  ref=$1
  echo "${MARKDOWN}" \
    | awk '/^\['${ref}'\]:\ .*/ { print $2 }'
}

_asset_filename() {
  ref=$1
  slug=$(_slug "$(_heading)")
  dir=$(_asset_directory "${slug}")
  file="$(basename $(_asset_url "${ref}"))"
  echo "${dir}/${file}"
}

# vim: ft=sh
