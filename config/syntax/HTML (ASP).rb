# Encoding: UTF-8

{fileTypes: ["asp"],
 foldingStartMarker: 
  /(?<_1><(?i:(?<_2>head|table|div|style|script|ul|ol|form|dl))\b.*?>|\{)/,
 foldingStopMarker: 
  /(?<_1><\/(?i:(?<_2>head|table|div|style|script|ul|ol|form|dl))>|\})/,
 keyEquivalent: "^~A",
 name: "HTML (ASP)",
 patterns: 
  [{begin: /<%=?/,
    beginCaptures: {0 => {name: "punctuation.section.embedded.begin.asp"}},
    end: "%>",
    endCaptures: {0 => {name: "punctuation.section.embedded.end.asp"}},
    name: "source.asp.embedded.html",
    patterns: 
     [{captures: {1 => {name: "punctuation.definition.comment.asp"}},
       match: /(?<_1>').*?(?=%>)/,
       name: "comment.line.apostrophe.asp"},
      {include: "source.asp"}]},
   {include: "text.html.basic"}],
 scopeName: "text.html.asp",
 uuid: "27798CC6-6B1D-11D9-B8FA-000D93589AF6"}
