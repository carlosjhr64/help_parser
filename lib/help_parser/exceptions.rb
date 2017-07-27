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
    def _init; @code = 64; end
  end

  class SoftwareError < HelpParserException
    # Stuff that should not happen
    def _init; @code = 70; end
  end

  class NoMatch < HelpParserException
    # used to shortcircuit out
    def _init; @code = 70; end

    # Forces it's owm message
    def initialize
      super("Software Error: NoMatch was not caught by HelpParser.")
    end
  end

  class HelpError < HelpParserException
    def _init; @code = 78; end
  end
end
