#!/usr/bin/env bash
set -eo pipefail

main() {
  parse_cmdline_ "$@"
  packer_validate_ "$@"
}

parse_cmdline_() {
  for argv in "$@"; do
    case $argv in
      -var-file)
        ARGS+=("$argv")
        ARGS+=("$2")
        shift 2
        ;;
      -var)
        ARGS+=("$argv")
        ARGS+=("$2")
        shift 2
        ;;
      *.pkr.hcl)
        for file in $argv ; do
            # detect pkr.hcl files separation and use folder in validation in this case
            dirname=$(dirname "$file")
            fcount=$(find "$dirname" -maxdepth 1 -name '*.pkr.hcl' | wc -l)
            if [ "$fcount" -eq 1 ]; then
                case "${FILES[@]}" in 
                    *"$file"*) 
                        # skip duplicates
                        shift
                        ;;
                    *)
                        FILES+=("$file")
                        ;;
                esac
            else
                case "${FILES[@]}" in 
                    *"$dirname"*) 
                        # skip duplicates
                        shift
                        ;;
                    *)
                        FILES+=("$dirname")
                        ;;
                esac
            fi
        done
        ;;
    esac
  done
}

packer_validate_() {
  er=0
  for file in "${FILES[@]}"; do
    echo "Validating $file"
    if ! packer validate "${ARGS[@]}" "$file"; then
      echo "Failed at: $file"
      er=1
    fi
  done
  
  if [ "$er" != 0 ] ; then
      exit 1
  fi
}

# run main
declare -a ARGS=()
declare -a FILES=()

main "$@"
reset
