module HelpParser
  class Options
    def initialize(version, help, argv)
      @hash = HelpParser.parsea(argv)
      if version && VSN.any?{@hash.key? _1}
        # -v or --version
        raise VersionException, version
      end
      if help
        if HLP.any?{@hash.key? _1}
          HelpParser.parseh(help, validate: true) if HLP.all?{@hash.key? _1}
          raise HelpException, help
        end
        specs = HelpParser.parseh(help)
        Completion.new(@hash, specs)
        if (exclusive=specs[EXCLUSIVE])
          exclusive.each do |x|
            count = x.count{@hash.key? _1}
            raise HelpParser::UsageError, MSG[EXCLUSIVE_KEYS,*x] if count > 1
          end
        end
        if (inclusive=specs[INCLUSIVE])
          inclusive.each do |i|
            count = i.count{@hash.key? _1}
            unless count.zero? || count==i.length
              raise HelpParser::UsageError, MSG[INCLUSIVE_KEYS,*i]
            end
          end
        end
        if (conditional=specs[CONDITIONAL])
          conditional.each do |c|
            if @hash.key?(c[0]) && !c.all?{@hash.key? _1}
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

    def respond_to_missing?(m, include_all=false)
      m[-1]=='!' ? super : true
    end

    def method_missing(m, *args, &block)
      super unless respond_to_missing?(m)
      unless args.empty? && block.nil?
        raise ArgumentError, 'expected neither args nor block'
      end
      m[-1]=='?' ? @hash.key?(m[0..-2].to_s) : @hash[m.to_s]
    end
  end
end
