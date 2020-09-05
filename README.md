# Help Parser VI: Tweeker

* [VERSION 6.5.200905](https://github.com/carlosjhr64/Ruby-HelpParser/releases)
* [github](https://www.github.com/carlosjhr64/Ruby-HelpParser)
* [rubygems](https://rubygems.org/gems/help_parser)

## DESCRIPTION:
Welcome to the best Help Parser of all!
Tweeker!
Which do you find most helpful?
Hard?
I prefer easy.

## SYNOPSIS:
<!-- For the README validator that checks against me lying....
```ruby
unless File.basename($PROGRAM_NAME) == 'awesome'
  # For example's sake say
  $PROGRAM_NAME = 'awesome'
  # and ARGV is
  ARGV.concat ["-\-name=Doe", "-\-value", 'a', 'b', 'c']
  # and proceed as if run as:
  #     awesome -\-name=Doe -\-value  a b c
end
```
-->

```ruby
require "help_parser"

HELP = <<-HELP
# <= Hash here, parser skips
# The Awesome Command #
Usage:
  awesome [:options+] <args>+
  awesome :alternate+ <arg=NAME>
Options:
  -v --version       \t Give version and quit
  -h --help          \t Give help and quit
  -s --long          \t Short long synonyms
  --name=NAME        \t Typed
  --number 5         \t Defaulted
  --value=FLOAT 1.23 \t Typed and Defaulted
  -a --all=YN y      \t Short, long, typed, and defaulted
Alternate:
  -V                 \t Just short
  --to_be
  --not_to_be
Types:
  NAME  /^[A-Z][a-z]+$/
  FLOAT /^\\d+\\.\\d+$/
  YN    /^[YNyn]$/
Exclusive:
  to_be not_to_be    \t Tells parser these are mutually exclusive keys
# <= Hash here, parser breaks out
# Notes #
Blah blah blah
HELP

VERSION = "1.2.3"

# Macros:
HelpParser.string(:name)  # for options.name    : String
HelpParser.strings(:args) # for options.args    : Array(String)
HelpParser.float(:value)  # for options.value   : Float
HelpParser.int?(:number)  # for options.number? : Integer | Nil
#=> [:number]

OPTIONS = HelpParser[VERSION, HELP] #~> HelpParser

# If run as:
#     awesome --name=Doe --value a b c
OPTIONS.name    #=> "Doe"
OPTIONS.value   #=> 1.23
OPTIONS.args    #=> ["a", "b", "c"]
OPTIONS.number? #=> nil
```

Well, what do you think?
PERFECT!

## New for 6.4.2:

* Automates $DEBUG=true on --debug

## New for 6.4.0:

* Automates $VERBOSE=true on --verbose
* Reports typos you may have on options usage

## New for 6.1.0:

Running your `awesome` command with the `--help` flag will also check your help text for errors,
on top of giving the help text. Otherwise, the parser no longer checks for help text errors.

## INSTALL:

    $ sudo gem install help_parser

## LICENSE:

(The MIT License)

Copyright (c) 2020 CarlosJHR64

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
