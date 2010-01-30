# Encoding: UTF-8

{fileTypes: ["erbsql", "sql.erb"],
 foldingStartMarker: /\s*\(\s*$/,
 foldingStopMarker: /^\s*\)/,
 keyEquivalent: "^~R",
 name: "SQL (Rails)",
 patterns: 
  [{begin: /<%+(?!>)=?/,
    end: "%>",
    name: "source.ruby.rails.embedded.sql",
    patterns: 
     [{match: /#.*?(?=%>)/, name: "comment.line.number-sign.ruby"},
      {include: "source.ruby.rails"}]},
   {include: "source.sql"}],
 scopeName: "source.sql.ruby",
 uuid: "D54FBDED-5481-4CC7-B75F-66465A499882"}
