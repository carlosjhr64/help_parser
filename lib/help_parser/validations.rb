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
    raise HelpError, MSG[UNBALANCED,chars.join] unless count==0
  end

  def self.validate_usage_tokens(tokens)
    words = []
    tokens.flatten.each do |token|
      match = token.match(FLAG)     ||
              token.match(LITERAL)  ||
              token.match(VARIABLE) ||
              token.match(FLAG_GROUP)
      raise HelpError, MSG[UNRECOGNIZED_TOKEN,token] unless match
      words.push match['k'] # key
    end
    words.each_with_index do |word,i|
      raise HelpError, MSG[DUP_WORD,word] unless i==words.rindex(word)
    end
  end

  def self.validate_usage_specs(specs)
    option_specs = specs.select{|a,b| !RESERVED[a]}
    flags = option_specs.values.flatten.select{|f|f[0]=='-'}.map{|f| F2K[f]}
    if exclusive=specs[EXCLUSIVE]
      seen = {}
      exclusive.each do |xs|
        k = xs.sort.join(' ').to_sym
        raise HelpError, MSG[DUP_X,k] if seen[k] or not xs.length==xs.uniq.length
        seen[k] = true
        xs.each do |x|
          raise HelpError, MSG[UNSEEN_FLAG, x] unless flags.include?(x)
        end
      end
    end
    flags.each_with_index do |flag,i|
      raise HelpError, MSG[DUP_FLAG,flag] unless i==flags.rindex(flag)
    end   
    group = []
    specs_usage = specs[USAGE]
    unless specs_usage.nil?
      specs_usage.flatten.each do |token|
        if match = token.match(FLAG_GROUP)
          key = match['k']
          raise HelpError, MSG[UNDEFINED_SECTION,key] unless specs[key]
          group.push(key)
        end
      end
    end
    specs.each do |key,tokens|
      raise HelpError, MSG[MISSING_CASES,key] unless tokens.size>0
      next if specs_usage.nil? or RESERVED[key]
      raise HelpError, MSG[MISSING_USAGE,key] unless group.include?(key)
    end
  end

  def self.validate_k2t2r(specs, k2t, t2r)
    a,b = k2t.values.uniq.sort,t2r.keys.sort
    unless a==b
      c = (a+b).uniq.select{|x|!(a.include?(x) && b.include?(x))}
      raise HelpError, MSG[UNCOMPLETED_TYPES,c.join(',')]
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
        raise HelpError, MSG[BAD_DEFAULT,long,default,type,regex.inspect] unless regex=~default
      end
    end
  end
end
