# Encoding: UTF-8

{firstLineMatch: "^\\\\documentclass(?!.*\\{beamer\\})",
 foldingStartMarker: /\\begin\{.*\}|%.*\(fold\)\s*$/,
 foldingStopMarker: /\\end\{.*\}|%.*\(end\)\s*$/,
 keyEquivalent: "^~L",
 name: "LaTeX Rdaemon",
 patterns: 
  [{begin: /(?:\s*)(?<_1>(?<_2>\\)begin)(?<_3>\{)(?<_4>Rdaemon)(?<_5>\})/,
    captures: 
     {1 => {name: "support.function.be.latex.rdaemon.embedded"},
      2 => {name: "punctuation.definition.function.latex.rdaemon.embedded"},
      3 => 
       {name: "punctuation.definition.arguments.begin.latex.rdaemon.embedded"},
      4 => {name: "variable.parameter.function.latex.rdaemon.embedded"},
      5 => 
       {name: "punctuation.definition.arguments.end.latex.rdaemon.embedded"}},
    contentName: "markup.raw.verbatim.latex",
    end: "((\\\\)end)(\\{)(\\4)(\\})",
    name: "meta.function.verbatim.latex.rdaemon.embedded",
    patterns: [{include: "source.rd.console"}]},
   {include: "text.tex.latex"}],
 scopeName: "text.tex.latex.rdaemon",
 uuid: "D573458E-3BC8-4383-B350-4707C67597F0"}
