# Encoding: UTF-8

{fileTypes: ["gtd", "gtdlog"],
 foldingStartMarker: /^\s*project/,
 foldingStopMarker: /^\s*end\s*$/,
 keyEquivalent: "^~G",
 name: "GTDalt",
 patterns: 
  [{begin: /^\s*(project)\s+(.*)(\n)/,
    beginCaptures: 
     {0 => {name: "meta.line.project.begin.gtdalt"},
      1 => {name: "keyword.control.project.begin.gtdalt"},
      2 => {name: "entity.name.section.project.title.gtdalt"},
      3 => {name: "meta.project.newline.gtdalt"}},
    end: "^\\s*(end)\\s*",
    endCaptures: 
     {0 => {name: "meta.line.project.end.gtdalt"},
      1 => {name: "keyword.control.project.end.gtdalt"}},
    name: "meta.project.begin.gtdalt",
    patterns: [{include: "$self"}]},
   {captures: 
     {1 => {name: "storage.type.context.action.gtdalt"},
      2 => {name: "punctuation.definition.context.action.gtdalt"}},
    match: /^\s*((@)\S++\n)/,
    name: "meta.action.only-context.gtdalt"},
   {begin: /^\s*((@)\S++\s)/,
    beginCaptures: 
     {1 => {name: "storage.type.context.action.gtdalt"},
      2 => {name: "punctuation.definition.context.action.gtdalt"}},
    end: "\\n|$",
    name: "meta.action.gtdalt",
    patterns: [{include: "#note"}, {include: "#date"}, {include: "#title"}]},
   {captures: 
     {0 => {name: "comment.line.number-sign.action.completed.gtdalt"},
      2 => {name: "punctuation.definition.completed.gtdalt"},
      3 => {name: "punctuation.definition.completed.gtdalt"},
      4 => {name: "string.quoted.other.timestamp.action.completed.gtdalt"},
      5 => {name: "punctuation.definition.date.gtdalt"},
      6 => {name: "punctuation.definition.date.gtdalt"}},
    match: /^((#)completed(:))((\[)\d{4}-\d{2}-\d{2}(\]))\s*(.*)/,
    name: "meta.action.completed.gtdalt"},
   {begin: /^((\[)\d+(\]))/,
    beginCaptures: 
     {1 => {name: "support.other.note.gtdalt"},
      2 => {name: "punctuation.definition.note.note.gtdalt"},
      3 => {name: "punctuation.definition.note.note.gtdalt"}},
    end: "\\n|$",
    name: "meta.note.gtdalt",
    patterns: [{include: "#link"}]},
   {captures: 
     {1 => {name: "punctuation.separator.archived.gtdalt"},
      2 => {name: "string.quoted.other.timestamp.action.archived.gtdalt"},
      3 => {name: "punctuation.separator.archived.gtdalt"},
      4 => {name: "support.other.project.action.archived.gtdalt"},
      5 => {name: "punctuation.separator.archived.gtdalt"},
      6 => {name: "storage.type.context.action.archived.gtdalt"},
      7 => {name: "comment.line.slash.action.archived.gtdalt"}},
    match: /^(\/)(\d{4}-\d{2}-\d{2})(\/)([^\/]+)(\/)(@\S+)\s++(.*)$/,
    name: "meta.action.archived.gtdalt"},
   {captures: 
     {1 => {name: "punctuation.separator.archived.gtdalt"},
      2 => {name: "string.quoted.other.timestamp.project.archived.gtdalt"},
      3 => {name: "punctuation.separator.archived.gtdalt"},
      4 => {name: "support.other.project.archived.gtdalt"}},
    match: /^(\/)(\d{4}-\d{2}-\d{2})(\/)([^\/]+)$/,
    name: "meta.project.archived.gtdalt"},
   {captures: {1 => {name: "punctuation.definition.comment.gtdalt"}},
    match: /^(#)\s+.*$/,
    name: "comment.line.number-sign.generic.gtdalt"}],
 repository: 
  {date: 
    {captures: 
      {1 => {name: "keyword.operator.due.gtdalt"},
       2 => {name: "punctuation.separator.key-value.due.gtdalt"},
       3 => {name: "string.quoted.other.timestamp.due.gtdalt"},
       4 => {name: "punctuation.definition.due.gtdalt"},
       5 => {name: "punctuation.definition.due.gtdalt"}},
     match: /((?:due|at|from)(:))((\[)\d{4}-\d{2}-\d{2}(\]))/},
   link: 
    {captures: 
      {1 => {name: "punctuation.definition.link.gtdalt"},
       2 => {name: "markup.underline.link.gtdalt"},
       3 => {name: "punctuation.definition.link.gtdalt"}},
     match: /(<)([^>]*)(>)/},
   note: 
    {captures: 
      {1 => {name: "punctuation.definition.note.gtdalt"},
       2 => {name: "punctuation.definition.note.gtdalt"}},
     match: /(\[)\d+(\])/,
     name: "support.other.note.gtdalt"},
   title: 
    {match: /\S+(?:\s+\S+)*?(?=\s*(?:\[\d+\]|(?:due|at|from):|$))/,
     name: "constant.other.title.gtdalt"}},
 scopeName: "text.gtdalt",
 uuid: "C36472BD-A8CD-4613-A595-CEFB052E6181"}
