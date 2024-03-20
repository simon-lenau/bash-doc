# ================================= > max < ================================== #

function max {
    max=0
    for x in ${@}; do
        if [[ $x -gt $max ]]; then
            max=$x
        fi
    done
    echo $max
}

# ────────────────────────────────── <end> ─────────────────────────────────── #

# ================================= > rep < ================================== #

function rep {
    for ((i = 1; i <= $2; i++)); do
        printf -- "${1}"
    done
    echo ''
}

# ────────────────────────────────── <end> ─────────────────────────────────── #

function indent {
    if [[ "$#" -gt "0" ]]; then
        re_num='^[0-9]+$'
        if [[ $1 =~ $re_num ]]; then
            __bash_doc_indent__=$1
        else
            re_plus='^[+]+$'
            re_minus='^[-]+$'

            if [[ $1 =~ $re_plus ]]; then
                __bash_doc_indent__=$((__bash_doc_indent__ + 1))
            elif [[ $1 =~ $re_minus ]]; then
                __bash_doc_indent__=$((__bash_doc_indent__ - 1))
            else
                __bash_doc_indent__=$((__bash_doc_indent__$1))
            fi
        fi
    fi
    printf "%s" "$(rep " " $((__bash_doc_indent__ * 3)))"
}

function newline {
    printf "%b" "$(rep "\\\n" $1)"
}
