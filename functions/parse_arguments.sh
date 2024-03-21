#!/bin/bash

# =========================== > make_declaration < =========================== #
function make_declaration {
    varname="${1}"
    if [ -z ${varname} ]; then
        return 0
    fi
    shift
    varval=("$@")
    echo \
        "local " \
        "${varname}=(" \
        $(printf "'%s' " ${varval[@]}) \
        ")"
}
# ────────────────────────────────── <end> ─────────────────────────────────── #

# =========================== > parse_arguments < ============================ #

# ┌┌────────────────────────────────────────────────────────────────────────┐┐ #
# ││ `parse_arguments()`                                                    ││ #
# ││                                                                        ││ #
# ││ Parse arguments to assign them inside a function                       ││ #
# ││                                                                        ││ #
# ││ Input:                                                                 ││ #
# ││ $1 : valid_args (array): Array of valid arguments                      ││ #
# ││ $2... : arguments: Arguments of form                                   ││ #
# ││ -key=value / --key=value / -key value / --key value                    ││ #
# ││                                                                        ││ #
# ││ Output:                                                                ││ #
# ││ Assignment statements of form key="value"                              ││ #
# ││ Usage:                                                                 ││ #
# ││ parse_arguments <valid_args> <arg2> ... <argn>                         ││ #
# ││                                                                        ││ #
# ││ Examples:                                                              ││ #
# ││ valid_args=("key1" "key2")                                             ││ #
# ││ function test {                                                        ││ #
# ││ eval "$(parse_arguments valid_args[@] -key1 val1 --key2=val2)"         ││ #
# ││ echo "key1: $key1"                                                     ││ #
# ││ echo "key2: $key2"                                                     ││ #
# ││ }                                                                      ││ #
# └└────────────────────────────────────────────────────────────────────────┘┘ #

function parse_arguments {
    key=""
    value=""
    i=0
    j=0
    if [ "${#args[@]}" -gt "0" ]; then
        for ((i = 0; i < ${#args[@]}; i++)); do
            make_declaration "${args[$i]}" "${argdefault[$i]}"
        done
    fi
    while [[ $# -gt 0 ]]; do
        case "$1" in
        --*=* | -*=*) # for arguments like --a=5
            ((i++))
            if [ "$i" -gt "1" ]; then
                make_declaration "$key" $value
            fi
            key="${1%%=*}"
            key="${key#--}"
            key="${key#-}"
            value=("${1#*=}")
            ;;
        --* | -*) # for arguments like --a 5
            ((i++))
            if [ "$i" -gt "1" ]; then
                make_declaration "$key" $value
            fi
            key="${1}"
            key="${key#--}"
            key="${key#-}"
            value=("${2}")
            shift
            ;;
        *)
            value+=("$1")
            ;;
        esac

        if [ ! -z "${key}" ]; then
            if [[ " ${args[@]} " =~ " ${key} " ]]; then
                keys+=("$key")
                vals+=("$value")
            else
                err "Invalid argument to \`${FUNCNAME[@]:1:1}\`: '${key}'"
                return 1
            fi
        fi
        shift
        # ((j++))
    done
    if [ ! -z "$key" ]; then
        make_declaration "$key" $value
    fi
}
# ────────────────────────────────── <end> ─────────────────────────────────── #
