Gem::Specification.new do |s|

  s.name     = 'help_parser'
  s.version  = '8.0.210916'

  s.homepage = 'https://github.com/carlosjhr64/Ruby-HelpParser'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2021-09-16'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Can't help YOU???
You're not the first to say that...

I will parse your help!
DESCRIPTION

  s.summary = <<SUMMARY
Can't help YOU???
You're not the first to say that...
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

  s.requirements << 'ruby: ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux]'

end
