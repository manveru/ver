# Encoding: UTF-8

{fileTypes: ["diff", "patch"],
 firstLineMatch: 
  "(?x)^\n\t\t(===\\ modified\\ file\n\t\t|==== \\s* // .+ \\s - \\s .+ \\s+ ====\n\t\t|Index:\\ \n\t\t|---\\ [^%]\n\t\t|\\*\\*\\*.*\\d{4}\\s*$\n\t\t|\\d+(,\\d+)* (a|d|c) \\d+(,\\d+)* $\n\t\t|diff\\ --git\\ \n\t\t)\n\t",
 foldingStartMarker: /^\+\+\+/,
 foldingStopMarker: /^---|^$/,
 keyEquivalent: "^~D",
 name: "Diff",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.separator.diff"}},
    match: /^(?<_1>(?<_2>\*{15})|(?<_3>={67})|(?<_4>-{3}))$\n?/,
    name: "meta.separator.diff"},
   {match: /^\d+(?<_1>,\d+)*(?<_2>a|d|c)\d+(?<_3>,\d+)*$\n?/,
    name: "meta.diff.range.normal"},
   {captures: 
     {1 => {name: "punctuation.definition.range.diff"},
      2 => {name: "meta.toc-list.line-number.diff"},
      3 => {name: "punctuation.definition.range.diff"}},
    match: /^(?<_1>@@)\s*(?<_2>.+?)\s*(?<_3>@@)(?<_4>$\n?)?/,
    name: "meta.diff.range.unified"},
   {captures: 
     {3 => {name: "punctuation.definition.range.diff"},
      4 => {name: "punctuation.definition.range.diff"},
      6 => {name: "punctuation.definition.range.diff"},
      7 => {name: "punctuation.definition.range.diff"}},
    match: 
     /^(?<_1>(?<_2>(?<_3>\-{3}) .+ (?<_4>\-{4}))|(?<_5>(?<_6>\*{3}) .+ (?<_7>\*{4})))$\n?/,
    name: "meta.diff.range.context"},
   {captures: 
     {4 => {name: "punctuation.definition.from-file.diff"},
      6 => {name: "punctuation.definition.from-file.diff"},
      7 => {name: "punctuation.definition.from-file.diff"}},
    match: 
     /(?<_1>^(?<_2>(?<_3>(?<_4>-{3}) .+)|(?<_5>(?<_6>\*{3}) .+))$\n?|^(?<_7>={4}) .+(?= - ))/,
    name: "meta.diff.header.from-file"},
   {captures: 
     {2 => {name: "punctuation.definition.to-file.diff"},
      3 => {name: "punctuation.definition.to-file.diff"},
      4 => {name: "punctuation.definition.to-file.diff"}},
    match: /(?<_1>^(?<_2>\+{3}) .+$\n?| (?<_3>-) .* (?<_4>={4})$\n?)/,
    name: "meta.diff.header.to-file"},
   {captures: 
     {3 => {name: "punctuation.definition.inserted.diff"},
      6 => {name: "punctuation.definition.inserted.diff"}},
    match: /^(?<_1>(?<_2>(?<_3>>)(?<_4> .*)?)|(?<_5>(?<_6>\+).*))$\n?/,
    name: "markup.inserted.diff"},
   {captures: {1 => {name: "punctuation.definition.inserted.diff"}},
    match: /^(?<_1>!).*$\n?/,
    name: "markup.changed.diff"},
   {captures: 
     {3 => {name: "punctuation.definition.inserted.diff"},
      6 => {name: "punctuation.definition.inserted.diff"}},
    match: /^(?<_1>(?<_2>(?<_3><)(?<_4> .*)?)|(?<_5>(?<_6>-).*))$\n?/,
    name: "markup.deleted.diff"},
   {captures: 
     {1 => {name: "punctuation.separator.key-value.diff"},
      2 => {name: "meta.toc-list.file-name.diff"}},
    match: /^Index(?<_1>:) (?<_2>.+)$\n?/,
    name: "meta.diff.index"}],
 scopeName: "source.diff",
 uuid: "7E848FF4-708E-11D9-97B4-0011242E4184"}
