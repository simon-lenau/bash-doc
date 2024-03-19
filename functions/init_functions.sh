function init_arg {
    args=(${args[@]} $2)
    argtype=(${argtype[@]} $1)
    argdesc=(${argdesc[@]} $3)
    argdefault=(${argdefault[@]} $4)
}

function init_desc {
    funcdesc=(${funcdesc[@]} "$@")
}

function init_doc {
    args=()
    argtype=()
    argdesc=()
    argdefault=()
    funcdesc=()
}
