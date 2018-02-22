Gem::Specification.new do |s|

  s.name     = 'help_parser'
  s.version  = '5.2.0'

  s.homepage = 'https://github.com/carlosjhr64/Ruby-HelpParser'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2018-02-21'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
All help is about to get parsed...
Again!!!

And this time,
the battle between complexity and simplicity
has as familiar text.
DESCRIPTION

  s.summary = <<SUMMARY
All help is about to get parsed...
Again!!!
SUMMARY

  #s.extra_rdoc_files = ['README.md']
  #s.rdoc_options     = ['--main', 'README.md']

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

  s.requirements << 'ruby: ruby 2.4.2p198 (2017-09-14 revision 59899) [x86_64-linux]'

end
