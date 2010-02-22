# Encoding: UTF-8

{fileTypes: ["e"],
 foldingStartMarker: /(?<_1>class|once|do|external)/,
 foldingStopMarker: /(?<_1>ensure|end)/,
 keyEquivalent: "^~E",
 name: "Eiffel",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.comment.eiffel"}},
    match: /(?<_1>--).*$\n?/,
    name: "comment.line.double-dash.eiffel"},
   {match: 
     /\b(?<_1>Indexing|indexing|deferred|expanded|class|inherit|rename|as|export|undefine|redefine|select|all|create|creation|feature|prefix|infix|separate|frozen|obsolete|local|is|unique|do|once|external|alias|require|ensure|invariant|variant|rescue|retry|like|check|if|else|elseif|then|inspect|when|from|loop|until|debug|not|or|and|xor|implies|old|end)\b/,
    name: "keyword.control.eiffel"},
   {match: /[a-zA-Z_]+/, name: "variable.other.eiffel"},
   {match: /\b(?<_1>True|true|False|false|Void|void|Result|result)\b/,
    name: "constant.language.eiffel"},
   {begin: /feature/, end: "end", name: "meta.features.eiffel"},
   {begin: /(?<_1>do|once)/,
    end: "(ensure|end)",
    name: "meta.effective_routine_body.eiffel"},
   {begin: /rescue/, end: "end", name: "meta.rescue.eiffel"},
   {begin: /"/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.eiffel"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.eiffel"}},
    name: "string.quoted.double.eiffel",
    patterns: [{match: /\\./, name: "constant.character.escape.eiffel"}]},
   {match: /[0-9]+/, name: "constant.numeric.eiffel"},
   {match: /\b(?<_1>deferred|expanded)\b/, name: "storage.modifier.eiffel"},
   {begin: 
     /^\s*
	(?<_1>(?:\b(?<_2>deferred|expanded)\b\s*)*) # modifier
	(?<_3>class)\s+
	(?<_4>\w+)\s* # identifier/,
    captures: {1 => {name: "storage.modifier.eiffel"}},
    end: "(?=end)",
    name: "meta.definition.class.eiffel",
    patterns: 
     [{begin: /\b(?<_1>extends)\b\s+/,
       captures: {1 => {name: "storage.modifier.java"}},
       end: "(?={|implements)",
       name: "meta.definition.class.extends.java",
       patterns: [{include: "#all-types"}]},
      {begin: /\b(?<_1>implements)\b\s+/,
       captures: {1 => {name: "storage.modifier.java"}},
       end: "(?={|extends)",
       name: "meta.definition.class.implements.java",
       patterns: [{include: "#all-types"}]}]}],
 repository: {number: {match: /[0-9]+/}, variable: {match: /[a-zA-Z0-9_]+/}},
 scopeName: "source.eiffel",
 uuid: "34672373-DED9-45B8-AF7E-2E4B6C3D6B76"}
