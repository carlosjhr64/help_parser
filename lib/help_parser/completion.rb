module HelpParser
  class Completion
    def initialize(hash, specs)
      @hash,@specs = hash,specs
      @cache = NoDupHash.new
      usage if @specs.has_key?(USAGE)
      pad
      types
    end

    def usage
      @specs[USAGE].each do |cmd|
        begin
          i = matches(cmd)
          raise NoMatch unless @hash.size==i
          @cache.each{|k,v|@hash[k]=v} # Variables
          return
        rescue NoMatch
          next
        ensure
          @cache.clear
        end
      end
      if _ = @specs["options"]
        dict = _.flatten.map{|_|_.scan(/\w+/).first}
        typos = @hash.keys.select{|k|k.is_a? String and not dict.include? k}
        raise UsageError, MSG[UNRECOGNIZED, typos] unless typos.empty?
      end
      raise UsageError, MATCH_USAGE
    end

    def types
      if t2r = HelpParser.t2r(@specs)
        k2t = HelpParser.k2t(@specs)
        @hash.each do |key,value|
          next unless key.is_a?(String)
          if type = k2t[key]
            regex = t2r[type]
            case value
            when String
              raise UsageError, "--#{key}=#{value} !~ #{type}=#{regex.inspect}" unless value=~regex
            when Array
              value.each do |string|
                raise UsageError, "--#{key}=#{string} !~ #{type}=#{regex.inspect}" unless string=~regex
              end
            else
              raise UsageError, "--#{key} !~ #{type}=#{regex.inspect}"
            end
          end
        end
      end
    end

    def pad
      # Synonyms and defaults:
      @specs.each do |section,options|
        next if section==USAGE || section==TYPES
        options.each do |words|
          next unless words.size>1
          first,second,default = words[0],words[1],words[2]
          if first[0]=='-'
            if second[0]=='-'
              i = second.index('=') || 0
              short,long = first[1],second[2..(i-1)]
              if @hash.has_key?(short)
                if @hash.has_key?(long)
                  raise UsageError, MSG[REDUNDANT, short, long]
                end
                @hash[long] = (default.nil?) ? true : default
              elsif value = @hash[long]
                @hash[short] = true
                if value==true && !default.nil?
                  @hash.delete(long)
                  @hash[long]=default
                end
              end
            else
              i = first.index('=') || 0
              long,default = first[2..(i-1)],second
              value = @hash[long]
              if value==true
                @hash.delete(long)
                @hash[long] = default
              end
            end
          end
        end
      end
    end

    def matches(cmd, i = 0)
      keys = @hash.keys
      cmd.each do |token|
        if token.is_a?(Array)
          begin
            i = matches(token, i)
          rescue NoMatch
            # OK, NEVERMIND!
          end
          next
        elsif m=FLAG_GROUP.match(token)
          group,plus = m['k'],m['p']
          key = keys[i]
          raise NoMatch if key.nil? || key.is_a?(Integer)
          list = @specs[group].flatten.select{|f|f[0]=='-'}.map{|f| F2K[f]}
          raise NoMatch unless list.include?(key)
          unless plus.nil?
            loop do
              key = keys[i+1]
              break if key.nil? || key.is_a?(Integer) || !list.include?(key)
              i+=1
            end
          end
        elsif m=VARIABLE.match(token)
          key = keys[i]
          raise NoMatch unless key.is_a?(Integer)
          variable,plus = m['k'],m['p']
          if plus.nil?
            @cache[variable] = @hash[key]
          else
            strings = []
            strings.push @hash[key]
            loop do
              key = keys[i+1]
              break unless key.is_a?(Integer)
              strings.push @hash[key]
              i+=1
            end
            @cache[variable] = strings
          end
        else # literal
          key = keys[i]
          raise NoMatch if key.nil? || @hash[key]!=token
        end
        i += 1
      end
      return i
    end
  end
end
