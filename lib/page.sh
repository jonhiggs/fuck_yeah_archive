_page_heading() {
  if [[ -z "${MARKDOWN}" ]]; then
    echo "MARKDOWN is undefined" >&2
    return 1
  fi

  echo "${MARKDOWN}" \
    | grep -m1 '^#' \
    | sed -E 's/^[\#\ ]+//'
}

_page_source() {
  echo "${MARKDOWN}" \
    | grep -m1 '^\[Source\]' \
    | sed 's/^.*(//' \
    | cut -d\  -f1
}

_page_refs() {
  echo "not implemented" >&2
}

_page_ref_source() {
  ref=$1
  echo "${MARKDOWN}" \
    | awk '/^\['${ref}'\]:\ .*/ { print $2 }'
}

_page_image_refs() {
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

# vim: ft=sh
