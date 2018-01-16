fya_heading() {
  if [[ -z "${MARKDOWN}" ]]; then
    echo "MARKDOWN is undefined" >&2
    return 1
  fi

  echo "${MARKDOWN}" \
    | grep -m1 '^#' \
    | sed -E 's/^[\#\ ]+//'
}

fya_slug() {
  string=$1
  echo "${string}" \
    | tr [:upper:] [:lower:]  \
    | sed 's/[^a-z0-9]/-/g'    \
    | sed -E 's/-+/-/g'
}

fya_filename() {
  string=$1
  echo "$(date +%Y%m%d)-$(fya_slug ${string}).md"
}

# vim: ft=sh
