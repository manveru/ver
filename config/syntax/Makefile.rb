# Encoding: UTF-8

{fileTypes: ["GNUmakefile", "makefile", "Makefile", "OCamlMakefile"],
 name: "Makefile",
 patterns: 
  [{begin: /^(?<_1>\w|[-_])+\s*\??=/,
    end: "$",
    name: "variable.other.makefile",
    patterns: [{match: /\\\n/}]},
   {begin: /`/,
    end: "`",
    name: "string.interpolated.backtick.makefile",
    patterns: [{include: "source.shell"}]},
   {begin: /#/,
    beginCaptures: {0 => {name: "punctuation.definition.comment.makefile"}},
    end: "$\\n?",
    name: "comment.line.number-sign.makefile",
    patterns: 
     [{match: /(?<!\\)\\$\n/,
       name: "punctuation.separator.continuation.makefile"}]},
   {match: /^\t\s*$/,
    name: "invalid.deprecated.opaque-rule-continuation.makefile"},
   {match: 
     /^(?<_1>\s*)\b(?<_2>\-??include|ifeq|ifneq|ifdef|ifndef|else|endif|vpath|export|unexport|define|endef|override)\b/,
    name: "keyword.control.makefile"},
   {captures: {1 => {name: "entity.name.function.makefile"}},
    match: /^(?<_1>[^\t ]+:(?!\=))\s*.*/,
    name: "meta.function.makefile"}],
 scopeName: "source.makefile",
 uuid: "FF1825E8-6B1C-11D9-B883-000D93589AF6"}
