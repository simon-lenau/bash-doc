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
            fmt="$(tput bold && tput setaf 1)"
        elif [[ "$type" == "arg_desc" ]]; then
            fmt="$(tput setaf 27)"
        elif [[ "$type" == "arg_default" ]]; then
            fmt="$(tput setaf 2)"
        elif [[ "$type" == "func_desc" ]]; then
            fmt="$(tput bold && tput setaf 5)"
        elif [[ "$type" == "func_name" ]]; then
            fmt="$(tput bold)"
        elif [[ "$type" == "header" ]]; then
            fmt="$(tput bold && tput smul)"
        elif [[ "$type" == "type" ]]; then
            fmt="$(tput setaf 6)"
        elif [[ "$type" == "val" ]]; then
            fmt="$(tput bold)"
        fi
    fi

    printf "%b" "$fmt$(
        echo "${@: -1}" |
            sed \
                -e 's/\\n/\n'"$(indent)"'/g'
    )$reset_fmt"
}
# $(indent)
# ────────────────────────────────── <end> ─────────────────────────────────── #

# =========================== > format_argument < ============================ #
function format_argument {
    # Indent & dashes
    printf -- "\055\055"
    # Argument
    fmt_help --type="arg" "$(printf "%-${1}b" "${2}")"
}
# ────────────────────────────────── <end> ─────────────────────────────────── #
# =========================== > format_arg_usage < =========================== #

function format_arg_usage {
    printf "\"%b\"" "$(fmt_help --type="arg_default" "${1}")"
}
# ────────────────────────────────── <end> ─────────────────────────────────── #

function format_arg_type {
    fmt_help --type="type" "$(printf "%-${1}b" "<${2}>")"
}

function format_arg_desc {
    printf "%b" "$(fmt_help --type="arg_desc" "${1}")"
}

function format_arg_default {
    printf "%b" "$(fmt_help --type="arg_default" "${1}")"
}
# ============================== > format_fun < ============================== #

function format_func_name {
    printf "%b" "$(fmt_help --type="func_name" "${1}")"
}

# ────────────────────────────────── <end> ─────────────────────────────────── #

# =========================== > format_func_desc < =========================== #

function format_func_desc {
    printf "%b" "$(fmt_help --type="func_desc" "${1}")"
}
# ────────────────────────────────── <end> ─────────────────────────────────── #
