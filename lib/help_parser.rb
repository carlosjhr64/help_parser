require_relative 'help_parser/constants'
require_relative 'help_parser/exceptions'
require_relative 'help_parser/aliases'
require_relative 'help_parser/parsea'
require_relative 'help_parser/parseu'
require_relative 'help_parser/parseh'
require_relative 'help_parser/k2t2r'
require_relative 'help_parser/completion'
require_relative 'help_parser/options'
require_relative 'help_parser/macros'

module HelpParser
  VERSION = '8.1.230208'
  autoload :Validate, 'help_parser/validate'

  def self.[](
    version = nil,
    help    = nil,
    argv    = [File.basename($0)]+ARGV)
    Options.new(version, help, argv)
  rescue HelpParserException => e
    e.exit
  end
end

# Requires:
# `ruby`
