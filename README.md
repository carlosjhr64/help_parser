# Help Parser VIII: Help World

* [VERSION 8.0.210915](https://github.com/carlosjhr64/Ruby-HelpParser/releases)
* [github](https://www.github.com/carlosjhr64/Ruby-HelpParser)
* [rubygems](https://rubygems.org/gems/help_parser)

## DESCRIPTION:

Welcome to Help Parser!  
Do you have your help text?  
Let's parse!

## INSTALL:

```console
$ gem install help_parser
```

## SYNOPSIS:
<!-- The following PREVIEW has been approved for ALL PROGRAMMERS by CarlosJHR64.
For the README validator that checks against me lying....
```ruby
unless File.basename($PROGRAM_NAME) == 'help_world'
  # For example's sake say
  $PROGRAM_NAME = 'help_wolrd'
  # and ARGV is
  ARGV.concat ["-\-age", "-\-date=2020-09-07", 'invoke', 'the', 'command']
  # and proceed as if run as:
  #     awesome -\-name=Doe -\-value  a b c
end
```
The following gem has been rated
| M | Mature |
-->

```ruby
require "help_parser"

HELP = <<-HELP
# <= Hash here, parser skips
# HelpParser: Deader command example #
Usage:
  deader :options+ [<args>+]
  deader [:alternate] <arg=FLOAT>
  deader literal <arg1=WORD> <arg2=WORD> <arg3=WORD>
Options:
  -v --version       \t Give version and quit
  -h --help          \t Give help and quit
  -s --long          \t Short long synonyms
  --command invoke   \t Defaulted
  --date=DATE        \t Typed
  --age=INTEGER 80   \t Typed and Defaulted
  -a --all=YN y      \t Short, long, typed, and defaulted
  --to_be
  --not_to_be
Exclusive:
  to_be not_to_be    \t Tells parser these are mutually exclusive keys
Inclusive:
  date age           \t Tells parser any of these must include all of these
Alternate:
  --invoke
  --wut
Types:
  WORD    /^[A-Za-z]+$/
  DATE    /^\\d\\d\\d\\d-\\d\\d-\\d\\d$/
  INTEGER /^\\d+$/
  FLOAT   /^\\d+\\.\\d+$/
  YN      /^[YNyn]$/
# <= Hash here, parser breaks out
# Notes #
Don't invoke the command.
HELP

VERSION = "1.2.3"

OPTIONS = HelpParser[VERSION, HELP] #~> HelpParser

# Macros:
HelpParser.strings?(:args)             # for OPTIONS.args      : Array(String) | Nil
HelpParser.int?(:age)                  # for OPTIONS.age?      : Integer | Nil
HelpParser.float(:arg)                 # for options.arg       : Float
HelpParser.string(:arg1, :arg2, :arg3) # for OPTIONS.arg1, etc : String
#=> [:arg1, :arg2, :arg3]

## If run as:
##   deader --age --date=2020-09-07 invoke the command
OPTIONS.age?                 #=> 80
OPTIONS.age?.class           #=> Integer
OPTIONS.args?                #=> ["invoke", "the", "command"]
OPTIONS.args?.class          #=> Array
OPTIONS.arg? and OPTIONS.arg #=> false
OPTIONS.arg?.class           #=> FalseClass
```

## Features

* $DEBUG=true on --debug
* $VERBOSE=true on --verbose
* -h and --help simultaneously will check help string for errors

## LICENSE:

(The MIT License)

Copyright (c) 2021 CarlosJHR64

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
