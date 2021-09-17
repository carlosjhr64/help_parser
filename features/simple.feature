@simple
Feature: Testing examples/simple

  Background:
    * Given command "ruby examples/simple"

  Scenario: Plain
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '{"0":"simple"}'

  Scenario: -sn ok good
    * Given option "-sn ok good"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to true
    * Then n maps to true
    * Then number => 1
    * Then args is [ok,good]

  Scenario: -q not good
    * Given option "-q not good"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Unrecognized:  q"
    * Then stdout is ""

  Scenario: -s --long synonyms
    * Given option "-s --long"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Redundant:  s long"
    * Then stdout is ""

  Scenario: -s -s
    * Given option "-s -s"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Duplicate key:  s"
    * Then stdout is ""

  Scenario: --long --long
    * Given option "--long --long"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Duplicate key:  long"
    * Then stdout is ""
