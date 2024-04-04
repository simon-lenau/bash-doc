bash-doc
================

$\color{#BB00BB}{This is some text}$

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

$\color{#BB00BB}{\text{#!bash}}$
$\color{#BB00BB}{\text{source $(dirname "${BASH_SOURCE[0]}")/../init}}$
$\color{#BB00BB}{\text{}}$
$\color{#BB00BB}{\text{function example_function {}}$
$\color{#BB00BB}{\text{    init_doc}}$
$\color{#BB00BB}{\text{    init_desc \}}$
$\color{#BB00BB}{\text{        "This is an" \}}$
$\color{#BB00BB}{\text{        "Example function"}}$
$\color{#BB00BB}{\text{    init_arg "int" "int_arg" "This is some int argument" "default_int"}}$
$\color{#BB00BB}{\text{    init_arg "str" "str_arg" "This is some string argument" "default_str"}}$
$\color{#BB00BB}{\text{}}$
$\color{#BB00BB}{\text{    need_help $@ &amp;&amp; return $?}}$
$\color{#BB00BB}{\text{}}$
$\color{#BB00BB}{\text{    eval "$(parse_arguments "$@")"}}$
$\color{#BB00BB}{\text{}}$
$\color{#BB00BB}{\text{    echo "int_arg: ${int_arg[@]}"}}$
$\color{#BB00BB}{\text{    echo "str_arg: ${str_arg[@]}"}}$
$\color{#BB00BB}{\text{}}$ $\color{#BB00BB}{\text{}}}$

### Printing help

$\color{#BB00BB}{\text{example_function --help}}$

$\color{#BB00BB}{\text{<span style='font-weight: bold;'>example_function</span>   }}$
$\color{#BB00BB}{\text{   <span style='color: #BB00BB; font-weight: bold;'>This is an</span>}}$
$\color{#BB00BB}{\text{   <span style='color: #BB00BB; font-weight: bold;'>Example function</span>}}$
$\color{#BB00BB}{\text{}}$
$\color{#BB00BB}{\text{   <span style='font-weight: bold; text-decoration: underline;'>Arguments:</span>      }}$
$\color{#BB00BB}{\text{      <span style='color: #BB0000; font-weight: bold;'>--int_arg  </span><span style='color: #00BBBB;'>&lt;int&gt; </span>}}$
$\color{#BB00BB}{\text{         This is some int argument}}$
$\color{#BB00BB}{\text{         Default: <span style='color: #00BB00;'>default_int</span>}}$
$\color{#BB00BB}{\text{      <span style='color: #BB0000; font-weight: bold;'>--str_arg  </span><span style='color: #00BBBB;'>&lt;str&gt; </span>}}$
$\color{#BB00BB}{\text{         This is some string argument}}$
$\color{#BB00BB}{\text{         Default: <span style='color: #00BB00;'>default_str</span>}}$
$\color{#BB00BB}{\text{}}$
$\color{#BB00BB}{\text{   <span style='font-weight: bold; text-decoration: underline;'>Usage:</span>      }}$
$\color{#BB00BB}{\text{      <span style='font-weight: bold;'>example_function</span> \}}$
$\color{#BB00BB}{\text{         <span style='color: #BB0000; font-weight: bold;'>--int_arg  </span>"<span style='color: #00BB00;'>default_int</span>" \}}$
$\color{#BB00BB}{\text{         <span style='color: #BB0000; font-weight: bold;'>--str_arg  </span>"<span style='color: #00BB00;'>default_str</span>"}}$

### Specifying arguments

Defaults are used if an argument is not specified:

$\color{#BB00BB}{\text{example_function --str_arg "Example 1"}}$

$\color{#BB00BB}{\text{int_arg: default_int}}$
$\color{#BB00BB}{\text{str_arg: Example 1}}$

$\color{#BB00BB}{\text{example_function --int_arg "2"}}$

$\color{#BB00BB}{\text{int_arg: 2}}$
$\color{#BB00BB}{\text{str_arg: default_str}}$

but setting an argument overwrites the defaults:

$\color{#BB00BB}{\text{example_function --int_arg "3" --str_arg "Example 3"}}$

$\color{#BB00BB}{\text{int_arg: 3}}$
$\color{#BB00BB}{\text{str_arg: Example 3}}$

In any case, it is checked that only valid arguments are passed. An
error is thrown otherwise:

$\color{#BB00BB}{\text{example_function --int_arg "4" --invalid_arg "Example 4"}}$

$\color{#BB00BB}{\text{<span style='color: #BB0000; font-weight: bold;'>[2024/04/04 -- 12:15:26] Error in `examples/example_function.sh:14`</span>}}$
$\color{#BB00BB}{\text{<span style='color: #BB0000; font-weight: bold;'>[2024/04/04 -- 12:15:26]    Invalid argument to `example_function`: 'invalid_arg'</span>}}$
