# Encoding: UTF-8

{fileTypes: ["fscript"],
 foldingStartMarker: /\[/,
 foldingStopMarker: /\]/,
 keyEquivalent: "^~F",
 name: "F-Script",
 patterns: 
  [{match: /(?<_1>:|\w):/, name: "meta.dummy.symbol.ignore.fscript"},
   {captures: {1 => {name: "punctuation.definition.symbol.fscript"}},
    match: /(?<_1>:)\w+\b/,
    name: "constant.other.symbol.fscript"},
   {match: 
     /\b(?<_1>(?<_2>(?<_3>[0-9]+\.?[0-9]*)|(?<_4>\.[0-9]+))(?<_5>(?<_6>e|E)(?<_7>\+|-)?[0-9]+)?)\b/,
    name: "constant.numeric.fscript"},
   {match: 
     /#(?<_1>[[:lower:]]|_|[+=\-\/!%&*|><~?])(?<_2>\w|[+=\-\/!%&*|><~?:])*/,
    name: "constant.other.block.compact.fscript"},
   {captures: 
     {1 => {name: "punctuation.section.block.fscript"},
      2 => {name: "variable.parameter.block.fscript"},
      3 => {name: "punctuation.section.block.fscript"}},
    match: /(?<_1>\[)(?:\s*(?<_2>(?::\w+\s+)*:\w+)\s*\|)?\s*(?<_3>\])/,
    name: "meta.block.empty.fscript"},
   {begin: /(?<_1>\[)(?:\s*(?<_2>(?::\w+\s+)*:\w+)\s*\|)?/,
    beginCaptures: 
     {1 => {name: "punctuation.section.block.fscript"},
      2 => {name: "variable.parameter.block.fscript"}},
    end: "\\]",
    endCaptures: {0 => {name: "punctuation.section.block.fscript"}},
    name: "meta.block.fscript",
    patterns: 
     [{match: /\s+/, name: "meta.block.header.fscript"},
      {begin: /(?:\|(?<_1>\s*(?:\w+\s+)*\w+\s*)?\||(?=[^\s|]))/,
       captures: {1 => {name: "variable.other.local.fscript"}},
       end: "(?=\\])",
       name: "meta.block.content.fscript",
       patterns: [{include: "$base"}]}]},
   {match: /\b(?<_1>true|YES|false|NO|sys|nil)\b/,
    name: "constant.language.fscript"},
   {captures: {1 => {name: "entity.name.function.fscript"}},
    comment: "a hack for the symbol popup",
    match: /^(?<_1>\w+)\s*:=\s*(?=\[)/},
   {begin: /"/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.comment.begin.fscript"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.comment.end.fscript"}},
    name: "comment.block.quotes.fscript"},
   {begin: /'/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.fscript"}},
    end: "'",
    endCaptures: {0 => {name: "punctuation.definition.string.end.fscript"}},
    name: "string.quoted.single.fscript",
    patterns: [{match: /\\./, name: "constant.character.escape.fscript"}]}],
 scopeName: "source.fscript",
 uuid: "C2CB9A74-C9FC-4F63-8BAF-E64B72A60DD4"}
