@macros
Feature: Testing examples/macros

  Background:
    * Given command "ruby examples/macros"

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

  Scenario: Names
    * Given option "names: Carlos Jose Hernandez"
    * When we run command
    * Then stdout is '["Carlos", "Jose", "Hernandez"]'

  Scenario: Integers
    * Given option "integers: 12 34 62"
    * When we run command
    * Then stdout is '[12, 34, 62]'

  Scenario: Floats
    * Given option "floats: 1.2 3.4 0.62"
    * When we run command
    * Then stdout is '[1.2, 3.4, 0.62]'

  Scenario: Rationals
    * Given option "rationals: 4/8 3/4 8/3"
    * When we run command
    * Then stdout is '[(1/2), (3/4), (8/3)]'

  Scenario: CSVs
    * Given option "CSVs: a,b,c x,yy,zzz"
    * When we run command
    * Then stdout is '[["a", "b", "c"], ["x", "yy", "zzz"]]'

  Scenario: CSVIs
    * Given option "CSVIs: 1,2,3 12,13,32 11,22,333"
    * When we run command
    * Then stdout is '[[1, 2, 3], [12, 13, 32], [11, 22, 333]]'

  Scenario: --name
    * Given option "--name=Carlos"
    * When we run command
    * Then stdout is '"Carlos"'

  Scenario: --integer
    * Given option "--integer=103"
    * When we run command
    * Then stdout is '103'

  Scenario: --float
    * Given option "--float=1.03"
    * When we run command
    * Then stdout is '1.03'

  Scenario: --rational
    * Given option "--rational=66/3"
    * When we run command
    * Then stdout is '(22/1)'

  Scenario: --csv
    * Given option "--csv=a,b,c"
    * When we run command
    * Then stdout is '["a", "b", "c"]'

  Scenario: --csvi
    * Given option "--csvi=1,2,3"
    * When we run command
    * Then stdout is '[1, 2, 3]'
