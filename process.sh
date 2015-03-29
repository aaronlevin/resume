#!/usr/bin/env bash
IFS=''

is_list() {
  echo "${1}" | grep -q "^   \*  "
}

is_chapter() {
  echo "${1}" | grep -q "^[0-9]\."
}

remove_extra_bullet_line() {
  local prev="${1}"
  while read cur; do
    if is_list "${prev}"; then
      prev=""
    else
      prev="${cur}"
      echo "${prev}"
    fi
  done
}

cat "${1}" \
  | sed 's/^   o  /   *  /g' \
  | remove_extra_bullet_line 
