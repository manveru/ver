# Encoding: UTF-8

{fileTypes: ["strings"],
 name: "Strings File",
 patterns: 
  [{begin: /\/\*/,
    captures: {0 => {name: "punctuation.definition.comment.strings"}},
    end: "\\*/",
    name: "comment.block.strings"},
   {begin: /"/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.strings"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.strings"}},
    name: "string.quoted.double.strings",
    patterns: 
     [{match: /\\(?<_1>\\|[abefnrtv'"?]|[0-3]\d{,2}|[4-7]\d?|x[a-zA-Z0-9]+)/,
       name: "constant.character.escape.strings"},
      {match: /\\./, name: "invalid.illegal.unknown-escape.strings"},
      {match: 
        /(?x)%
	(?<_1>\d+\$)?                             # field (?<_2>argument #)
	[#0\- +']*                           # flags
	[,;:_]?                              # separator character (?<_3>AltiVec)
	(?<_4>(?<_5>-?\d+)|\*(?<_6>-?\d+\$)?)?              # minimum field width
	(?<_7>\.(?<_8>(?<_9>-?\d+)|\*(?<_10>-?\d+\$)?)?)?         # precision
	(?<_11>hh|h|ll|l|j|t|z|q|L|vh|vl|v|hv|hl)? # length modifier
	[@diouxXDOUeEfFgGaACcSspn%]          # conversion type
	/,
       name: "constant.other.placeholder.strings"},
      {match: /%/, name: "invalid.illegal.placeholder.c"}]}],
 scopeName: "source.strings",
 uuid: "429E2DB7-EB4F-4B34-A4DF-DBFD3336C581"}
