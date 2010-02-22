# Encoding: UTF-8

{comment: 
  "\nTODO:  Command for copy original to untranslated, label as fuzzy, remove fuzzy, next fuzzy etc\nCreate meta scope for each entry\n",
 fileTypes: ["po", "potx"],
 foldingStartMarker: /#[ \.:,|]/,
 foldingStopMarker: /^\s*$/,
 keyEquivalent: "^~G",
 name: "Gettext",
 patterns: 
  [{begin: /msgid\s+""/, end: "^$", name: "entity.name.section.header.po"},
   {captures: 
     {1 => {name: "constant.character.double-quote.po"},
      2 => {name: "string.quoted.double.po"},
      3 => {name: "constant.character.double-quote.po"}},
    match: /^msgid(?:_plural)?\s+(?<_1>")(?<_2>.*)(?<_3>")\s*$/,
    name: "keyword.control.msgid.po"},
   {captures: 
     {1 => {name: "constant.character.double-quote.po"},
      2 => {name: "string.quoted.double.po"},
      3 => {name: "constant.character.double-quote.po"}},
    match: /^msgstr(?:\[\d?\])?\s+(?<_1>")(?<_2>.*)(?<_3>")\s*$/,
    name: "keyword.control.msgstr.po"},
   {captures: 
     {1 => {name: "constant.character.double-quote.po"},
      2 => {name: "string.quoted.double.po"},
      3 => {name: "constant.character.double-quote.po"}},
    match: /^msgctxt(?:\[\d?\])?\s+(?<_1>")(?<_2>.*)(?<_3>")\s*$/,
    name: "keyword.control.msgctxt.po"},
   {captures: 
     {1 => {name: "constant.character.double-quote.po"},
      2 => {name: "string.quoted.double.po"},
      3 => {name: "constant.character.double-quote.po"}},
    match: /^(?<_1>")(?<_2>.+)(?<_3>")\s*$/,
    name: "string.quoted.double.po"},
   {match: /^#\s+(?<_1>.*)\s*$/, name: "comment.line.number-sign.po"},
   {captures: {1 => {name: "keyword.other.flag.po"}},
    match: 
     /^#,\s+(?<_1>(?:(?:fuzzy)|(?:no-)?(?:c|objc|sh|lisp|elisp|librep|scheme|smalltalk|java|csharp|awk|object-pascal|ycp|tcl|perl|perl-brace|php|gcc-internal|qt|boost)-format)(?:,\s*(?:(?:fuzzy)|(?:no-)?(?:c|objc|sh|lisp|elisp|librep|scheme|smalltalk|java|csharp|awk|object-pascal|ycp|tcl|perl|perl-brace|php|gcc-internal|qt|boost)-format))*)\s*$/,
    name: "comment.line.number-sign.flag.po"},
   {match: /^#\.\s+(?<_1>.*)\s*$/,
    name: "comment.line.number-sign.extracted.po"},
   {captures: 
     {1 => {name: "constant.character.sourceref.po"},
      3 => {name: "constant.numeric.linenumber.po"}},
    match: /^#:\s+(?<_1>(?<_2>.*))(?<_3>:(?<_4>[\d;]*))\s*$/,
    name: "comment.line.number-sign.reference.po"},
   {match: /^#|\s+(?<_1>msgid|msgctxt)\s+(?<_2>".*")\s*$/,
    name: "comment.line.number-sign.previous.po"},
   {comment: 
     "a line that does not begin with # or \". Could improve this regexp",
    match: /^[^#"].*$/,
    name: "invalid.illegal.po"}],
 scopeName: "source.po",
 uuid: "F07730BD-59BC-41D0-AC3F-4AB2DCB6C54A"}
