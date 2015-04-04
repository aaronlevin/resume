#!/usr/bin/env bash

readonly PROGNAME=$(basename $0)
readonly ARGS="$@"

IFS=''

# exit program if unset
exit_if_unset() {

  local var="${1}"
  local msg="${2}"

  if [[ -z "${1}" ]]; then
    echo "${2}"
    exit -1
  fi

}

# How to test for a list
is_list() {
  echo "${1}" | grep -q "^   \*  "
}

is_chapter() {
  echo "${1}" | grep -q "^[0-9]\."
}

# xml2rfc inserts a space between bullets. this
# removes them.
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

# Generate the resume using `xml2rfc`
gen_resume_io() {

  local file="${1}"
  local out_file="${2}"

  xml2rfc "${file}" \
    -o "${out_file}" \
    --text
}

main() {

  exit_if_unset "${1}" "Must specify input file"
  exit_if_unset "${2}" "Must specify output file"

  local tmp_file=$(echo $RANDOM)

  gen_resume_io "${1}" "${tmp_file}"

  cat "${tmp_file}" \
    | sed 's/^   o  /   *  /g' \
    > "${2}"

  rm "${tmp_file}"

}

main $@
