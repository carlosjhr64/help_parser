@conditional
Feature: Testing examples/inclusive

  Background:
    * Given command "ruby examples/conditional"

  Scenario: Plain
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '{"0":"conditional"}'

  Scenario: -a -b
    * Given option "-a -b"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then a maps to true
    * Then b maps to true

  Scenario: -a -c
    * Given option "-a -c"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Conditional keys:  a b"
    * Then stdout is ""

  Scenario: -ced
    * Given option "-ced"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then c maps to true
    * Then e maps to true
    * Then d maps to true

  Scenario: -ed
    * Given option "-ed"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then e maps to true
    * Then d maps to true

  Scenario: -db
    * Given option "-db"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then d maps to true
    * Then b maps to true
