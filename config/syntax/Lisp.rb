# Encoding: UTF-8

{comment: "",
 fileTypes: ["lisp", "cl", "l", "mud", "el"],
 foldingStartMarker: /\(/,
 foldingStopMarker: /\)/,
 keyEquivalent: "^~L",
 name: "Lisp",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.comment.lisp"}},
    match: /(?<_1>;).*$\n?/,
    name: "comment.line.semicolon.lisp"},
   {captures: 
     {2 => {name: "storage.type.function-type.lisp"},
      4 => {name: "entity.name.function.lisp"}},
    match: 
     /(?<_1>\b(?i:(?<_2>defun|defmethod|defmacro))\b)(?<_3>\s+)(?<_4>(?<_5>\w|\-|\!|\?)*)/,
    name: "meta.function.lisp"},
   {captures: {1 => {name: "punctuation.definition.constant.lisp"}},
    match: /(?<_1>#)(?<_2>\w|[\\+-=<>'"&#])+/,
    name: "constant.character.lisp"},
   {captures: 
     {1 => {name: "punctuation.definition.variable.lisp"},
      3 => {name: "punctuation.definition.variable.lisp"}},
    match: /(?<_1>\*)(?<_2>\S*)(?<_3>\*)/,
    name: "variable.other.global.lisp"},
   {match: /\b(?i:case|do|let|loop|if|else|when)\b/,
    name: "keyword.control.lisp"},
   {match: /\b(?i:eq|neq|and|or)\b/, name: "keyword.operator.lisp"},
   {match: /\b(?i:null|nil)\b/, name: "constant.language.lisp"},
   {match: 
     /\b(?i:cons|car|cdr|cond|lambda|format|setq|setf|quote|eval|append|list|listp|memberp|t|load|progn)\b/,
    name: "support.function.lisp"},
   {match: 
     /\b(?<_1>(?<_2>0(?<_3>x|X)[0-9a-fA-F]*)|(?<_4>(?<_5>[0-9]+\.?[0-9]*)|(?<_6>\.[0-9]+))(?<_7>(?<_8>e|E)(?<_9>\+|-)?[0-9]+)?)(?<_10>L|l|UL|ul|u|U|F|f|ll|LL|ull|ULL)?\b/,
    name: "constant.numeric.lisp"},
   {begin: /"/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.lisp"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.lisp"}},
    name: "string.quoted.double.lisp",
    patterns: [{match: /\\./, name: "constant.character.escape.lisp"}]}],
 scopeName: "source.lisp",
 uuid: "00D451C9-6B1D-11D9-8DFA-000D93589AF6"}
