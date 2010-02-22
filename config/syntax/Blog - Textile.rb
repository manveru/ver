# Encoding: UTF-8

{fileTypes: ["blog.textile"],
 firstLineMatch: "^Type: Blog Post \\(Textile\\)",
 keyEquivalent: "^~B",
 name: "Blog — Textile",
 patterns: 
  [{captures: 
     {1 => {name: "keyword.other.blog"},
      2 => {name: "punctuation.separator.key-value.blog"},
      3 => {name: "string.unquoted.blog"}},
    match: 
     /^(?<_1>[Tt]itle|[Dd]ate|[Bb]asename|[Ss]lug|[Kk]eywords|[Bb]log|[Tt]ype|[Ll]ink|[Pp]ost|[Tt]ags|[Cc]omments|[Pp]ings?|[Cc]ategory|[Ss]tatus|[Ff]ormat)(?<_2>:)\s*(?<_3>.*)$\n?/,
    name: "meta.header.blog"},
   {match: /^(?<_1>[A-Za-z0-9]+):\s*(?<_2>.*)$\n?/,
    name: "invalid.illegal.meta.header.blog"},
   {begin: /^(?![A-Za-z0-9]+:)/,
    end: "^(?=not)possible$",
    name: "text.html.textile",
    patterns: 
     [{match: /^✂-[✂-]+$\n/, name: "meta.separator.blog"},
      {include: "text.html.textile"}]}],
 scopeName: "text.blog.textile",
 uuid: "32E65853-CDBD-401A-ADBE-F94F195249BE"}
