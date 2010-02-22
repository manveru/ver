# Encoding: UTF-8

{fileTypes: ["js.erb"],
 foldingStartMarker: /\/\*\*|\{\s*$/,
 foldingStopMarker: /\*\*\/|^\s*\}/,
 keyEquivalent: "^~J",
 name: "JavaScript (Rails)",
 patterns: 
  [{begin: /<%+#/,
    captures: {0 => {name: "punctuation.definition.comment.erb"}},
    end: "%>",
    name: "comment.block.erb"},
   {begin: /<%+(?!>)[-=]?/,
    captures: {0 => {name: "punctuation.section.embedded.ruby"}},
    end: "-?%>",
    name: "source.ruby.rails.erb",
    patterns: 
     [{captures: {1 => {name: "punctuation.definition.comment.ruby"}},
       match: /(?<_1>#).*?(?=-?%>)/,
       name: "comment.line.number-sign.ruby"},
      {include: "source.ruby.rails"}]},
   {include: "source.js"}],
 scopeName: "source.js.rails",
 uuid: "4A3E6DA7-67A3-45B1-9EE0-ECFF9C7FA6C0"}
