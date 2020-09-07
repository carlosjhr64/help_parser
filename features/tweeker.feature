@tweeker
Feature: Testing examples/tweeker

  Background:
    * Given command "ruby examples/tweeker"

  Scenario: Plain
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Please match usage."
    * Then stdout is ""

  Scenario: -v
    * Given option "-v"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "6.5.0"

  Scenario: --version
    * Given option "--version"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "6.5.0"

  Scenario: -h
    * Given option "-h"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then header is "# The Tweeker Command #"

  Scenario: --help
    * Given option "--help"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then header is "# The Tweeker Command #"

  Scenario: First Usage
  # {0=>"tweeker",
  #  "s"=>true,
  #  "name"=>"Joe",
  #  "a"=>true,
  #  1=>"one",
  #  2=>"two",
  #  3=>"three",
  #  "args"=>["one", "two", "three"],
  #  "long"=>true,
  #  "number"=>"5",
  #  "value"=>"1.23",
  #  "all"=>"y"}
  # "Joe"
  # ["one", "two", "three"]
  # 1.23
  # 5
    * Given option "-s --name=Joe --number --value -a one two three"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then digest is "71ab7a0d6d3e617e9a699d851f7a832a"

  Scenario: Second Usage
  # {0=>"tweeker", "V"=>true, 1=>"Joe", "arg"=>"Joe"}
  # nil
    * Given option "-V Joe"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then digest is "18ba9a5cfd4b12b819c76839a5c7da4c"

  Scenario: -s --long synonyms
    * Given option "-s --long synonyms"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Redundant:  s long"
    * Then stdout is ""

  Scenario: --name=joe uncapped name
    * Given option "--name=joe uncapped name"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "--name=joe !~ NAME=/^[A-Z][a-z]+$/"
    * Then stdout is ""

  Scenario: --name missing
    * Given option "--name missing"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "--name !~ NAME=/^[A-Z][a-z]+$/"
    * Then stdout is ""

  Scenario: --number=BAD number
  ## Note that "BAD".to_i is 0 in the ruby version, so
  ## you really need to type it.
  # {0=>"tweeker", "number"=>"BAD", 1=>"number", "args"=>["number"]}
  # ["number"]
  # 0
    * Given option "--number=BAD number"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then digest is "fce7d4155de56f27fb75b2735d3e5364"

  Scenario: --to_be --not_to_be
    * Given option "--to_be --not_to_be Joe"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Exclusive keys:  to_be not_to_be"
    * Then stdout is ""
