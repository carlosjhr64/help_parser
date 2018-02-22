module HelpParser
  class Options
    def initialize( version, help, argv)
      @hash = HelpParser.parsea(argv)
      if version && (@hash.has_key?('v') || @hash.has_key?('version'))
        # -v or --version
        raise VersionException, version
      end
      if help
        if @hash.has_key?('h') || @hash.has_key?('help')
          # -h or --help
          raise HelpException, help
        end
        specs = HelpParser.parseh(help)
        Completion.new(@hash, specs)
      end
    end

    def _hash
      @hash
    end

    def [](k)
      @hash[k]
    end

    def method_missing(mthd, *args, &block)
      super if block or args.length > 0
      m = mthd.to_s
      case m[-1]
      when '?'
        @hash.key? m[0..-2]
      when '!'
        super
      else
        @hash[m]
      end
    end
  end
end
