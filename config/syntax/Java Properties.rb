# Encoding: UTF-8

{fileTypes: ["properties"],
 keyEquivalent: "^~J",
 name: "Java Properties",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.comment.java-props"}},
    match: /(?<_1>[#!])(?<_2>.+)?$\n?/,
    name: "comment.line.number-sign.java-props"},
   {begin: /\/\*/,
    captures: {0 => {name: "punctuation.definition.comment.java-props"}},
    end: "\\*/",
    name: "comment.block.java-props"},
   {captures: 
     {1 => {name: "keyword.other.java-props"},
      2 => {name: "punctuation.separator.key-value.java-props"}},
    comment: 
     "Not compliant with the properties file spec, but this works for me, and I'm the one who counts around here.",
    match: /^(?<_1>[^:=]+)(?<_2>[:=])(?<_3>.*)$/}],
 scopeName: "source.java-props",
 uuid: "2A28E50A-6B1D-11D9-8689-000D93589AF6"}
