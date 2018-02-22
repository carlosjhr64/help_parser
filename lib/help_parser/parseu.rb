module HelpParser
  def self._parseu(chars)
    tokens,token = [],''
    while c = chars.shift
      case c
      when ' ','[',']'
        unless token==''
          tokens.push(token)
          token = ''
        end
        tokens.push HelpParser._parseu(chars) if c=='['
        return tokens if c==']'
      else
        token += c
      end
    end
    tokens.push(token) unless token==''
    return tokens
  end

  def self.parseu(line)
    chars = line.chars
    HelpParser.validate_line_chars(chars)
    tokens = HelpParser._parseu(chars)
    HelpParser.validate_usage_tokens(tokens)
    return tokens
  end
end
