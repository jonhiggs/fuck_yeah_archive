_heading() {
  if [[ -z "${MARKDOWN}" ]]; then
    echo "MARKDOWN is undefined" >&2
    return 1
  fi

  echo "${MARKDOWN}" \
    | grep -m1 '^#' \
    | sed -E 's/^[\#\ ]+//'
}

_slug() {
  local string=$1
  echo "${string}" \
    | tr [:upper:] [:lower:]  \
    | sed 's/[^a-z0-9]/-/g'    \
    | sed -E 's/-+/-/g'
}

_filename() {
  local string=$1
  echo "$(date +%Y%m%d)-$(_slug ${string}).md"
}

_asset_directory() {
  local string=$1
  basename "$(_filename ${string})" .md
}

# vim: ft=sh
