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
          exclusive.each do |x|
            count = @hash.keys.count{|k|x.include?(k)}
            raise HelpParser::UsageError, MSG[EXCLUSIVE_KEYS,*x] if count > 1
          end
        end
        if inclusive=specs[INCLUSIVE]
          inclusive.each do |i|
            count = @hash.keys.count{|k|i.include?(k)}
            raise HelpParser::UsageError, MSG[INCLUSIVE_KEYS,*i] unless count==0 or count==i.length
          end
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
