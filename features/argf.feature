@argf
Feature: Testing ARGF ARGV handling

  Background:
    * Given command "ruby examples/typed_argf"

  Scenario: caca huates
    * Given options "caca.md huates.md"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Does not exist:  caca.md, huates.md"
    * Then stdout is ""

  Scenario: cat | grep
    * Given options "--force --quiet README.md | grep 'Copyright'"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /^Copyright \(c\) \d\d\d\d \w+$/"

  Scenario: wut
    * Given options "--wut README.md TODO.md | wc -l"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /^\d+$/"
