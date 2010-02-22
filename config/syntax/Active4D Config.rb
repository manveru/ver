# Encoding: UTF-8

{fileTypes: ["ini"],
 keyEquivalent: "^~A",
 name: "Active4D Config",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.comment.active4d-ini"}},
    match: /(?<_1>\/\/).*$\n?/,
    name: "comment.line.double-slash.active4d-ini"},
   {captures: {1 => {name: "punctuation.definition.comment.active4d-ini"}},
    match: /(?<_1>`).*$\n?/,
    name: "comment.line.backtick.active4d-ini"},
   {captures: {1 => {name: "punctuation.definition.comment.active4d-ini"}},
    match: /(?<_1>\\\\).*$\n?/,
    name: "comment.line.double-backslash.continuation.active4d-ini"},
   {begin: /\/\*/,
    captures: {0 => {name: "punctuation.definition.comment.active4d-ini"}},
    end: "\\*/",
    name: "comment.block.active4d-ini"},
   {begin: /"(?!"")/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.active4d-ini"}},
    end: "\"",
    endCaptures: 
     {0 => {name: "punctuation.definition.string.end.active4d-ini"}},
    name: "string.quoted.double.active4d-ini",
    patterns: [{include: "#escaped_char"}]},
   {match: /\b(?i)(?<_1>true|false|yes|no)\b/,
    name: "constant.language.boolean.active4d-ini"},
   {match: /=/, name: "keyword.operator.active4d-ini"},
   {match: 
     /(?i)(?<_1>(?<_2>\b(?<_3>use sessions|use session cookies|session var name|session timeout|session purge interval|session cookie path|session cookie name|session cookie domain|serve nonexecutables|script timeout|safe script dirs|safe doc dirs|root|refresh interval|receive timeout|platform charset|parameter mode|output encoding|output charset|max request size|log level|locale|lib extension|lib dirs|http error page|fusebox page|expires|executable extensions|error page|encrypted source|default page|content charset|client is web server|cache control|auto relate one|auto relate many|auto refresh libs|auto create vars|auto create sessions)\b)|(?<_4>\<default\>|\<web\>|\<4d volume\>|\<boot volume\>))/,
    name: "support.constant.active4d-ini"}],
 repository: 
  {escaped_char: 
    {match: /\\./, name: "constant.character.escape.active4d-ini"}},
 scopeName: "text.active4d-ini",
 uuid: "BECA5580-F845-4715-889C-134DF4BF67C2"}
