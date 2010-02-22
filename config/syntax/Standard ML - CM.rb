# Encoding: UTF-8

{comment: 
  "CM is the SML Compilation Manager, a sophisticated make that determines dependencies for you.",
 fileTypes: ["cm"],
 foldingStartMarker: /\(\*/,
 foldingStopMarker: /\*\)/,
 name: "Standard ML - CM",
 patterns: 
  [{begin: /\(\*/,
    captures: {0 => {name: "punctuation.definition.comment.cm"}},
    end: "\\*\\)",
    name: "comment.block.cm"},
   {match: /\b(?<_1>Library|is|Group|structure|signature|functor)\b/,
    name: "keyword.other.cm"},
   {begin: /^\s*(?<_1>#(?<_2>if).*)/,
    captures: 
     {1 => {name: "meta.preprocessor.cm"},
      2 => {name: "keyword.control.import.if.cm"}},
    end: "^\\s*(#(endif))",
    name: "meta.directive.cm"},
   {begin: /"/,
    end: "\"",
    name: "string.quoted.double.cm",
    patterns: [{match: /\\./, name: "constant.character.escape.cm"}]}],
 scopeName: "source.cm",
 uuid: "AEF91285-0D21-4BB0-B702-F5D0CEDBA4B8"}
