Gem::Specification.new do |s|
  ## INFO ##
  s.name     = 'help_parser'
  s.version  = '8.2.230208'
  s.homepage = 'https://github.com/carlosjhr64/help_parser'
  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'
  s.date     = '2023-02-08'
  s.licenses = ['MIT']
  ## DESCRIPTION ##
  s.summary  = <<~SUMMARY
    Welcome to Help Parser!  
    Do you have your help text?  
    Let's parse!
  SUMMARY
  s.description = <<~DESCRIPTION
    Welcome to Help Parser!  
    Do you have your help text?  
    Let's parse!
  DESCRIPTION
  ## FILES ##
  s.require_paths = ['lib']
  s.files = %w[
    LICENSE
    README.md
    lib/help_parser.rb
    lib/help_parser/aliases.rb
    lib/help_parser/completion.rb
    lib/help_parser/constants.rb
    lib/help_parser/exceptions.rb
    lib/help_parser/k2t2r.rb
    lib/help_parser/macros.rb
    lib/help_parser/options.rb
    lib/help_parser/parsea.rb
    lib/help_parser/parseh.rb
    lib/help_parser/parseu.rb
    lib/help_parser/validate.rb
  ]
  
  ## REQUIREMENTS ##
  s.add_development_dependency 'colorize', '~> 0.8', '>= 0.8.1'
  s.add_development_dependency 'parser', '~> 3.2', '>= 3.2.0'
  s.add_development_dependency 'test-unit', '~> 3.5', '>= 3.5.7'
  s.requirements << 'git: 2.30'
end
