require 'help_parser'
include HelpParser

# IRB Tools
require 'irbtools/configure'
_ = HelpParser::VERSION.split('.')[0..1].join('.')
Irbtools.welcome_message = "### HelpParser(#{_}) ###"
require 'irbtools'
IRB.conf[:PROMPT][:HelpParser] = {
  PROMPT_I:    '> ',
  PROMPT_N:    '| ',
  PROMPT_C:    '| ',
  PROMPT_S:    '| ',
  RETURN:      "=> %s \n",
  AUTO_INDENT: true,
}
IRB.conf[:PROMPT_MODE] = :HelpParser
