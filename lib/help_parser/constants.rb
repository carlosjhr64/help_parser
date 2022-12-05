module HelpParser
  V,VSN = 'v','version'
  H,HLP = 'h','help'
  VRBS,DBG = 'verbose','debug'

  # reserved name
  USAGE = 'usage'
  TYPES = 'types'
  EXCLUSIVE = 'exclusive'
  INCLUSIVE = 'inclusive'
  CONDITIONAL = 'conditional'
  FLAG_CLUMPS = [EXCLUSIVE,INCLUSIVE,CONDITIONAL]
  RESERVED = [USAGE,TYPES,EXCLUSIVE,INCLUSIVE,CONDITIONAL]

  # sections
  SECTION_NAME = /^(?<name>[A-Z]\w+):$/

  # usage
  FLAG       = /^[-][-]?(?<k>\w+)$/
  LITERAL    = /^(?<k>\w[\w.-]*:?)$/
  VARIABLE   = /^<(?<k>\w+)(=(?<t>[A-Z]+))?>(?<p>[+])?$/
  FLAG_GROUP = /^:(?<k>\w+)(?<p>[+])?$/

  # spec --?w+
  SHORT = /^[-](?<s>\w)$/
  LONG  = /^[-][-](?<k>\w+)(=(?<t>[A-Z]+))?(,?\s+(?<d>[^-\s]\S*))?$/

  # spec -w,? --w+
  SHORT_LONG         = /^[-](?<s>\w),?\s+[-][-](?<k>\w+)$/
  SHORT_LONG_DEFAULT =
    /^[-](?<s>\w),?\s+[-][-](?<k>\w+)(=(?<t>[A-Z]+))?,?\s+(?<d>\S*)$/

  # spec W+ /~/
  TYPE_DEF = /^(?<t>[A-Z]+),?\s+\/(?<r>\S+)\/$/

  # spec w+( w+)+
  X_DEF = /^\w+( +\w+)+$/ # for both exclusive and inclusive specs

  CSV = /,?\s+/

  # exit codes
  EX_USAGE    = 64
  EX_SOFTWARE = 70
  EX_CONFIG   = 78

  # error messages, partials:
  DUP_KEY             = 'Duplicate key'
  DUP_WORD            = 'Duplicate word'
  DUP_FLAG            = 'Duplicate flag'
  DUP_X               = 'Duplicate exclusive/inclusive spec'
  UNSEEN_FLAG         = 'Undefined flag'
  INCONSISTENT        = 'Inconsistent use of variable'
  UNEXPECTED          = 'Unexpected string in help text'
  BAD_REGEX           = 'Bad regex'
  REDUNDANT           = 'Redundant'
  EXCLUSIVE_KEYS      = 'Exclusive keys'
  INCLUSIVE_KEYS      = 'Inclusive keys'
  CONDITIONAL_KEYS    = 'Conditional keys'
  UNBALANCED          = 'Unbalanced brackets'
  UNRECOGNIZED_TOKEN  = 'Unrecognized usage token'
  UNRECOGNIZED_TYPE   = 'Unrecognized type spec'
  UNRECOGNIZED_X      = 'Unrecognized exclusive/inclusive spec'
  UNRECOGNIZED_OPTION = 'Unrecognized option spec'
  UNRECOGNIZED        = 'Unrecognized'
  UNDEFINED_SECTION   = 'Section not defined'
  MISSING_CASES       = 'Missing cases'
  MISSING_USAGE       = 'Missing usage'
  UNCOMPLETED_TYPES   = 'Uncompleted types definition'
  BAD_DEFAULT         = 'Default does not match type'
  NOT_STRING          = 'Not a String'
  NOT_STRINGS         = 'Not all Strings'
  NOT_FLOAT           = 'Not a Float'
  NOT_FLOATS          = 'Not all Floats'
  NOT_INTEGER         = 'Not an Integer'
  NOT_INTEGERS        = 'Not all Integers'
  # error messages, full:
  NO_MATCH            = 'Software Error: NoMatch was not caught by HelpParser.'
  MATCH_USAGE         = 'Please match usage.'
  EXTRANEOUS_SPACES   = 'Extraneous spaces in help.'

  # lambda utilities
  MSG = lambda{|msg,*keys| "#{msg}:  #{keys.join(' ')}"}
  F2K = lambda{|f| f[1]=='-' ? f[2..((f.index('=')||0)-1)] : f[1]}
  REDTTY = lambda{|msg,out=$stderr|
    out.tty? ? out.puts("\033[0;31m#{msg}\033[0m"): out.puts(msg)
  }
end
