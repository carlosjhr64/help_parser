# Help Parser IX: Revelations

* [VERSION 9.0.240925](https://github.com/carlosjhr64/help_parser/releases)
* [github](https://www.github.com/carlosjhr64/help_parser)
* [rubygems](https://rubygems.org/gems/help_parser)

## DESCRIPTION:

Options parsing based on your help text.

## INSTALL:
```console
$ gem install help_parser
```
## SYNOPSIS:
<!-- The following PREVIEW has been approved for ALL PROGRAMMERS by CarlosJHR64.
For the README validator that checks against me lying....
```ruby
unless File.basename($PROGRAM_NAME) == 'revelations'
  # For example's sake say
  $PROGRAM_NAME = 'revelations'
  # and ARGV is
  ARGV.concat ['1,2,3','4,5,6']
  # and proceed as if run as: `revelations 1,2,3 4,5,6`
end
```
The following gem has been rated
| M | Mature | -->
```ruby
#!/usr/bin/env ruby
require 'help_parser'

VERSION = '1.2.3'
OPTIONS = HelpParser[VERSION, <<-HELP]
# <= Hash here, parser skips
# HelpParser command example #

One can write any notes on the help text as long as
it does not start with a space or a "Keyword:".

Usage:
  revelations :options+ [<arg>]
  revelations :alternate <args=FLOAT>+
  revelations literal <arg1=WORD> <arg2=WORD>
  revelations <numbers=CSVI>+

The ":keyword" refers to a flag in defined in the "Keyword:" section.
A "[...]" is an optional part of the usage.
A "+" means one or more of it is allowed.

Options:
  -v --version \t Give version and quit
  -h --help    \t Give help and quit
  --verbose    \t Set $VERBOSE true
  --debug      \t Set $DEBUG true

The above(version, help, verbose, debug) are built-in options.
The tab, "\t", splits the comment from the flags.
On its own a flag is set to true, else it's nil.
But you can also set a long flag value to a string as allowed by its type.

  -a --all=YN y    \t Short, long, typed, and defaulted

OPTIONS.all at first is nil. If set without a value, it's set to "y"
One can set it to to either "n" of "y" as allowed by YN(see below under Types:).

  --stop=NUMBER    \t Typed
  --start=NUMBER 0 \t Typed and defaulted

  --rain
  --water
  --wet

  --to_be
  --not_to_be

Exclusive:
  to_be not_to_be \t Tells parser these are mutually exclusive keys
Inclusive:
  start stop      \t Tells parser any of these must include all of these
Conditional:
  rain water wet  \t Tells parser if first then all
                  \t Note how one can continue the comment as needed

Alternate:
  --sum
  --multiply

Types:
  WORD    /^[A-Za-z]+$/
  NUMBER  /^\\d+$/
  FLOAT   /^\\d+\\.\\d+$/
  YN      /^[YNyn]$/
  CSVI    /^\\d+(,\\d+)*$/
# <= Hash here, parser breaks out
And now one can freely write whatever....
HELP

# Tell HelpParser how to remap the string values:
HelpParser.integer(:stop, :start) # HelpParser.map(:stop, :start, map: :to_i)
HelpParser.float(:args)           # HelpParser.map(:args, map: :to_f)
# Also available: HelpParser.rational(*name) = HelpParser.map(*names, map: to_r)

# Tell HelpParser how to split the string values:
HelpParser.split(:numbers, sep: ',', map: :to_i)

# If one runs `revelations 1,2,3 4,5,6`, then:
OPTIONS.numbers #=> [[1, 2, 3], [4, 5, 6]]
# And everything else is unset:
OPTIONS.stop #=> nil
```
## Features

* -h and --help simultaneously will check help string for errors
* `ARGV` setup for `ARGF` when one of the "Types:" given is "ARGF"
* `HelpParser::REDTTY[msg]` will red color output `msg` to `$stderr`.

## LICENSE:

(The MIT License)

Copyright (c) 2024 CarlosJHR64

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
