fya_images() {
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

fya_asset_url() {
  ref=$1
  echo "${MARKDOWN}" \
    | awk '/^\['${ref}'\]:\ .*/ { print $2 }'
}

# vim: ft=sh
