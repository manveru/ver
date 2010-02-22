# Encoding: UTF-8

[{name: "Indentation Rules",
  scope: "source.cmake",
  settings: 
   {decreaseIndentPattern: 
     "(?xi)\n\t    \\b end(function|macro|if|foreach|while) \\b\n\t |  \\b else(if)? \\b\n\t |  ^ [^(]* \\) \\s* $\n\t",
    increaseIndentPattern: 
     "(?xi)\n\t    \\b (function|macro|if|foreach|while) \\b\n\t |  \\b else(if)? \\b\n\t |  \\( [^)]* $\n\t"},
  uuid: "D58FED93-633B-4C26-89C1-53198843416A"},
 {name: "Completions",
  scope: "source.cmake",
  settings: 
   {completionCommand: 
     "\n\t# Commands are by convention written in all uppercase, but the command list is given in lowercase,\n\t# so we print both to enable people to use either\n\t# The first line is always the CMake executable version, so it gets stripped off\n\tcmake --help-command-list >( tail -n+2 | tee >(tr \"[a-z]\" \"[A-Z]\") | grep \"^$TM_CURRENT_WORD\" )\n\t"},
  uuid: "E60C579C-BEE8-4C0F-8FA3-0F9E1A851154"},
 {name: "Comments",
  scope: "source.cmake",
  settings: {shellVariables: [{name: "TM_COMMENT_START", value: "# "}]},
  uuid: "FCA85521-74FC-4A71-9ADE-DC055E63CAEE"},
 {name: "Symbol List",
  scope: "meta.function-call.function.cmake",
  settings: {showInSymbolList: "1", symbolTransformation: "s/^(\\w+).*$/$1/"},
  uuid: "3C9C38E0-2EC5-4963-9FC1-BD2D04EC62F7"}]
