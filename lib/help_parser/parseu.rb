module HelpParser
  # Chars := String.split(/\t/,2).first.strip.chars
  # Token := String=~/^[^ \[\]]$/
  # Note that emergent Token is String=~/^[^\s\[\]]$/
  # Tokens := Array(Token|Tokens)
  def self.parseu(chars)
    tokens,token = [],''
    while (c=chars.shift)
      case c
      when ' ','[',']'
        unless token==''
          tokens.push(token)
          token = ''
        end
        tokens.push HelpParser.parseu(chars) if c=='['
        return tokens if c==']'
      else
        token += c
      end
    end
    tokens.push(token) unless token==''
    tokens
  end
end
