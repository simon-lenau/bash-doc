__bash_doc_output_redirected__="false"
(command -v "tput" >/dev/null 2>&1) &&
    {
        __bash_doc_has_tput__="true"
    } || {
    __bash_doc_has_tput__="false"
}

# =============================== > fmt_help < =============================== #

function fmt_help {
    while [[ $# -gt 0 ]]; do
        case "$1" in
        --type=* | -type=*) # for arguments like --a=5
            type="${1#*=}"
            ;;
        --type | -type) # for arguments like --a 5
            ((i++))
            type="${2}"
            shift
            ;;
        *)
            break
            ;;
        esac
        shift
    done

    fmt=""
    reset_fmt=""
    formatter=""

    if [[ "${__bash_doc_output_redirected__}" == "false" ]] &&
        [[ "${TERM}" == "rmd" ]]; then
        formatter=css
        span_fmt="display:inline-block;margin-left:${__bash_doc_indent__}em;"
    elif [[ "${__bash_doc_output_redirected__}" == "false" ]] &&
        [[ "${__bash_doc_has_tput__}" == "true" ]]; then
        formatter=tput
    fi

    if [[ "$formatter" == "tput" ]]; then
        reset_fmt="$(tput sgr0)"
    elif [[ "$formatter" == "css" ]]; then
        reset_fmt="</span>"
    fi

    if [[ "$type" == "arg" ]]; then
        if [[ "$formatter" == "tput" ]]; then
            fmt="$(tput bold && tput setaf 1)"
        elif [[ "$formatter" == "css" ]]; then
            fmt="<span style=\"color:red;${span_fmt}\">"
        fi
    elif [[ "$type" == "arg_desc" ]]; then
        if [[ "$formatter" == "tput" ]]; then
            fmt="$(tput setaf 27)"
        elif [[ "$formatter" == "css" ]]; then
            fmt="<span style=\"color:blue;${span_fmt}\">"
        fi
    elif [[ "$type" == "arg_default" ]]; then
        if [[ "$formatter" == "tput" ]]; then
            fmt="$(tput setaf 2)"
        elif [[ "$formatter" == "css" ]]; then
            fmt="<span style=\"color:green;${span_fmt}\">"
        fi
    elif [[ "$type" == "func_desc" ]]; then
        if [[ "$formatter" == "tput" ]]; then
            fmt="$(tput bold && tput setaf 5)"
        elif [[ "$formatter" == "css" ]]; then
            fmt="<span style=\"color:magenta;font-weight: bold;${span_fmt}\">"
        fi
    elif [[ "$type" == "func_name" ]]; then
        if [[ "$formatter" == "tput" ]]; then
            fmt="$(tput bold)"
        elif [[ "$formatter" == "css" ]]; then
            fmt="<span style=\"color:black;font-weight: bold;${span_fmt}\">"
        fi
    elif [[ "$type" == "header" ]]; then
        if [[ "$formatter" == "tput" ]]; then
            fmt="$(tput bold && tput smul)"
        elif [[ "$formatter" == "css" ]]; then
            fmt="<span style=\"color:black;font-weight: bold;text-decoration: underline;${span_fmt}\">"
        fi
    elif [[ "$type" == "type" ]]; then
        if [[ "$formatter" == "tput" ]]; then
            fmt="$(tput setaf 6)"
        elif [[ "$formatter" == "css" ]]; then
            fmt="<span style=\"color:turquoise;${span_fmt}\">"
        fi
    elif [[ "$type" == "val" ]]; then
        if [[ "$formatter" == "tput" ]]; then
            fmt="$(tput bold)"
        elif [[ "$formatter" == "css" ]]; then
            fmt="<span style=\"color:black;font-weight: bold;${span_fmt}\">"
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
    # Argument
    fmt_help --type="arg" "$(printf "\055\055%-${1}b" "${2}")"
}
# ────────────────────────────────── <end> ─────────────────────────────────── #
# =========================== > format_arg_usage < =========================== #

function format_arg_usage {
    printf "\"%b\"" "$(fmt_help --type="arg_default" "${1}")"
}
# ────────────────────────────────── <end> ─────────────────────────────────── #

function format_arg_type {
    if [[ "${TERM}" == "rmd" ]]; then
        fmt_help --type="type" "$(printf "%-${1}b" "\<${2}\>")"
    else
        fmt_help --type="type" "$(printf "%-${1}b" "<${2}>")"
    fi
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
