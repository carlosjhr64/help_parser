Gem::Specification.new do |s|
  ## INFO ##
  s.name     = 'help_parser'
  s.version  = '9.0.240924'
  s.homepage = 'https://github.com/carlosjhr64/help_parser'
  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'
  s.date     = '2024-09-24'
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
  s.add_development_dependency 'colorize', '~> 1.1', '>= 1.1.0'
  s.add_development_dependency 'cucumber', '~> 9.2', '>= 9.2.0'
  s.add_development_dependency 'parser', '~> 3.3', '>= 3.3.5'
  s.add_development_dependency 'rubocop', '~> 1.66', '>= 1.66.1'
  s.add_development_dependency 'test-unit', '~> 3.6', '>= 3.6.2'
  s.requirements << 'git: 2.30'
  s.requirements << 'ruby: 3.3'
end
