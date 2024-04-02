---
title: bash-doc
output:
  md_document:
    variant: markdown_github
---





Simple functions for creating and formating documentation of bash scripts / functions

### Create documentation

#### `init_doc`

Initialize the documentation block

**Arguments:**
none

#### `init_desc`

Set the description of the function / script

**Arguments:**

- `$1,...,$n`: Lines of the description

#### `init_arg`

Initialize named arguments to be set via `--arg=val` or `--arg val` (using one or two dashes)

**Arguments:**
- `$1`: Argument type  
- `$2`: Argument name
- `$3`: Argument description
- `$4`: Default value

### Set arguments

#### `parse_arguments`
Set arguments passed as `--arg=val` or `--arg val` (using one or two dashes).
Should be used as `eval "$(parse_arguments "$@")"`

**Arguments:**
- `$1,...,$n`: Arguments to be set.

    
### Print help

#### `need_help`

Show the help if argument `-h` or `-help` (using one or two dashes) is present. If output is console and tput is available, tput is used for colouring.

**Arguments:**
none

## Examples

The following function is a basic example of how to use `bash-doc`:



<pre class="r-output"><code>#!/bin/bash
source $(dirname "${BASH_SOURCE[0]}")/../init

function example_function {
    init_doc
    init_desc \
        "This is an" \
        "Example function"
    init_arg "int" "int_arg" "This is some int argument" "default_int"
    init_arg "str" "str_arg" "This is some string argument" "default_str"

    need_help $@ &amp;&amp; return $?

    eval "$(parse_arguments "$@")"

    echo "int_arg: ${int_arg[@]}"
    echo "str_arg: ${str_arg[@]}"

}
</code></pre>

### Printing help

<pre class="r-output"><code>example_function --help
</code></pre>

<pre class="r-output"><code><span style='font-weight: bold;'>example_functionB</span>   
   <span style='color: #BB00BB; font-weight: bold;'>This is anB</span>
   <span style='color: #BB00BB; font-weight: bold;'>Example functionB</span>

   <span style='font-weight: bold; text-decoration: underline;'>Arguments:B</span>      
      <span style='color: #BB0000; font-weight: bold;'>--int_arg  B</span><span style='color: #00BBBB;'>&lt;int&gt; B</span>
         <span style='color: #005FFF;'>This is some int argumentB</span>
         <span style='color: #00BB00;'>Default: default_intB</span>
      <span style='color: #BB0000; font-weight: bold;'>--str_arg  B</span><span style='color: #00BBBB;'>&lt;str&gt; B</span>
         <span style='color: #005FFF;'>This is some string argumentB</span>
         <span style='color: #00BB00;'>Default: default_strB</span>

   <span style='font-weight: bold; text-decoration: underline;'>Usage:B</span>      
      <span style='font-weight: bold;'>example_functionB</span> \
         <span style='color: #BB0000; font-weight: bold;'>--int_arg  B</span>"<span style='color: #00BB00;'>default_intB</span>" \
         <span style='color: #BB0000; font-weight: bold;'>--str_arg  B</span>"<span style='color: #00BB00;'>default_strB</span>"
</code></pre>

### Setting arguments

Defaults are used if an argument is not specified:

<pre class="r-output"><code>example_function --str_arg "Example 1"
</code></pre>

<pre class="r-output"><code>int_arg: default_int
str_arg: Example 1
</code></pre>

<pre class="r-output"><code>example_function --int_arg "2"
</code></pre>

<pre class="r-output"><code>int_arg: 2
str_arg: default_str
</code></pre>

but setting an argument overwrites the defaults:

<pre class="r-output"><code>example_function --int_arg "3" --str_arg "Example 3"
</code></pre>

<pre class="r-output"><code>int_arg: 3
str_arg: Example 3
</code></pre>



