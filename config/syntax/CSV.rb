# Encoding: UTF-8

{fileTypes: ["csv"],
 keyEquivalent: "^~C",
 name: "CSV",
 patterns: [{include: "#table"}],
 repository: 
  {field: 
    {patterns: 
      [{begin: /(?<_1>^|(?<=,))(?<_2>")/,
        beginCaptures: {2 => {name: "punctuation.definition.field.csv"}},
        comment: 
         "\n\t\t\t\t\t\tthis field uses \"s and is thus able to enclose\n\t\t\t\t\t\tnewlines or commas\n\t\t\t\t\t",
        contentName: "meta.tabular.field.quoted.csv",
        end: "(\")($|(,))",
        endCaptures: 
         {1 => {name: "punctuation.definition.field.csv"},
          3 => {name: "punctuation.separator.tabular.field.csv"}},
        patterns: 
         [{match: /""/,
           name: "constant.character.escape.straight-quote.csv"}]},
       {begin: /(?<_1>:^|(?<=,))(?!$|,)/,
        contentName: "meta.tabular.field.csv",
        end: "$|(,)",
        endCaptures: {1 => {name: "punctuation.separator.tabular.field.csv"}}},
       {match: /,/, name: "punctuation.separator.tabular.field.csv"}]},
   header: 
    {begin: /^(?!$)/,
     end: "$",
     name: "meta.tabular.row.header.csv",
     patterns: [{include: "#field"}]},
   row: 
    {begin: /^(?!$)/,
     end: "$",
     name: "meta.tabular.row.csv",
     patterns: [{include: "#field"}]},
   table: 
    {begin: /^/,
     end: "^$not possible$^",
     name: "meta.tabular.table.csv",
     patterns: 
      [{include: "#header"},
       {begin: /(?<_1>\n)/,
        beginCaptures: {1 => {name: "punctuation.separator.table.row.csv"}},
        comment: 
         "\n\t\t\t\t\t\teverything after the first row is not a header\n\t\t\t\t\t",
        end: "^$not possible$^",
        patterns: 
         [{include: "#row"},
          {match: /\n/, name: "punctuation.separator.table.row.csv"}]}]}},
 scopeName: "text.tabular.csv",
 uuid: "B0691F9F-D279-48CB-8959-2C9426579002"}
