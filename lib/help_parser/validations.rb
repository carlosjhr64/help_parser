module HelpParser
  def self.validate_line_chars(chars)
    count = 0
    chars.each do |c|
      if c=='['
        count += 1
      elsif c==']'
        count -= 1
      end
      break if count<0
    end
    raise HelpError, "Unbalance brackets: "+chars.join unless count==0
  end

  def self.validate_usage_tokens(tokens)
    words = []
    tokens.flatten.each do |token|
      match = token.match(FLAG)     ||
              token.match(LITERAL)  ||
              token.match(VARIABLE) ||
              token.match(FLAG_GROUP)
      raise HelpError, "Unrecognized usage token: #{token}" unless match
      words.push match["k"] # key
    end
    words.each_with_index do |word,i|
      raise HelpError, "Duplicate word: #{word}" unless i==words.rindex(word)
    end
  end

  def self.validate_usage_spec(spec)
    # TODO: Symmetry demands this,
    # but I can't think of any help text errors I'm not already catching.
  end

  def self.validate_type_spec(spec)
    raise HelpError, "Unrecognized type spec: "+spec unless spec=~TYPE_DEF
  end

  def self.validate_option_spec(spec)
    case spec
    when SHORT, LONG, SHORT_LONG, SHORT_LONG_DEFAULT
      # OK
    else
      raise HelpError, "Unrecognized option spec: #{spec}"
    end
  end

  def self.validate_usage_specs(specs)
    option_specs = specs.select{|a,b| !(a==USAGE || a==TYPES)}
    flags = option_specs.values.flatten.select{|f|f[0]=='-'}.map{|f| HelpParser.f2k(f)}
    flags.each_with_index do |flag,i|
      raise HelpError, "Duplicate flag: #{flag}" unless i==flags.rindex(flag)
    end   
    group = []
    specs_usage = specs[USAGE]
    unless specs_usage.nil?
      specs_usage.flatten.each do |token|
        if match = token.match(FLAG_GROUP)
          key = match["k"]
          raise HelpError, "No #{key} section given." unless specs[key]
          group.push(key)
        end
      end
    end
    specs.each do |key,tokens|
      raise HelpError, "No #{key} cases given." unless tokens.size>0
      next if specs_usage.nil? || key==USAGE || key==TYPES
      raise HelpError, "No usage given for #{key}." unless group.include?(key)
    end
  end

  def self.validate_k2t2r(specs, k2t, t2r)
    a,b = k2t.values.uniq.sort,t2r.keys.sort
    unless a==b
      c = (a+b).uniq.select{|x|!(a.include?(x) && b.include?(x))}
      raise HelpError, "Uncompleted types definition: #{c.join(",")}"
    end
    specs.each do |section,tokens|
      next if section==USAGE || section==TYPES
      tokens.each do |words|
        next if words.size<2
        default = words[-1]
        next if default[0]=='-'
        long_type = words[-2]
        i = long_type.index('=')
        next if i.nil?
        long = long_type[2..(i-1)]
        type = long_type[(i+1)..-1]
        regex = t2r[type]
        raise HelpError, "Default not #{type}: #{long}" unless regex=~default
      end
    end
  end

  def self.validate_no_extraneous_spaces(spec)
    raise HelpError, "Extraneous spaces in help." if spec == ""
  end
end
