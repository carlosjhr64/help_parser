module HelpParser
  def self.parseh(help, validate: false)
    specs,name = NoDupHash.new,''
    help.each_line do |line|
      line.chomp!
      next if line==''
      if line=~/^[A-Z]\w+:$/
        name = line[0..-2].downcase
        specs[name] = []
      else
        next if name==''
        break if line[0]=='#'
        next if !(line[0]==' ')
        spec = (index=line.rindex("\t"))? line[0,index].strip : line.strip
        raise HelpError, EXTRANEOUS_SPACES if validate and spec==''
        case name
        when USAGE
          HelpParser.validate_line_chars(spec.chars) if validate
          tokens = HelpParser.parseu(spec.chars)
          HelpParser.validate_usage_tokens(tokens) if validate
          specs[name].push tokens
        when TYPES
          raise HelpError, MSG[UNRECOGNIZED_TYPE,spec] if validate and not spec=~TYPE_DEF
          specs[name].push spec.split(CSV)
        when EXCLUSIVE
          raise HelpError, MSG[UNRECOGNIZED_X,spec] if validate and not spec=~X_DEF
          specs[name].push spec.split(CSV)
        else
          if validate and not [SHORT, LONG, SHORT_LONG, SHORT_LONG_DEFAULT].any?{|_|_=~spec}
            raise HelpError, MSG[UNRECOGNIZED_OPTION,spec]
          end
          specs[name].push spec.split(CSV)
        end
      end
    end
    if validate
      HelpParser.validate_usage_specs(specs)
      if t2r = HelpParser.t2r(specs)
        k2t = HelpParser.k2t(specs)
        HelpParser.validate_k2t2r(specs, k2t, t2r)
      end
    end
    return specs
  end
end
