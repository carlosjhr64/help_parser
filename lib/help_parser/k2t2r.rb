module HelpParser
  # k2t is an acronym for the "key to type" mapping
  def self.k2t(specs)
    k2t = NoDupHash.new
    # If specs section is not a RESERVED section, it's an options list.
    tokens = specs.select{|k,v| k==USAGE or not RESERVED.include?(k)}
      # Tokens associating a key to a type.
      .values.flatten.select{|v|v.include?('=')}
    tokens.each do |token|
      if match = VARIABLE.match(token) || LONG.match(token)
        name, type = match[:k], match[:t]
        if _=k2t[name]
          raise HelpError, MSG[INCONSISTENT,name,type,_]  unless type==_
        else
          k2t[name] = type
        end
      else
        # Expected these to be caught earlier...
        raise SoftwareError, MSG[UNEXPECTED,token]
      end
    end
    return k2t
  end

  # t2r is an acronym for "type to regexp"
  def self.t2r(specs)
    if types = specs[TYPES]
      t2r = NoDupHash.new
      types.each do |pair|
        type, pattern = *pair
        begin
          t2r[type] = Regexp.new(pattern[1..-2])
        rescue
          raise HelpError, MSG[BAD_REGEX,type,pattern]
        end
      end
      return t2r
    end
    return nil
  end
end
