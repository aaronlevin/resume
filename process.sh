#!/usr/bin/env bash

readonly PROGNAME=$(basename $0)
readonly ARGS="$@"

# exit program if unset
exit_if_unset() {

  local var="${1}"
  local msg="${2}"

  if [[ -z "${1}" ]]; then
    echo "${2}" 1>&2
    exit -1
  fi

}

# Generate the resume using `xml2rfc`
gen_resume_io() {

  local file="${1}"
  local out_file="${2}"

  xml2rfc "${file}" \
    --basename="${out_file}" \
    --text \
    --html
}

main() {

  exit_if_unset "${1}" "Must specify input file"
  exit_if_unset "${2}" "Must specify output file"

  local tmp_file=$(echo $RANDOM)

  gen_resume_io "${1}" "${tmp_file}"

  cat "${tmp_file}.txt" \
    | sed 's/^   o  /   *  /g' \
    > "${2}.txt"

  mv "${tmp_file}.html" "${2}.html"

  rm "${tmp_file}.txt"

}

main $@
