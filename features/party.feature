@party
# Just verifying it works
Feature: Testing examples/party

  Background:
    * Given command "ruby examples/party"

  Scenario: Plain
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Please match usage."
    * Then stdout is ""

  # Verifying that the help string is correct
  Scenario: Check help text
    * Given option "-h --help"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then digest is "246240247ba0100b3a0452a6418fba09"

  Scenario: --touch
    * Given option "--touch"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then digest is "cf117f8fa465ff782eb0dedae2f6cef6"
