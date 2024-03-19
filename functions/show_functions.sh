function show_arg_desc {
    for ((i = 0; i < ${#args[@]}; i++)); do
        len_args=$(max $len_args ${#args[$i]})
        len_types=$(max $len_types ${#argtype[$i]})
    done
    len_args=$((len_args + 1))
    len_types=$((len_types + 3))
    len_offset=$((len_args + 2))
    # Print output
    fmt_help --type="header" "Arguments:"
    printf -- "\n"
    for ((i = 0; i < ${#args[@]}; i++)); do
        format_argument "${len_args}" "${args[$i]}"
        # Argument type
        format_argtype "${len_types}" "${argtype[$i]}"
        # # Newline
        # printf -- "\n"
        # Argument description
        format_argdesc "2" "${argdesc[$i]}"
        # Newline
        printf -- "\n"
        # Argument default
        format_argdefault "${len_offset}" "${argdefault[$i]}"
        # Newline
        printf "\n\n"
    done
}

function show_func_desc {
    local func_name="${FUNCNAME[@]:2:1}"
    fmt_help --type="fun" "${func_name}"
    printf -- "\n"
    indent_fundesc="$((${#func_name} + 2))"
    format_func_desc "${indent_fundesc}" "${funcdesc[@]}"
    printf -- "\n"
}

function show_func_usage {
    local func_name="${FUNCNAME[@]:2:1}"
    for ((i = 0; i < ${#args[@]}; i++)); do
        len_args=$(max $len_args ${#args[$i]})
    done
    len_args=$((len_args + 1))
    # Print output
    fmt_help --type="header" "Usage:"
    printf -- "\n"
    format_fun "5" "${func_name}"
    for ((i = 0; i < ${#args[@]}; i++)); do
        printf " \\ \n"
        # Argument
        format_argument "${len_args}" "${args[$i]}"
        # Value
        format_argdefaultuse "${argdefault[$i]}"
        # Newline
    done
    printf -- "\n"
}

function show_help {
    show_func_desc
    if [ "${#args[@]}" -gt "0" ]; then
        printf -- "\n"
        show_arg_desc
    fi
    show_func_usage
}
