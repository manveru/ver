# Encoding: UTF-8

{foldingStartMarker: /(?<_1>\{|\()\s*$/,
 foldingStopMarker: /^\s*(?<_1>\}|\))/,
 keyEquivalent: "^~L",
 name: "Lighttpd",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.comment.lighttpd-config"}},
    match: /(?<_1>#).*$\n?/,
    name: "comment.line.number-sign.lighttpd-config"},
   {captures: 
     {1 => {name: "punctuation.separator.key-value.lighttpd-config"},
      2 => {name: "string.regexp.lighttpd-config"},
      3 => {name: "punctuation.definition.string.begin.lighttpd-config"},
      4 => {name: "punctuation.definition.string.end.lighttpd-config"}},
    match: /(?<_1>=~|!~)\s*(?<_2>(?<_3>").*(?<_4>"))/},
   {captures: 
     {1 => {name: "punctuation.separator.key-value.lighttpd-config"},
      2 => {name: "constant.numeric.lighttpd-config"}},
    match: /(?<_1>=>?)\s*(?<_2>[0-9]+)/},
   {match: /=|\+=|==|!=|=~|!~|=>/,
    name: "punctuation.separator.key-value.lighttpd-config"},
   {begin: /"/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.lighttpd-config"}},
    end: "\"",
    endCaptures: 
     {0 => {name: "punctuation.definition.string.end.lighttpd-config"}},
    name: "string.quoted.double.lighttpd-config",
    patterns: 
     [{match: /""/, name: "constant.character.escape.quote.lighttpd-config"}]},
   {captures: {1 => {name: "punctuation.definition.variable.lighttpd-config"}},
    match: /(?<_1>\$)[a-zA-Z][0-9a-zA-Z]*/,
    name: "variable.language.lighttpd-config"},
   {match: /^\s*[a-zA-Z][0-9a-zA-Z.-]*/,
    name: "support.constant.name.lighttpd-config"},
   {captures: 
     {1 => {name: "invalid.illegal.semicolon-at-end-of-line.lighttpd-config"}},
    match: /(?<_1>;)\s*$/}],
 scopeName: "source.lighttpd-config",
 uuid: "C244BFF4-2C1A-490F-831E-8EF7DF4E0C9B"}
