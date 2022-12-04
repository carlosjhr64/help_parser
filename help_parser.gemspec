Gem::Specification.new do |s|

  s.name     = 'help_parser'
  s.version  = '8.1.221204'

  s.homepage = 'https://github.com/carlosjhr64/help_parser'

  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2022-12-04'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Welcome to Help Parser!  
Do you have your help text?  
Let's parse!
DESCRIPTION

  s.summary = <<SUMMARY
Welcome to Help Parser!  
Do you have your help text?  
Let's parse!
SUMMARY

  s.require_paths = ['lib']
  s.files = %w(
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
  )

  s.requirements << 'ruby: ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [aarch64-linux]'

end
