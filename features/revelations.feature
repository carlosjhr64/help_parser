@revelations
Feature: Testing examples/revelations

  Background:
    * Given command "ruby examples/revelations"

  Scenario: Plain
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Please match usage."
    * Then stdout is ""

  Scenario: Validate help
    * Given option "-h --help"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""

# Options:

  Scenario: -a
    * Given option "-a"
    * When we run command
    * Then stdout is '{0=>"revelations", "a"=>true, "all"=>"y"}'
  Scenario: --all
    * Given option "--all"
    * When we run command
    * Then stdout is '{0=>"revelations", "a"=>true, "all"=>"y"}'
  Scenario: --all=n
    * Given option "--all=n"
    * When we run command
    * Then stdout is '{0=>"revelations", "all"=>"n", "a"=>true}'

  Scenario: --start --stop=123
    * Given option "--start --stop=123"
    * When we run command
    * Then stdout is '0, 123'
  Scenario: --start=100 --stop=123
    * Given option "--start=100 --stop=123"
    * When we run command
    * Then stdout is '100, 123'

  Scenario: --stop
    * Given option "--stop=123"
    * When we run command
    * Then stderr is 'Inclusive keys:  start stop'
  Scenario: --to_be --not_to_be
    * Given option "--to_be --not_to_be"
    * When we run command
    * Then stderr is 'Exclusive keys:  to_be not_to_be'
  Scenario: --rain
    * Given option "--rain"
    * When we run command
    * Then stderr is 'Conditional keys:  rain water wet'

  Scenario: --sum
    * Given option "--sum 3.4 4.3 1.1"
    * When we run command
    * Then stdout is '8.8'
  Scenario: --multiply
    * Given option "--multiply 3.4 4.3 1.1"
    * When we run command
    * Then stdout is '[3.4, 4.3, 1.1]'

  Scenario: numbers
    * Given option "1,2,3 4,5,6 7,8,9"
    * When we run command
    * Then stdout is '[[1, 2, 3], [4, 5, 6], [7, 8, 9]]'
