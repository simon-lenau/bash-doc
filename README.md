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

<pre class="r-output">#!bash
source $(dirname "${BASH_SOURCE[0]}")/../init
&#10;function example_function {
    init_doc
    init_desc \
        "This is an" \
        "Example function"
    init_arg "int" "int_arg" "This is some int argument" "default_int"
    init_arg "str" "str_arg" "This is some string argument" "default_str"
&#10;    need_help $@ &amp;&amp; return $?
&#10;    eval "$(parse_arguments "$@")"
&#10;    echo "int_arg: ${int_arg[@]}"
    echo "str_arg: ${str_arg[@]}"
&#10;}</pre>

### Printing help

<pre class="r-output">example_function --help</pre>
<pre class="r-output">[1mexample_function[m   
   [1m[35mThis is an[m
   [1m[35mExample function[m
&#10;   [1m[4mArguments:[m      
      [1m[31m--int_arg  [m[36m&lt;int&gt; [m
         [327mThis is some int argument[m
         Default: [32mdefault_int[m
      [1m[31m--str_arg  [m[36m&lt;str&gt; [m
         [327mThis is some string argument[m
         Default: [32mdefault_str[m
&#10;   [1m[4mUsage:[m      
      [1mexample_function[m \
         [1m[31m--int_arg  [m"[32mdefault_int[m" \
         [1m[31m--str_arg  [m"[32mdefault_str[m"</pre>

### Specifying arguments

Defaults are used if an argument is not specified:

<pre class="r-output">example_function --str_arg "Example 1"</pre>
<pre class="r-output">int_arg: default_int
str_arg: Example 1</pre>
<pre class="r-output">example_function --int_arg "2"</pre>
<pre class="r-output">int_arg: 2
str_arg: default_str</pre>

but setting an argument overwrites the defaults:

<pre class="r-output">example_function --int_arg "3" --str_arg "Example 3"</pre>
<pre class="r-output">int_arg: 3
str_arg: Example 3</pre>

In any case, it is checked that only valid arguments are passed. An
error is thrown otherwise:

<pre class="r-output">example_function --int_arg "4" --invalid_arg "Example 4"</pre>
<pre class="r-output">[31m[1m[2024/04/04 -- 11:02:04] Error in `examples/example_function.sh:14`
[31m[1m[2024/04/04 -- 11:02:04]   Invalid argument to `example_function`: 'invalid_arg'[m</pre>
