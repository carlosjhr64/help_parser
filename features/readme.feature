@readme
Feature: Testing examples/readme

  Background:
    * Given command "ruby examples/readme"

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
    * Then stdout is "5.0.0"

  Scenario: --version
    * Given option "--version"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "5.0.0"

  Scenario: -h
    * Given option "-h"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then header is "The Awesome Command."

  Scenario: --help
    * Given option "--help"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then header is "The Awesome Command."

  Scenario: First Usage
  # {0=>"awesome",
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
    * Then digest is "22554ca2f1dad1a841687dc64ec635ea"

  Scenario: Second Usage
  # {0=>"awesome", "V"=>true, 1=>"Joe", "arg"=>"Joe"}
  # nil
    * Given option "-V Joe"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then digest is "731b1911c063d3706f5bce586d12e283"

  Scenario: -s --long synonyms
    * Given option "-s --long synonyms"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Option s is a synonym for long."
    * Then stdout is ""

  Scenario: --name=joe uncapped name
    * Given option "--name=joe uncapped name"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Not a NAME: name"
    * Then stdout is ""

  Scenario: --name missing
    * Given option "--name missing"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Need a NAME: name"
    * Then stdout is ""

  Scenario: --number=BAD number
  ## Note that "BAD".to_i is 0 in the ruby version, so
  ## you really need to type it.
  # {0=>"awesome", "number"=>"BAD", 1=>"number", "args"=>["number"]}
  # ["number"]
  # 0
    * Given option "--number=BAD number"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then digest is "f6ab3f2729fd22f82ff526e556b5bf39"
