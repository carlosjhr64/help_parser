module HelpParser
  class HelpParserException < Exception
    def _init; @code = 1; end

    # Must give message
    def initialize(message)
      _init
      super
    end

    def exit
      message = self.message
      if @code > 0
        message = "\033[0;31m#{message}\033[0m"  if $stderr.tty?
        $stderr.puts message
      else
        $stdout.puts message
      end
      Kernel.exit @code
    end
  end

  class VersionException < HelpParserException
    def _init; @code = 0; end
  end

  class HelpException < HelpParserException
    def _init; @code = 0; end
  end

  class UsageError < HelpParserException
    def _init; @code = EX_USAGE; end
  end

  class SoftwareError < HelpParserException
    # Stuff that should not happen
    def _init; @code = EX_SOFTWARE; end
  end

  class NoMatch < HelpParserException
    # used to short-circuit out
    def _init; @code = EX_SOFTWARE; end

    # Forces it's own message
    def initialize
      super(NO_MATCH)
    end
  end

  class HelpError < HelpParserException
    def _init; @code = EX_CONFIG; end
  end
end
