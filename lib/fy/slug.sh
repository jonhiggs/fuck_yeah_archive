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
