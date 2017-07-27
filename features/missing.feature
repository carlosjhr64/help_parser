@missing
Feature: Testing examples/missing

  Background:
    * Given command "ruby examples/missing"

  Scenario: Plain
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "--abc: abc?:false"

  Scenario: --abc
    * Given option "--abc"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "--abc:true abc?:true"

  Scenario: --abc=ABC
    * Given option "--abc=ABC"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "--abc:ABC abc?:true"
