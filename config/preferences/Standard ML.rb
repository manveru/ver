# Encoding: UTF-8

[{name: "Settings",
  scope: "source.ml",
  settings: 
   {shellVariables: 
     [{name: "TM_COMMENT_START", value: "(*"},
      {name: "TM_COMMENT_END", value: "*)"}]},
  uuid: "0B18DEFF-66E4-49B7-8D1F-9E6B7B9DB5AA"},
 {name: "Indentation Rules",
  scope: "source.ml",
  settings: 
   {decreaseIndentPattern: "^(?!(struct|sig))\\s*(end|in)\\b",
    increaseIndentPattern: 
     "(?x) .*\\bsig\\b(?!.*\\bend\\b)\n\t\t\t\t\t\t\t| .*\\bstruct\\b(?!.*\\bend\\b) \n\t\t\t\t\t\t\t| .*\\blet\\b(?!.*\\bin\\b.*\\bend\\b)\n\t\t\t\t\t\t\t| \\blocal\\b(?!.*\\bin\\b.*\\bend\\b)\n\t\t\t\t\t\t\t| \\bin\\b(?!.*\\bend\\b)\n\t\t\t\t\t\t\t| .*\\(case\\b(?!\\))\n\t\t\t\t\t\t\t| .*\\bcase\\b(?!(.*of.*=>.*))",
    indentNextLinePattern: 
     "(?x) ^ .* : \\s*(\\(\\* .* \\*\\))? \\s* $\n\t\t\t\t\t\t\t| ^.*fun.*(?=\\n\\s*\\|)\n\t\t\t\t\t\t\t| ^.*(?=\\n\\s*\\|)"},
  uuid: "12572377-6CB1-45C3-8012-4E2918D182C5"}]
