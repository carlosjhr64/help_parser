@deader
# Just verifying it works
Feature: Testing examples/deader

  Background:
    * Given command "ruby examples/deader"

  Scenario: Plain
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Please match usage."
    * Then stdout is ""

  Scenario: --command
    * Given option "--command"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then digest is "cf117f8fa465ff782eb0dedae2f6cef6"

  # Verifying that the help string is correct
  Scenario: -h --help
    * Given option "-h --help"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then digest is "2b8cbf21a05f09a7335cb0ccb0d4c9c6"
