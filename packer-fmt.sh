#!/usr/bin/env bash
set -eo pipefail

main() {
  parse_cmdline_ "$@"
  packer_fmt_ "$@"
}

parse_cmdline_() {
  for argv in "$@"; do
    case $argv in
      -check | -diff | -recursive | -write=false | -write=true )
        ARGS+=("$argv")
        shift
        ;;
      *)
        FILES=("$@")
        ;;
    esac
  done
}

packer_fmt_() {
  er=0
  for file in "${FILES[@]}"; do
    if ! packer fmt "${ARGS[@]}" "$file"; then
      echo "Failed at: $file"
      er=1
    fi
  done
  
  if [ "$er" != 0 ] ; then
      exit 1
  fi
}

# global arrays
declare -a ARGS=()
declare -a FILES=()

main "$@"
