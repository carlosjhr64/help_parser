require_relative "./help_parser/constants"
require_relative "./help_parser/exceptions"
require_relative "./help_parser/aliases"
require_relative "./help_parser/parsea"
require_relative "./help_parser/validations"
require_relative "./help_parser/parseu"
require_relative "./help_parser/parseh"
require_relative "./help_parser/k2t2r"
require_relative "./help_parser/completion"
require_relative "./help_parser/options"
require_relative "./help_parser/macros"

module HelpParser
  VERSION = "5.1.0"

  def self.[](
    version = nil,
    help    = nil,
    argv    = [File.basename($0)]+ARGV)
    Options.new(version, help, argv)
  rescue HelpParserException => exception
    exception.exit
  end

  def self.run(
    version = nil,
    help    = nil,
    argv    = [File.basename($0)]+ARGV)
    options = Options.new(version, help, argv)
    yield options
  rescue HelpParserException => exception
    exception.exit
  end
end

# Requires:
#`ruby`
