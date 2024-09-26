@bad_help
Feature: Testing examples/bad_help

  Background:
    * Given command "ruby examples/bad_help"

  Scenario: 0
    * Given option "0"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Duplicate word:  args"
    * Then stdout is ""

  Scenario: 1
    * Given option "1"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Section not defined:  optoins"
    * Then stdout is ""

  Scenario: 2
    * Given option "2"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Unrecognized usage token:  <args+>"
    * Then stdout is ""

  Scenario: 3
    * Given option "3"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Duplicate flag:  number"
    * Then stdout is ""

  Scenario: 4
    * Given option "4"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Default does not match type:  number abc NUMBER /^\d+$/"
    * Then stdout is ""

  Scenario: 5
    * Given option "5"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Unrecognized type spec:  NUMBER ^\d+$"
    * Then stdout is ""

  Scenario: 6
    * Given option "6"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Unbalanced brackets:  bad_help [:options+] [<args>+"
    * Then stdout is ""

  Scenario: 7
    * Given option "7"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Unrecognized option spec:  --n --number=NUMBER 123"
    * Then stdout is ""

  Scenario: 8
    * Given option "8"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Missing usage:  extra"
    * Then stdout is ""

  Scenario: 9
    * Given option "9"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Missing cases:  extra"
    * Then stdout is ""

  Scenario: 10
    * Given option "10"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Extraneous spaces in help."
    * Then stdout is ""

  Scenario: 11
    * Given option "11"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Inconsistent use of variable:  arg1 NUMBER PHONE"
    * Then stdout is ""

  Scenario: 12
    * Given option "12"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Bad regex:  PHONE /^[]$/"
    * Then stdout is ""

  Scenario: 13
    * Given option "13"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Uncompleted types definition:  EXTRA"
    * Then stdout is ""

  Scenario: 14
    * Given option "14"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Duplicate flag:  n"
    * Then stdout is ""

  Scenario: 15
    * Given option "15"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Duplicate exclusive/inclusive spec:  a b"
    * Then stdout is ""

  # Actually, this one should be good help
  Scenario: 16
    * Given option "16"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then digest is "8dee11708152ecb980860f324bacb151"

  # It should be '-s --long', not '--long -s'
  Scenario: 17
    * Given option "17"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Unrecognized option spec:  --abc -a"
    * Then stdout is ""

  # Accidental double exclusive
  Scenario: 18
    * Given option "18"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Duplicate exclusive/inclusive spec:  abc abc"
    * Then stdout is ""

  # Accidental double inclusive
  Scenario: 19
    * Given option "19"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Duplicate exclusive/inclusive spec:  xyz xyz"
    * Then stdout is ""

  # List vs value args
  Scenario: 20
    * Given option "20"
    * When we run command
    * Then exit status is "78"
    * Then stderr is "Inconsistent use of variable:  <arg> <arg>+"
    * Then stdout is ""
