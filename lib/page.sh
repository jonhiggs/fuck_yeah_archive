source $(dirname "${BASH_SOURCE[0]}")/slug.sh

_page_heading() {
  if [[ -z "${MARKDOWN}" ]]; then
    echo "MARKDOWN is undefined" >&2
    return 1
  fi

  echo "${MARKDOWN}" \
    | grep -m1 '^#' \
    | sed -E 's/^[\#\ ]+//'
}

# vim: ft=sh
