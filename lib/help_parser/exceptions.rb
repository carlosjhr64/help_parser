module HelpParser
  class HelpParserException < Exception
    def _init; @code = 1; end

    # Must give message
    def initialize(message)
      _init
      super
    end

    def exit
      if @code > 0
        STDERR.puts self.message
      else
        puts self.message
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
    # used to shortcircuit out
    def _init; @code = EX_SOFTWARE; end

    # Forces it's owm message
    def initialize
      super(NO_MATCH)
    end
  end

  class HelpError < HelpParserException
    def _init; @code = EX_CONFIG; end
  end
end
