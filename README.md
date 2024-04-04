bash-doc
================

Simple functions for creating and formating documentation of bash
scripts / functions

### Create documentation

#### `init_doc`

Initialize the documentation block

**Arguments:** none

#### `init_desc`

Set the description of the function / script

**Arguments:**

- `$1,...,$n`: Lines of the description

#### `init_arg`

Initialize named arguments to be set via `--arg=val` or `--arg val`
(using one or two dashes)

**Arguments:** - `$1`: Argument type  
- `$2`: Argument name - `$3`: Argument description - `$4`: Default value

### Set arguments

#### `parse_arguments`

Set arguments passed as `--arg=val` or `--arg val` (using one or two
dashes). Should be used as `eval "$(parse_arguments "$@")"`

**Arguments:** - `$1,...,$n`: Arguments to be set.

### Print help

#### `need_help`

Show the help if argument `-h` or `-help` (using one or two dashes) is
present. If output is console and tput is available, tput is used for
colouring.

**Arguments:** none

## Examples

The following function is a basic example of how to use `bash-doc`:

$\color{red}{#!bash}$ \$\$ $\color{red}{}$
$\color{red}{function example_function {}$ $\color{red}{    init_doc}$
$\color{red}{    init_desc \}$ $\color{red}{        "This is an" \}$
$\color{red}{        "Example function"}$
$\color{red}{    init_arg "int" "int_arg" "This is some int argument" "default_int"}$
$\color{red}{    init_arg "str" "str_arg" "This is some string argument" "default_str"}$
$\color{red}{}$ \$\$ $\color{red}{}$
$\color{red}{    eval "$(parse_arguments “$@")"}$ $\color{red}{}$ \$\$
\$\$ $\color{red}{}$ $\color{red}{}}$

### Printing help

$\color{red}{example_function --help}$

$\color{red}{<span style='font-weight: bold;'>example_function</span>   }$
$\color{red}{   <span style='color: #BB00BB; font-weight: bold;'>This is an</span>}$
$\color{red}{   <span style='color: #BB00BB; font-weight: bold;'>Example function</span>}$
$\color{red}{}$
$\color{red}{   <span style='font-weight: bold; text-decoration: underline;'>Arguments:</span>      }$
$\color{red}{      <span style='color: #BB0000; font-weight: bold;'>--int_arg  </span><span style='color: #00BBBB;'>&lt;int&gt; </span>}$
$\color{red}{         This is some int argument}$
$\color{red}{         Default: <span style='color: #00BB00;'>default_int</span>}$
$\color{red}{      <span style='color: #BB0000; font-weight: bold;'>--str_arg  </span><span style='color: #00BBBB;'>&lt;str&gt; </span>}$
$\color{red}{         This is some string argument}$
$\color{red}{         Default: <span style='color: #00BB00;'>default_str</span>}$
$\color{red}{}$
$\color{red}{   <span style='font-weight: bold; text-decoration: underline;'>Usage:</span>      }$
$\color{red}{      <span style='font-weight: bold;'>example_function</span> \}$
$\color{#BB0000}{         <span style='color: #BB0000; font-weight: bold;'>--int_arg  </span>"<span style='color: #00BB00;'>default_int</span>" \}$
$\color{#BB0000}{         <span style='color: #BB0000; font-weight: bold;'>--str_arg  </span>"<span style='color: #00BB00;'>default_str</span>"}$

### Specifying arguments

Defaults are used if an argument is not specified:

$\color{red}{example_function --str_arg "Example 1"}$

$\color{red}{int_arg: default_int}$ $\color{red}{str_arg: Example 1}$

$\color{red}{example_function --int_arg "2"}$

$\color{red}{int_arg: 2}$ $\color{red}{str_arg: default_str}$

but setting an argument overwrites the defaults:

$\color{red}{example_function --int_arg "3" --str_arg "Example 3"}$

$\color{red}{int_arg: 3}$ $\color{red}{str_arg: Example 3}$

In any case, it is checked that only valid arguments are passed. An
error is thrown otherwise:

$\color{red}{example_function --int_arg "4" --invalid_arg "Example 4"}$

$\color{#BB0000}{<span style='color: #BB0000; font-weight: bold;'>[2024/04/04 -- 11:07:31] Error in `examples/example_function.sh:14`</span>}$
$\color{#BB0000}{<span style='color: #BB0000; font-weight: bold;'>[2024/04/04 -- 11:07:31]  Invalid argument to `example_function`: 'invalid_arg'</span>}$
