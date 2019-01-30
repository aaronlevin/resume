#!/usr/bin/env bash

set -ex

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

  local tmp_dir_name=$(echo $RANDOM)

  mkdir -p "${tmp_dir_name}"

  gen_resume_io "${1}" "${tmp_dir_name}"

  local tmp_prefix="${tmp_dir_name}/${2}"
  local tmp_txt="${tmp_prefix}.txt"
  local tmp_html="${tmp_prefix}.html"

  cat "${tmp_txt}" \
    | sed 's/^   o  /   *  /g' \
    > "${2}.txt"

  mv "${tmp_html}" "${2}.html"

  rm "${tmp_txt}"
  rmdir "${tmp_dir_name}"

}

main $@
