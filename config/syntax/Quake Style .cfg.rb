# Encoding: UTF-8

{fileTypes: ["cfg"],
 keyEquivalent: "^~Q",
 name: "Quake Style .cfg",
 patterns: 
  [{comment: 
     "the 2nd part of the regex is just to capture binds to number-keys and prevent them from getting highlighted as values.",
    match: 
     /\b(set(a|u|s)?|bind|undbind|unbindall|vstr|exec|kill|say|say_team|quit|echo)(\s+\d)?\b/,
    name: "keyword.other.quake3"},
   {match: /\b\d+(\.\d+)?\b/, name: "constant.numeric.quake3"},
   {begin: /"/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.quake3"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.quake3"}},
    name: "string.quoted.double.quake3",
    patterns: 
     [{match: /\\./, name: "constant.character.escape.quake3"},
      {match: 
        /\b(set(a|u|s)?|bind|unbindall|vstr|exec|kill|say|say_team|quit|echo)\b/,
       name: "keyword.other.string-embedded.quake3"}]},
   {captures: {1 => {name: "punctuation.definition.comment.quake3"}},
    match: /(\/\/).*$\n?/,
    name: "comment.line.double-slash.quake3"}],
 scopeName: "source.quake-config",
 uuid: "AAB8717E-6E5C-11D9-9BE0-0011242E4184"}
