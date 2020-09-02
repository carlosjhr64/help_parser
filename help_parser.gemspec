Gem::Specification.new do |s|

  s.name     = 'help_parser'
  s.version  = '6.5.200902'

  s.homepage = 'https://github.com/carlosjhr64/Ruby-HelpParser'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2018-10-20'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Welcome to the best Help Parser of all!
Tweeker!
Which do you find most helpful?
Hard?
I prefer easy.
DESCRIPTION

  s.summary = <<SUMMARY
Welcome to the best Help Parser of all!
Tweeker!
Which do you find most helpful?
Hard?
I prefer easy.
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
lib/help_parser/validations.rb
  )

  s.requirements << 'ruby: ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-linux]'

end
