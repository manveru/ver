# Encoding: UTF-8

[{name: "Comments",
  scope: "text.gherkin.feature",
  settings: 
   {shellVariables: 
     [{name: "TM_COMMENT_START", value: "# "},
      {name: "TM_COMMENT_START_2", value: "=begin\n"},
      {name: "TM_COMMENT_END_2", value: "=end\n"}]},
  uuid: "75E08730-A1D7-4D0F-B594-EAFD9DD49B4D"},
 {name: "Gherkin Completions",
  scope: "text.gherkin.feature",
  settings: 
   {completions: 
     ["As a",
      "As an",
      "I want to",
      "So that",
      "Story:",
      "Scenario:",
      "Scenario Outline:",
      "Given",
      "Then",
      "When",
      "And",
      "But"]},
  uuid: "8B547854-6A6A-4E45-B51E-9324F0E9D364"},
 {name: "Symbol list: Scenario",
  scope: "text.gherkin.feature string.language.gherkin.scenario.title",
  settings: {showInSymbolList: 1, symbolTransformation: "s/^\\s*:\\s*/ /"},
  uuid: "90F0D309-13C4-4286-88DE-60F61DDEF094"},
 {name: "Symbol list: Steps with Regexp",
  scope: "source.ruby.rspec.cucumber.steps string.regexp.step.cucumber",
  settings: {showInSymbolList: 1},
  uuid: "0843B907-3EC2-4F51-A1F6-85EFDB88464B"},
 {name: "Symbol list: Steps with String",
  scope: 
   "source.ruby.rspec.cucumber.steps string.quoted.step.cucumber.classic.ruby",
  settings: {showInSymbolList: 1},
  uuid: "41A25845-3142-47FE-A225-FDF453C1D59D"}]
