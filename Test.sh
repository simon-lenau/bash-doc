#!bash

source init

function testfun {
    init_doc
    init_arg "int" "int_arg" "This is some int argument" "default_int"

    check=$(parse_arguments "$@")
    echo "Check:"
    echo "$BASH_VERSION"

    printf "\n$check"
}

testfun -bla=44
