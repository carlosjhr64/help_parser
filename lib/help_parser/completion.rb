module HelpParser
  class Completion
    def initialize(hash, specs)
      @hash,@specs = hash,specs
      @cache = NoDupHash.new
      usage or diagnose if @specs.key?(USAGE)
      pad
      if @specs.key?(TYPES)
        k2t = types
        handle_argf(k2t) if k2t.detect{|_,v|v=='ARGF'}
      end
    end

    # Prepare ARGV for ARGF.
    def handle_argf(k2t)
      files = @hash.select{|k,_|k2t[k]=='ARGF'}.map{|_,v|v}.flatten
      e = files.reject{File.exist?_1}.join(', ')
      raise UsageError, MSG[NOT_EXIST, e] unless e.empty?
      ARGV.replace files
    end

    # Which usage does the user's command options match?
    def usage
      @specs[USAGE].each do |cmd|
        i = matches(cmd)
        raise NoMatch unless @hash.size==i
        @cache.each{|k,v|@hash[k]=v} # Variables
        return true # Good! Found matching usage.
      rescue NoMatch
        next
      ensure
        @cache.clear
      end
      false # Bad! Did not match any of the expected usage.
    end

    # Diagnose user's usage.
    def diagnose
      dict = {}
      @specs.each do |section,list|
        next if RESERVED.include? section
        list.flatten.select{_1[0]=='-'}.each do |key_type|
          key_type.scan(/\w+/) do |key|
            dict[key]=true
            break
          end
        end
      end
      typos = @hash.keys.select{_1.is_a?(String) && !dict[_1]}
      raise UsageError, MSG[UNRECOGNIZED, typos] unless typos.empty?

      raise UsageError, MATCH_USAGE
    end

    def types
      t2r,k2t = HelpParser.t2r(@specs),HelpParser.k2t(@specs)
      @hash.each do |key,value|
        next unless key.is_a?(String) && (type=k2t[key])
        regex = t2r[type]
        case value
        when String
          unless value=~regex
            raise UsageError, "--#{key}=#{value} !~ #{type}=#{regex.inspect}"
          end
        when Array
          value.each do |string|
            unless string=~regex
              raise UsageError,
                "--#{key}=#{string} !~ #{type}=#{regex.inspect}"
            end
          end
        else
          raise UsageError, "--#{key} !~ #{type}=#{regex.inspect}"
        end
      end
      k2t
    end

    def pad
      # Synonyms and defaults:
      @specs.each do |section,options|
        next if RESERVED.any?{section==_1}
        options.each do |words|
          next unless words.size>1
          first,second,default = words[0],words[1],words[2]
          if first[0]=='-'
            if second[0]=='-'
              i = second.index('=') || 0
              short,long = first[1],second[2..(i-1)]
              if @hash.key?(short)
                if @hash.key?(long)
                  raise UsageError, MSG[REDUNDANT, short, long]
                end
                @hash[long] = default.nil? ? true : default
              elsif (value=@hash[long])
                @hash[short] = true
                if value==true && !default.nil?
                  @hash.delete(long) # ArgvHash reset
                  @hash[long]=default
                end
              end
            else
              i = first.index('=') || 0
              long,default = first[2..(i-1)],second
              value = @hash[long]
              if value==true
                @hash.delete(long) # ArgvHash reset
                @hash[long] = default
              end
            end
          else
            raise SoftwareError, MSG[UNEXPECTED, words]
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
        elsif (m=FLAG_GROUP.match token)
          group,plus = m[:k],m[:p]
          key = keys[i]
          raise NoMatch unless key.is_a? String
          list = @specs[group].flatten.select{|f|f[0]=='-'}.map{|f| F2K[f]}
          raise NoMatch unless list.include?(key)
          unless plus.nil?
            loop do
              key = keys[i+1]
              break unless key.is_a?(String) && list.include?(key)
              i+=1
            end
          end
        elsif (m=VARIABLE.match(token))
          key = keys[i]
          raise NoMatch unless key.is_a?(Integer)
          variable,plus = m[:k],m[:p]
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
      i
    end
  end
end
