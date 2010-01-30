# Encoding: UTF-8

{comment: 
  "Ada -- chris@cjack.com. Feel free to modify, distribute, be happy. Share and enjoy.",
 fileTypes: ["adb", "ads"],
 foldingStartMarker: /\b(?i:(procedure|package|function|task|type|loop))\b/,
 foldingStopMarker: /\b(?i:(end))\b/,
 keyEquivalent: "^~A",
 name: "Ada",
 patterns: 
  [{captures: 
     {1 => {name: "storage.type.function.ada"},
      2 => {name: "entity.name.function.ada"}},
    match: /\b(?i:(function|procedure))\b\s+(\w+(\.\w+)?|"(?:\+|-|=|\*|\/)")/,
    name: "meta.function.ada"},
   {captures: 
     {1 => {name: "storage.type.package.ada"},
      2 => {name: "keyword.other.body.ada"},
      3 => {name: "entity.name.type.package.ada"}},
    match: 
     /\b(?i:(package)(?:\b\s+(body))?)\b\s+(\w+(\.\w+)?|"(?:\+|-|=|\*|\/)")/,
    name: "meta.function.ada"},
   {captures: 
     {1 => {name: "storage.type.function.ada"},
      2 => {name: "entity.name.function.ada"}},
    match: /\b(?i:(end))\b\s+(\w+(\.\w+)?|"(\+|-|=|\*|\/)")\s?;/,
    name: "meta.function.ada"},
   {captures: 
     {1 => {name: "keyword.control.import.ada"},
      2 => {name: "string.unquoted.import.ada"}},
    match: /\b(?i:(with|use))\b\s+(\w+(\.\w+)?)\s?;/,
    name: "meta.function.ada"},
   {match: /\b(?i:(begin|end|package))\b/, name: "keyword.control.ada"},
   {match: 
     /\b(?i:(\=>|abort|else|new|return|abs|elsif|not|reverse|abstract|null|accept|entry|select|access|exception|of|separate|aliased|exit|or|subtype|all|others|and|for|out|tagged|array|function|task|at|terminate|generic|pragma|then|goto|private|type|body|procedure|if|protected|until|case|in|use|constant|is|raise|range|when|declare|limited|record|while|delay|loop|rem|with|delta|renames|digits|mod|requeue|xor|do))\b/,
    name: "keyword.other.ada"},
   {match: 
     /\b((0(x|X)[0-9a-fA-F_]*)|(([0-9_]+\.?[0-9_]*)|(\.[0-9_]+))((e|E)(\+|-)?[0-9_]+)?)(L|l|UL|ul|u|U|F|f|ll|LL|ull|ULL)?\b/,
    name: "constant.numeric.ada"},
   {begin: /"/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ada"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ada"}},
    name: "string.quoted.double.ada",
    patterns: [{match: /\n/, name: "invalid.illegal.lf-in-string.ada"}]},
   {captures: {1 => {name: "punctuation.definition.comment.ada"}},
    match: /(--)(.*)$\n?/,
    name: "comment.line.double-dash.ada"}],
 scopeName: "source.ada",
 uuid: "0AB8A36E-6B1D-11D9-B034-000D93589AF6"}
