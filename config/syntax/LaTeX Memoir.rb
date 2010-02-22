# Encoding: UTF-8

{fileTypes: [],
 firstLineMatch: "^\\\\documentclass(\\[.*\\])?\\{memoir\\}",
 foldingStartMarker: /\\begin\{.*\}|%.*\(fold\)\s*$/,
 foldingStopMarker: /\\end\{.*\}|%.*\(end\)\s*$/,
 keyEquivalent: "^~M",
 name: "LaTeX Memoir",
 patterns: 
  [{begin: 
     /(?:\s*)(?<_1>(?<_2>\\)begin)(?<_3>\{)(?<_4>framed|shaded|leftbar)(?<_5>\})/,
    captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.end.latex"}},
    end: "((\\\\)end)(\\{)(\\4)(\\})",
    name: "meta.function.memoir-fbox.latex",
    patterns: [{include: "$self"}]},
   {begin: 
     /(?:\s*)(?<_1>(?<_2>\\)begin)(?<_3>\{)(?<_4>(?:fboxv|boxedv|V)erbatim)(?<_5>\})/,
    captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.end.latex"}},
    contentName: "markup.raw.verbatim.latex",
    end: "((\\\\)end)(\\{)(\\4)(\\})",
    name: "meta.function.memoir-verbatim.latex"},
   {begin: /(?:\s*)(?<_1>(?<_2>\\)begin)(?<_3>\{)(?<_4>alltt)(?<_5>\})/,
    captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.end.latex"}},
    contentName: "markup.raw.verbatim.latex",
    end: "((\\\\)end)(\\{)(alltt)(\\})",
    name: "meta.function.memoir-alltt.latex",
    patterns: 
     [{captures: {1 => {name: "punctuation.definition.function.tex"}},
       match: /(?<_1>\\)[A-Za-z]+/,
       name: "support.function.general.tex"}]},
   {include: "text.tex.latex"}],
 scopeName: "text.tex.latex.memoir",
 uuid: "D0853B20-ABFF-48AB-8AB9-3D8BA0755C05"}
