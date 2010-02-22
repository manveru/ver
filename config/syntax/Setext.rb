# Encoding: UTF-8

{fileTypes: ["etx", "etx.txt"],
 firstLineMatch: "setext",
 keyEquivalent: "^~S",
 name: "Setext",
 patterns: 
  [{include: "#inline"},
   {captures: 
     {1 => {name: "keyword.other.setext"},
      2 => {name: "punctuation.separator.key-value.setext"},
      3 => {name: "string.unquoted.setext"}},
    match: /^(?<_1>Subject|Date|From)(?<_2>:) (?<_3>.+)/,
    name: "meta.header.setext"},
   {match: /^={3,}\s*$\n?/, name: "markup.heading.1.setext"},
   {match: /^-{3,}\s*$\n?/, name: "markup.heading.2.setext"},
   {begin: /^(?<_1>>)\s/,
    captures: {1 => {name: "punctuation.definition.quote.setext"}},
    end: "$",
    name: "markup.quote.setext",
    patterns: [{include: "#inline"}]},
   {begin: /^(?<_1>[*])\s/,
    captures: {1 => {name: "punctuation.definition.bullet.setext"}},
    end: "$",
    name: "markup.other.bullet.setext",
    patterns: [{include: "#inline"}]},
   {begin: /`/,
    beginCaptures: {0 => {name: "punctuation.definition.raw.begin.setext"}},
    end: "`",
    endCaptures: {0 => {name: "punctuation.definition.raw.end.setext"}},
    name: "markup.raw.setext"},
   {captures: 
     {1 => {name: "punctuation.definition.note.setext"},
      2 => {name: "constant.other.reference.note.setext"},
      3 => {name: "punctuation.definition.reference.setext"},
      4 => {name: "string.quoted.other.note.setext"},
      5 => {name: "punctuation.definition.string.begin.setext"},
      7 => {name: "punctuation.definition.string.end.setext"}},
    match: 
     /^(?<_1>\.{2}) (?<_2>(?<_3>_)[-\w.]+) +(?<_4>(?<_5>\()(?<_6>.+(?<_7>\))|.+))$/,
    name: "meta.note.def.setext"},
   {captures: 
     {1 => {name: "punctuation.definition.reference.setext"},
      2 => {name: "constant.other.reference.link.setext"},
      3 => {name: "punctuation.definition.reference.setext"},
      4 => {name: "markup.underline.link.setext"}},
    match: /^(?<_1>\.{2}) (?<_2>(?<_3>_)[-\w.]+) +(?<_4>.{2,})$/,
    name: "meta.link.reference.def.setext"},
   {captures: {1 => {name: "punctuation.definition.comment.setext"}},
    match: /^(?<_1>\.{2}) (?![.]).+$\n?/,
    name: "comment.line.double-dot.setext"},
   {begin: /^(?<_1>\.{2})$/,
    captures: {1 => {name: "punctuation.definition.comment.setext"}},
    end: "not(?<=possible)",
    name: "comment.block.logical_end_of_text.setext"}],
 repository: 
  {bold: 
    {captures: 
      {1 => {name: "punctuation.definition.bold.setext"},
       2 => {name: "punctuation.definition.bold.setext"}},
     match: /(?<_1>[*]{2}).+?(?<_2>[*]{2})/,
     name: "markup.bold.setext"},
   doc_separator: 
    {captures: {1 => {name: "punctuation.definition.separator.setext"}},
     match: /\s*(?<_1>\$\$)$\n?/,
     name: "meta.separator.document.setext"},
   hotword: 
    {captures: 
      {0 => {name: "constant.other.reference.link.setext"},
       1 => {name: "punctuation.definition.reference.setext"}},
     match: /\b[-\w.]*\w(?<!_)(?<_1>_)\b/,
     name: "meta.link.reference.setext"},
   inline: 
    {patterns: 
      [{include: "#italic"},
       {include: "#bold"},
       {include: "#underline"},
       {include: "#hotword"},
       {include: "#link"},
       {include: "#doc_separator"}]},
   italic: 
    {captures: 
      {1 => {name: "punctuation.definition.italic.setext"},
       2 => {name: "punctuation.definition.italic.setext"}},
     match: /(?<_1>~)\w+(?<_2>~)/,
     name: "markup.italic.setext"},
   link: 
    {captures: 
      {1 => {name: "punctuation.definition.link.setext"},
       2 => {name: "markup.underline.link.setext"},
       3 => {name: "punctuation.definition.link.setext"}},
     comment: "Not actually part of setext, added for Tidbits.",
     match: /(?<_1><)(?<_2>(?i:mailto|https?|ftp|news):\/\/.*?)(?<_3>>)/},
   underline: 
    {captures: 
      {1 => {name: "punctuation.definition.underline.setext"},
       2 => {name: "punctuation.definition.underline.setext"},
       3 => {name: "punctuation.definition.underline.setext"},
       4 => {name: "punctuation.definition.underline.setext"}},
     match: /\b(?<_1>_)\w+(?<!_)(?<_2>_)\b|\b(?<_3>_).+(?<!_)(?<_4>_)\b/,
     name: "markup.underline.setext"}},
 scopeName: "text.setext",
 uuid: "FB227CE6-DC4C-4632-BCA3-965AE0D8E419"}
