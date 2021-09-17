@bool
Feature: Testing examples/bool

  Background:
    * Given command "ruby examples/bool"

  Scenario: Plain
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-a: false, --abc: false"

  Scenario: -a
    * Given option "-a"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-a: true, --abc: false"

  Scenario: --abc
    * Given option "--abc"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-a: false, --abc: true"

  Scenario: -a --abc
    * Given option "-a --abc"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "-a: true, --abc: true"
