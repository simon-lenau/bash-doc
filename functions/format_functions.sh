__bash_doc_output_redirected__="false"
(command -v "tput" >/dev/null 2>&1) &&
    {
        __bash_doc_has_tput__="true"
    } || {
    __bash_doc_has_tput__="false"
}

# =============================== > fmt_help < =============================== #

function fmt_help {
    valid_args=("type")
    eval $(parse_arguments valid_args[@] "$@")
    if [ -z "${type}" ]; then
        err "Missing argument: type"
    fi

    fmt=""
    reset_fmt=""

    if [[ "${__bash_doc_output_redirected__}" == "false" ]] &&
        [[ "${__bash_doc_has_tput__}" == "true" ]]; then
        reset_fmt="$(tput sgr0)"
        if [[ "$type" == "arg" ]]; then
            fmt="$(tput bold)"
        elif [[ "$type" == "argdesc" ]]; then
            fmt="$(tput setaf 2)"
        elif [[ "$type" == "argdefault" ]]; then
            fmt="$(tput setaf 5)"
        elif [[ "$type" == "desc" ]]; then
            fmt="$(tput bold)"
        elif [[ "$type" == "fun" ]]; then
            fmt="$(tput bold)"
        elif [[ "$type" == "header" ]]; then
            fmt="$(tput bold && tput smul)"
        elif [[ "$type" == "type" ]]; then
            fmt="$(tput setaf 1)"
        elif [[ "$type" == "val" ]]; then
            fmt="$(tput bold)"
        fi
    fi
    printf -- "$fmt${@: -1}$reset_fmt"
}

# ────────────────────────────────── <end> ─────────────────────────────────── #

# =========================== > format_argument < ============================ #
function format_argument {
    # Indent & dashes
    printf -- "\t\055\055"
    # Argument
    fmt_help --type="arg" "$(printf "%-${1}b" "${2}")"
}
# ────────────────────────────────── <end> ─────────────────────────────────── #
# ========================= > format_argdefaultuse < ========================= #
function format_argdefaultuse {
    printf "\"%b\"" "$(fmt_help --type="argdefault" "${1}")"
}
# ────────────────────────────────── <end> ─────────────────────────────────── #

function format_argtype {
    fmt_help --type="type" "$(printf "%-${1}b" "<${2}>")"
}

function format_argdesc {
    indent="$(rep " " $1)"
    desc="$(
        echo "${2}" |
            sed \
                -e 's/\\n/\n\t'"$indent"'/g'
    )"
    # printf -- "${indent}"
    printf "%b" "$(fmt_help --type="argdesc" "${desc}")"
}

function format_argdefault {
    indent="$(rep " " $1)"
    printf "\t%b" "${indent}"
    printf -- "Default: "
    printf "%b" "$(fmt_help --type="argdefault" "${2}")"
}
# ============================== > format_fun < ============================== #

function format_fun {
    indent="$(rep " " $1)"
    printf -- "${indent}"
    printf "%b" "$(fmt_help --type="fun" "${2}")"
}

# ────────────────────────────────── <end> ─────────────────────────────────── #

# ============================ > format_fundesc < ============================ #

function format_func_desc {
    indent="\t"
    desc="$(
        echo "$indent$(printf "%s\\\\n" "${@:2}")" |
            sed \
                -e 's/\\n/\n'"$indent"'/g'
    )"
    printf "%b" "$(fmt_help --type="argdesc" "${desc}")"
}
# ────────────────────────────────── <end> ─────────────────────────────────── #
