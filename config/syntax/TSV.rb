# Encoding: UTF-8

{fileTypes: ["tsv"],
 keyEquivalent: "^~T",
 name: "TSV",
 patterns: [{include: "#table"}],
 repository: 
  {field: 
    {patterns: 
      [{begin: /(?<_1>:^|(?<=\t))(?!$|\t)/,
        contentName: "meta.tabular.field.tsv",
        end: "$|(\\t)",
        endCaptures: {1 => {name: "punctuation.separator.tabular.field.tsv"}}},
       {match: /\t/, name: "punctuation.separator.tabular.field.tsv"}]},
   header: 
    {begin: /^(?!$)/,
     end: "$",
     name: "meta.tabular.row.header.tsv",
     patterns: [{include: "#field"}]},
   row: 
    {begin: /^(?!$)/,
     end: "$",
     name: "meta.tabular.row.tsv",
     patterns: [{include: "#field"}]},
   table: 
    {begin: /^/,
     end: "^$not possible$^",
     name: "meta.tabular.table.tsv",
     patterns: 
      [{include: "#header"},
       {begin: /(?<_1>\n)/,
        beginCaptures: {1 => {name: "punctuation.separator.table.row.tsv"}},
        comment: 
         "\n\t\t\t\t\t\teverything after the first row is not a header\n\t\t\t\t\t",
        end: "^$not possible$^",
        patterns: 
         [{include: "#row"},
          {match: /\n/, name: "punctuation.separator.table.row.tsv"}]}]}},
 scopeName: "text.tabular.tsv",
 uuid: "7D87F38B-A972-4F61-B9C0-7D6D15EEED38"}
