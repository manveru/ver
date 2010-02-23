# Encoding: UTF-8

[{name: "Comments - Modern",
  scope: "source.fortran.modern",
  settings: 
   {shellVariables: 
     [{name: "TM_COMMENT_MODE", value: "line"},
      {name: "TM_COMMENT_START", value: "! "},
      {name: "TM_COMMENT_END", value: ""},
      {name: "TM_COMMENT_START_2", value: "* "},
      {name: "TM_COMMENT_DISABLE_INDENT", value: "yes"}]},
  uuid: "3F504D8D-A4FA-4CB9-9469-FAE360409C1E"},
 {name: "Comments - Punchcard",
  scope: "source.fortran",
  settings: 
   {shellVariables: 
     [{name: "TM_COMMENT_START", value: "C "},
      {name: "TM_COMMENT_END", value: ""},
      {name: "TM_COMMENT_MODE", value: "line"},
      {name: "TM_COMMENT_DISABLE_INDENT", value: "yes"},
      {name: "TM_COMMENT_START_2", value: "c "}]},
  uuid: "00465FB7-057F-4E7E-AFAC-B059DB0C03CF"},
 {name: "Completion: Include Strings",
  scope: "source.fortran meta.preprocessor.include string",
  settings: 
   {completionCommand: 
     "find \"$TM_DIRECTORY\" -name \"$TM_CURRENT_WORD*.h\" -maxdepth 2 -exec basename \"{}\" \\;|sort",
    disableDefaultCompletion: 1},
  uuid: "77FE8E31-891F-498D-990B-1B3AF6986DB6"},
 {name: "Completion: Interface",
  scope: "source.fortran meta.function.interface",
  settings: 
   {completions: ["module procedure", "operator", "assignment(=)"],
    disableDefaultCompletion: 0},
  uuid: "661D40B0-ABA8-4F53-93B8-9A3C96B74B58"},
 {name: "Completion: Specification Attributes",
  scope: "source.fortran meta.specification",
  settings: 
   {completions: ["parameter", "dimension()", "allocatable", "intent()"],
    disableDefaultCompletion: 1},
  uuid: "A5DF069E-A2A5-463A-A8A9-302A02B13DBC"},
 {name: "Indentation Rules",
  scope: "source.fortran",
  settings: 
   {decreaseIndentPattern: "^\\s*(?i:end)\\b",
    increaseIndentPattern: 
     "^\\s*((if.*then)|for|do|else|elseif|program|where)\\b.*",
    unIndentedLinePattern: "^\\s*[cC]\\s*.*$"},
  uuid: "DF8B5C60-9DCD-4180-8FE0-6CEA5050EFE7"},
 {name: "Spell Checking: Off for Include Strings",
  scope: "source.fortran meta.preprocessor.include string",
  settings: {spellChecking: 0},
  uuid: "3A48C5DB-0AB8-42FD-8F99-84C30C155168"},
 {name: "Symbol List: Add Custom Marks",
  scope: "comment.line.exclamation.mark.fortran.modern",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: "\n\t\ts/\\!-//; \n\t\ts/\\-/   /g;\n\t"},
  uuid: "A64DE2EC-3A2E-40E4-A26D-F53046DA8D42"},
 {name: "Symbol List: Exclude Ends ",
  scope: 
   "source.fortran entity.name.function.end, source.fortran entity.name.type.end",
  settings: {showInSymbolList: 0},
  uuid: "D3D60488-4BDD-468A-B1F4-19CC198D419A"},
 {name: "Typing Pairs: Include Statements",
  scope: "source.fortran meta.preprocessor.include",
  settings: 
   {highlightPairs: [["\"", "\""], ["'", "'"]],
    smartTypingPairs: [["\"", "\""], ["'", "'"]]},
  uuid: "98C10307-DA03-4243-A9BC-BE4C6708E5F5"}]
