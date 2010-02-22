# Encoding: UTF-8

{comment: 
  "Rez. Legacy Mac OS source code frequently contains Rez files. – chris@cjack.com",
 fileTypes: ["r"],
 foldingStartMarker: /(?<_1>\/\*\*|\{\s*$)/,
 foldingStopMarker: /(?<_1>\*\*\/|^\s*\})/,
 keyEquivalent: "^~R",
 name: "Rez",
 patterns: 
  [{begin: /\/\*/,
    captures: {0 => {name: "punctuation.definition.comment.rez"}},
    end: "\\*/",
    name: "comment.block.rez"},
   {captures: {1 => {name: "punctuation.definition.comment.rez"}},
    match: /(?<_1>\/\/).*$\n?/,
    name: "comment.line.double-slash.rez"},
   {comment: 
     "Note that Xcode gets case sensitivity wrong (last checked Xcode 2.0). I'm not sure built-in functions are case-insensitive, though, so we might too.",
    match: /\b(?i:(?<_1>change|data|delete|include|read|resource|type))\b/,
    name: "keyword.control.rez"},
   {match: 
     /\b(?i:(?<_1>align|array|binary|bit|bitstring|boolean|byte|case|char|cstring|decimal|enum|fill|hex|integer|key|literal|long|longint|nibble|octal|point|pstring|rect|string|switch|unsigned|wide|word|wstring))\b/,
    name: "storage.type.rez"},
   {match: 
     /\b(?i:(?<_1>appheap|locked|nonpurgeable|purgeable|sysheap|unlocked))\b/,
    name: "keyword.other.attributes.rez"},
   {captures: {1 => {name: "punctuation.definition.function.rez"}},
    match: 
     /(?<_1>\$\$)(?i:(?<_2>ArrayIndex|Attributes|BitField|Byte|CountOf|Date|Day|Format|Hour|ID|Long|Minute|Month|Name|PackedSize|Read|Resource|ResourceSize|Second|Shell|Time|Type|Version|Weekday|Word|Year))/,
    name: "support.function.built-in.rez"},
   {match: 
     /\b(?<_1>(?<_2>(?<_3>0(?<_4>x|X|B)|\$)[0-9a-fA-F]*)|(?<_5>(?<_6>[0-9]+\.?[0-9]*)|(?<_7>\.[0-9]+))(?<_8>(?<_9>e|E)(?<_10>\+|-)?[0-9]+)?)\b/,
    name: "constant.numeric.rez"},
   {begin: /"/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.rez"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.rez"}},
    name: "string.quoted.double.rez",
    patterns: [{include: "#escaped_char"}]},
   {begin: /'/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.rez"}},
    end: "'",
    endCaptures: {0 => {name: "punctuation.definition.string.end.rez"}},
    name: "string.quoted.single.rez",
    patterns: [{include: "#escaped_char"}]},
   {begin: /\$"/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.rez"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.rez"}},
    name: "string.quoted.other.hex.rez",
    patterns: [{include: "#escaped_char"}]},
   {captures: 
     {1 => {name: "punctuation.definition.preprocessor.rez"},
      2 => {name: "keyword.control.import.rez"}},
    match: 
     /^\s*(?<_1>#)\s*(?<_2>define|defined|else|elif|endif|if|ifdef|ifndef|include|line|printf|undef)\b/,
    name: "meta.preprocessor.rez"}],
 repository: 
  {escaped_char: {match: /\\./, name: "constant.character.escape.rez"}},
 scopeName: "source.rez",
 uuid: "F3EB29E9-8DB7-4052-9D48-5CDD2491D8D3"}
