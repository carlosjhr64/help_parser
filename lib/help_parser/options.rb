module HelpParser
  class Options
    def initialize(version, help, argv)
      @hash = HelpParser.parsea(argv)
      if version && (@hash.has_key?('v') || @hash.has_key?('version'))
        # -v or --version
        raise VersionException, version
      end
      if help
        # -h or --help
        if @hash.has_key?('h') || _=@hash.has_key?('help')
          HelpParser.parseh(help, validate: true)  if _
          raise HelpException, help
        end
        specs = HelpParser.parseh(help)
        Completion.new(@hash, specs)
        if exclusive=specs[EXCLUSIVE]
          exclusive.each{|xs| raise HelpParser::UsageError, MSG[EXCLUSIVE_KEYS,*xs] if @hash.keys.count{|k|xs.include?(k)}>1}
        end
      end
      $VERBOSE = true if @hash['verbose']==true
      $DEBUG = true if @hash['debug']==true
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
