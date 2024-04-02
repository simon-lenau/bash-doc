#!bash
source $(dirname "${BASH_SOURCE[0]}")/../init

function example_function {
    init_doc
    init_desc \
        "This is an" \
        "Example function"
    init_arg "int" "int_arg" "This is some int argument" "default_int"
    init_arg "str" "str_arg" "This is some string argument" "default_str"

    need_help $@ && return $?

    # toparse="$(parse_arguments "$@")"
    # echo "toparse:"
    # printf ">>>\n${toparse[0]}\n<<<\n"
    eval "$(parse_arguments "$@" || return 1) || return 1"

    # echo "---------"

    echo "int_arg: ${int_arg[@]}"
    echo "str_arg: ${str_arg[@]}"

}
