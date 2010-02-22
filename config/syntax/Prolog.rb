# Encoding: UTF-8

{fileTypes: [],
 foldingStartMarker: /%\s*region \w*/,
 foldingStopMarker: /%\s*end(?<_1>\s*region)?/,
 keyEquivalent: "^~P",
 name: "Prolog",
 patterns: 
  [{begin: /'/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.prolog"}},
    end: "'",
    endCaptures: {0 => {name: "punctuation.definition.string.end.prolog"}},
    name: "string.quoted.single.prolog",
    patterns: 
     [{match: /\\./, name: "constant.character.escape.prolog"},
      {match: /''/, name: "constant.character.escape.quote.prolog"}]},
   {begin: /\/\*/,
    captures: {0 => {name: "punctuation.definition.comment.prolog"}},
    end: "\\*/",
    name: "comment.block.prolog"},
   {captures: {1 => {name: "punctuation.definition.comment.prolog"}},
    match: /(?<_1>%).*$\n?/,
    name: "comment.line.percentage.prolog"},
   {match: /:-/, name: "keyword.operator.definition.prolog"},
   {match: /\b[A-Z][a-zA-Z0-9_]*\b/, name: "variable.other.prolog"},
   {comment: 
     "\n\t\t\tI changed this from entity to storage.type, but have no idea what it is -- Allan\n\t\t\tAnd I changed this to constant.other.symbol after glancing over the docs,\n\t\t\t    might still be wrong.  -- Infininight\n\t\t\t",
    match: /\b[a-z][a-zA-Z0-9_]*\b/,
    name: "constant.other.symbol.prolog"}],
 scopeName: "source.prolog",
 uuid: "C0E2ADB0-1706-4A28-8DB7-263BDC8B5C5C"}
