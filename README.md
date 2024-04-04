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

<pre class="r-output"><code>$$\color{red}{#!bash}$$</code>
<code>$$\color{red}{source $(dirname "${BASH_SOURCE[0]}")/../init}$$</code>
<code>$$\color{red}{}$$</code>
<code>$$\color{red}{function example_function {}$$</code>
<code>$$\color{red}{    init_doc}$$</code>
<code>$$\color{red}{    init_desc \}$$</code>
<code>$$\color{red}{        "This is an" \}$$</code>
<code>$$\color{red}{        "Example function"}$$</code>
<code>$$\color{red}{    init_arg "int" "int_arg" "This is some int argument" "default_int"}$$</code>
<code>$$\color{red}{    init_arg "str" "str_arg" "This is some string argument" "default_str"}$$</code>
<code>$$\color{red}{}$$</code>
<code>$$\color{red}{    need_help $@ &amp;&amp; return $?}$$</code>
<code>$$\color{red}{}$$</code>
<code>$$\color{red}{    eval "$(parse_arguments "$@")"}$$</code>
<code>$$\color{red}{}$$</code>
<code>$$\color{red}{    echo "int_arg: ${int_arg[@]}"}$$</code>
<code>$$\color{red}{    echo "str_arg: ${str_arg[@]}"}$$</code>
<code>$$\color{red}{}$$</code>
<code>$$\color{red}{}}$$</code></pre>

### Printing help

<pre class="r-output"><code>$$\color{red}{example_function --help}$$</code></pre>
<pre class="r-output"><code>$$\color{red}{<span style='font-weight: bold;'>example_function</span>   }$$</code>
<code>$$\color{red}{   <span style='color: #BB00BB; font-weight: bold;'>This is an</span>}$$</code>
<code>$$\color{red}{   <span style='color: #BB00BB; font-weight: bold;'>Example function</span>}$$</code>
<code>$$\color{red}{}$$</code>
<code>$$\color{red}{   <span style='font-weight: bold; text-decoration: underline;'>Arguments:</span>      }$$</code>
<code>$$\color{red}{      <span style='color: #BB0000; font-weight: bold;'>--int_arg  </span><span style='color: #00BBBB;'>&lt;int&gt; </span>}$$</code>
<code>$$\color{red}{         This is some int argument}$$</code>
<code>$$\color{red}{         Default: <span style='color: #00BB00;'>default_int</span>}$$</code>
<code>$$\color{red}{      <span style='color: #BB0000; font-weight: bold;'>--str_arg  </span><span style='color: #00BBBB;'>&lt;str&gt; </span>}$$</code>
<code>$$\color{red}{         This is some string argument}$$</code>
<code>$$\color{red}{         Default: <span style='color: #00BB00;'>default_str</span>}$$</code>
<code>$$\color{red}{}$$</code>
<code>$$\color{red}{   <span style='font-weight: bold; text-decoration: underline;'>Usage:</span>      }$$</code>
<code>$$\color{red}{      <span style='font-weight: bold;'>example_function</span> \}$$</code>
<code>$$\color{red}{         <span style='color: #BB0000; font-weight: bold;'>--int_arg  </span>"<span style='color: #00BB00;'>default_int</span>" \}$$</code>
<code>$$\color{red}{         <span style='color: #BB0000; font-weight: bold;'>--str_arg  </span>"<span style='color: #00BB00;'>default_str</span>"}$$</code></pre>

### Specifying arguments

Defaults are used if an argument is not specified:

<pre class="r-output"><code>$$\color{red}{example_function --str_arg "Example 1"}$$</code></pre>
<pre class="r-output"><code>$$\color{red}{int_arg: default_int}$$</code>
<code>$$\color{red}{str_arg: Example 1}$$</code></pre>
<pre class="r-output"><code>$$\color{red}{example_function --int_arg "2"}$$</code></pre>
<pre class="r-output"><code>$$\color{red}{int_arg: 2}$$</code>
<code>$$\color{red}{str_arg: default_str}$$</code></pre>

but setting an argument overwrites the defaults:

<pre class="r-output"><code>$$\color{red}{example_function --int_arg "3" --str_arg "Example 3"}$$</code></pre>
<pre class="r-output"><code>$$\color{red}{int_arg: 3}$$</code>
<code>$$\color{red}{str_arg: Example 3}$$</code></pre>

In any case, it is checked that only valid arguments are passed. An
error is thrown otherwise:

<pre class="r-output"><code>$$\color{red}{example_function --int_arg "4" --invalid_arg "Example 4"}$$</code></pre>
<pre class="r-output"><code>$$\color{red}{<span style='color: #BB0000; font-weight: bold;'>[2024/04/04 -- 11:04:46] Error in `examples/example_function.sh:14`</span>}$$</code>
<code>$$\color{red}{<span style='color: #BB0000; font-weight: bold;'>[2024/04/04 -- 11:04:46]   Invalid argument to `example_function`: 'invalid_arg'</span>}$$</code></pre>
