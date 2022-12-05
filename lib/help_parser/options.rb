module HelpParser
  class Options
    def initialize(version, help, argv)
      @hash = HelpParser.parsea(argv)
      if version && VSN.any?{@hash.has_key? _1}
        # -v or --version
        raise VersionException, version
      end
      if help
        if HLP.any?{@hash.key? _1}
          HelpParser.parseh(help, validate: true)  if HLP.all?{@hash.key? _1}
          raise HelpException, help
        end
        specs = HelpParser.parseh(help)
        Completion.new(@hash, specs)
        if exclusive=specs[EXCLUSIVE]
          exclusive.each do |x|
            count = x.count{@hash.key? _1}
            raise HelpParser::UsageError, MSG[EXCLUSIVE_KEYS,*x] if count > 1
          end
        end
        if inclusive=specs[INCLUSIVE]
          inclusive.each do |i|
            count = i.count{@hash.key? _1}
            unless count==0 or count==i.length
              raise HelpParser::UsageError, MSG[INCLUSIVE_KEYS,*i]
            end
          end
        end
        if conditional=specs[CONDITIONAL]
          conditional.each do |c|
            if @hash.key? c[0] and not c.all?{@hash.key? _1}
              raise HelpParser::UsageError, MSG[CONDITIONAL_KEYS,*c]
            end
          end
        end
      end
      $VERBOSE = true if @hash[VRBS]==true
      $DEBUG = true if @hash[DBG]==true
    end

    def to_h
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
