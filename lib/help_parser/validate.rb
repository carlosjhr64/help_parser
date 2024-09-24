module HelpParser
module Validate
  def self.balanced_brackets(chars)
    count = 0
    chars.each do |c|
      c=='[' && (count+=1) or c==']' && (count-=1)
      break if count.negative?
    end
    raise HelpError, MSG[UNBALANCED,chars.join] unless count.zero?
  end

  def self.usage_tokens(tokens)
    words = []
    tokens.flatten.each do |token|
      raise HelpError, MSG[UNRECOGNIZED_TOKEN,token] unless
      [FLAG,LITERAL,VARIABLE,FLAG_GROUP]
      .detect{(_=token.match _1) && words.push(_[:k])}
    end
    words.each_with_index do |word,i|
      raise HelpError, MSG[DUP_WORD,word] unless i==words.rindex(word)
    end
  end

  def self.usage_specs(specs)
    flags = specs.except(*RESERVED).values.flatten
            .select{_1[0]=='-'}.map{F2K[_1]}
    FLAG_CLUMPS.each do |k|
      next unless (a=specs[k])
      seen = {}
      a.each do |xs|
        k = xs.sort.join(' ').to_sym
        if seen[k] || xs.length!=xs.uniq.length
          raise HelpError, MSG[DUP_X,k]
        end
        seen[k] = true
        xs.each do |x|
          raise HelpError, MSG[UNSEEN_FLAG, x] unless flags.include?(x)
        end
      end
    end
    flags.each_with_index do |flag,i|
      raise HelpError, MSG[DUP_FLAG,flag] unless i==flags.rindex(flag)
    end
    group,var = [],{}
    specs_usage = specs[USAGE]
    specs_usage&.flatten&.each do |token|
      case token
      when VARIABLE
        key,bool = $~[:k],$~[:p].nil?
        if var.key? key
          raise HelpError, MSG[INCONSISTENT,key] unless var[key]==bool
        else
          var[key]=bool
        end
      when FLAG_GROUP
        key = $~[:k]
        raise HelpError, MSG[UNDEFINED_SECTION,key] unless specs[key]
        group.push(key)
      end
    end
    specs.each do |key,tokens|
      raise HelpError, MSG[MISSING_CASES,key] if tokens.empty?
      next if specs_usage.nil? || RESERVED.include?(key)
      raise HelpError, MSG[MISSING_USAGE,key] unless group.include?(key)
    end
  end

  def self.k2t2r(specs, k2t, t2r)
    a,b = k2t.values.uniq.sort,t2r.keys.sort
    unless a==b
      c = (a+b).uniq.reject{|x|a.include?(x) && b.include?(x)}
      raise HelpError, MSG[UNCOMPLETED_TYPES,c.join(',')]
    end
    specs.each do |section,tokens|
      next if RESERVED.include? section
      tokens.each do |words|
        next if words.size<2
        default = words[-1]
        next if default[0]=='-'
        long_type = words[-2]
        i = long_type.index('=')
        next if i.nil?
        long = long_type[2..(i-1)]
        type = long_type[(i+1)..]
        regex = t2r[type]
        unless regex=~default
          raise HelpError, MSG[BAD_DEFAULT,long,default,type,regex.inspect]
        end
      end
    end
  end
end
end
