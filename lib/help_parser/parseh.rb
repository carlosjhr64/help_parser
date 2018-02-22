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
        HelpParser.validate_no_extraneous_spaces(spec)
        case name
        when USAGE
          HelpParser.validate_usage_spec(spec)
          specs[name].push HelpParser.parseu spec
        when TYPES
          HelpParser.validate_type_spec(spec)
          specs[name].push spec.split(CSV)
        when EXCLUSIVE
          HelpParser.validate_x_spec(spec)
          specs[name].push spec.split(CSV)
        else
          HelpParser.validate_option_spec(spec)
          specs[name].push spec.split(CSV)
        end
      end
    end
    HelpParser.validate_usage_specs(specs)
    return specs
  end
end
