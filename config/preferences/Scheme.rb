# Encoding: UTF-8

[{name: "Miscellaneous",
  scope: "source.scheme",
  settings: 
   {decreaseIndentPattern: 
     "(?x)^ [ \\t]*+\n\t  (?<par>\n\t    ( [^()\\n]++ | \\( \\g<par> \\) )*+\n\t  )\n\t  ( \\) [ \\t]*+ ) ++\n\t$",
    increaseIndentPattern: 
     "(?x)^ [ \\t]*+ \\(\n\t  (?<par>\n\t    ( [^()\\n]++ | \\( \\g<par> \\)? )*+\n\t  )\n\t$",
    shellVariables: [{name: "TM_COMMENT_START", value: ";"}],
    smartTypingPairs: [["\"", "\""], ["(", ")"], ["{", "}"], ["[", "]"]]},
  uuid: "08AF3E95-4BF0-4F28-BC76-31B9424A20CE"}]
