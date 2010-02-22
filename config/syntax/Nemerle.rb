# Encoding: UTF-8

{fileTypes: ["n"],
 foldingStartMarker: /(?<_1>\{|\(|<\[)/,
 foldingStopMarker: /(?<_1>\}|\)|\]>)/,
 keyEquivalent: "^~N",
 name: "Nemerle",
 patterns: 
  [{begin: /\/\//,
    beginCaptures: {0 => {name: "punctuation.definition.comment.nemerle"}},
    end: "$\\n?",
    name: "comment.line.double-slash.nemerle"},
   {begin: /\/\*/,
    captures: {0 => {name: "punctuation.definition.comment.nemerle"}},
    end: "\\*/",
    name: "comment.block.nemerle"},
   {match: /\b(?<_1>|false|null|true)\b/, name: "constant.language.nemerle"},
   {match: 
     /\b(?<_1>(?<_2>[0-9]+(?<_3>\.|\_)?[0-9]*(?<_4>b|bu|d|f|L|LU|m|u|ub|UL)?)|(?<_5>0(?<_6>b|o|x)[0-9]+))\b/,
    name: "constant.numeric.nemerle"},
   {match: 
     /\b(?<_1>catch|else|finally|for|foreach|if|match|repeat|try|unless|when|while)\b/,
    name: "keyword.control.nemerle"},
   {match: /(?<_1>\+|\-|\*|\/|\%)\=?/, name: "keyword.operator.nemerle"},
   {match: 
     /\b(?<_1>\_|as|assert|base|checked|do|fun|get|ignore|implements|in|is|lock|namespace|out|params|ref|set|syntax|throw|typeof|unchecked|using|with)\b/,
    name: "keyword.other.nemerle"},
   {match: 
     /\b(?<_1>array|bool|byte|char|class|decimal|double|enum|float|int|interface|list|long|macro|module|object|sbyte|short|string|struct|type|uint|ulong|ushort|variant|void)\b/,
    name: "storage.type.nemerle"},
   {match: 
     /\b(?<_1>abstract|def|delegate|event|extern|internal|mutable|override|public|private|protected|sealed|static|volatile|virtual|new)\b/,
    name: "storage.modifier.nemerle"},
   {match: /this/, name: "variable.language.nemerle"},
   {begin: /"/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.nemerle"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.nemerle"}},
    name: "string.quoted.double.nemerle",
    patterns: 
     [{match: /\\(?<_1>\\|'|\"|a|b|c[A-Z]+|e|f|n|r|u0+[0-9,A-Z]+|v)/,
       name: "constant.character.escape.nemerle"}]},
   {begin: /\$"/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.nemerle"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.nemerle"}},
    name: "string.interpolated.nemerle",
    patterns: 
     [{match: /\$[a-z,A-Z]+[a-z,A-Z,0-9]*(?<_1> |\+|\-|\*|\/|\%)/,
       name: "constant.character.escape"}]},
   {begin: /'/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.nemerle"}},
    end: "'",
    endCaptures: {0 => {name: "punctuation.definition.string.end.nemerle"}},
    name: "string.quoted.single.nemerle",
    patterns: 
     [{match: /\\(?<_1>\\|'|\"|a|b|c[A-Z]+|e|f|n|r|u0+[0-9,A-Z]+|v)/,
       name: "constant.character.escape"}]}],
 scopeName: "source.nemerle",
 uuid: "F563968D-4CB3-11DB-9F95-00112474B8F0"}
