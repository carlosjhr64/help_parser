module HelpParser
  def self.parseh(help)
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
        next if line[0]!=' '
        spec = (index=line.rindex("\t"))? line[0,index].strip : line.strip
        raise HelpError, EXTRANEOUS_SPACES if spec == ''
        case name
        when USAGE
          specs[name].push HelpParser.parseu spec
        when TYPES
          raise HelpError, MSG[UNRECOGNIZED_TYPE,spec] unless spec=~TYPE_DEF
          specs[name].push spec.split(CSV)
        when EXCLUSIVE
          raise HelpError, MSG[UNRECOGNIZED_X,spec] unless spec=~X_DEF
          specs[name].push spec.split(CSV)
        else
          case spec
          when SHORT, LONG, SHORT_LONG, SHORT_LONG_DEFAULT
            specs[name].push spec.split(CSV)
          else
            raise HelpError, MSG[UNRECOGNIZED_OPTION,spec]
          end
        end
      end
    end
    HelpParser.validate_usage_specs(specs)
    return specs
  end
end
