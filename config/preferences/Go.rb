# Encoding: UTF-8

[{name: "Comments",
  scope: "source.go",
  settings:
   {shellVariables:
     [{name: "TM_COMMENT_START", value: "// "},
      {name: "TM_COMMENT_START_2", value: "/*"},
      {name: "TM_COMMENT_END_2", value: "*/"},
      {name: "TM_COMMENT_DISABLE_INDENT_2", value: "yes"}]},
  uuid: "05400837-EE8F-44D1-A636-3EEB0E82FFF5"},
 {name: "Indentation Rules",
  scope: "source.go",
  settings:
   {decreaseIndentPattern:
     "(?x)\n\t    ^                            # start of line\n\t        (.*\\*/)?                 # skip comments if present\n             (\t\t\t\t\t# three possibilities\n\t           \\s* \\}                # whitespace and a closing curly brace\n\t           (                     # capture:\n\t             [^}{\"']* \\{        # anything other than curly braces or quotes, then open curly\n\t           )?                    # (optional)\n\t           [;\\s]*?               # any whitespace or semicolons\n\t         |\n                (?:\\s* (case|default).*:)\t# case statements pop back one indent\n              |\n                (?: \\) (?<! \\( ) )    # closing braces not preceded by opening braces\n             )\n\t        (//.*|/\\*.*\\*/\\s*)?      # skip any comments (optional)\n\t    $                            # end of line\n\t",
    increaseIndentPattern:
     "(?x)\n\t    ^ \n          (?: .* \\*/ )?\t\t\t\t# skip any comments\n          (?:\n           (.* \\{ [^}\"'\\n]*)\t\t# lines containing an open curly but no quotes or close curly\n           |\t\t\t\t\t\t# OR\n           (?:\\s* (case|default).*:)\t# case statements\n           |\t\t\t\t\t\t# OR\n           (.* \\( [^)\"'\\n]*)\t\t# lines containing an open brace but no quotes or close brace\n          )\n\t     (//.*|/\\*.*\\*/\\s*)?\t\t# skip any comments (optional)\n         $\n\t",
    indentNextLinePattern:
     "(?x)^\n\t    (?! .* [;:{}]                    # do not indent when line ends with ;, :, {, or }\n\t        \\s* (//|/[*] .* [*]/ \\s* $)  #  account for potential trailing comment\n\t    )\n\t",
    unIndentedLinePattern:
     "^\\s*((/\\*|\\*/|//|import\\b.*|package\\b.*).*)?$"},
  uuid: "160118A4-208D-4422-AFF0-0C21B5B78AAF"}]
