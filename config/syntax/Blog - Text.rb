# Encoding: UTF-8

{fileTypes: ["blog.txt"],
 firstLineMatch: "^Type: Blog Post \\(Text\\)",
 keyEquivalent: "^~B",
 name: "Blog — Text",
 patterns: 
  [{captures: 
     {1 => {name: "keyword.other.blog"},
      2 => {name: "punctuation.separator.key-value.blog"},
      3 => {name: "string.unquoted.blog"}},
    match: 
     /^([Tt]itle|[Dd]ate|[Bb]asename|[Ss]lug|[Kk]eywords|[Bb]log|[Tt]ype|[Ll]ink|[Pp]ost|[Tt]ags|[Cc]omments|[Pp]ings?|[Cc]ategory|[Ss]tatus|[Ff]ormat)(:)\s*(.*)$\n?/,
    name: "meta.header.blog"},
   {match: /^([A-Za-z0-9]+):\s*(.*)$\n?/,
    name: "invalid.illegal.meta.header.blog"},
   {begin: /^(?![A-Za-z0-9]+:)/,
    end: "^(?=not)possible$",
    name: "text.plain",
    patterns: 
     [{match: /^✂-[✂-]+$\n/, name: "meta.separator.blog"},
      {include: "text.plain"}]}],
 scopeName: "text.blog",
 uuid: "B2CCDFF8-0FB3-492A-8761-D31FF0FAC448"}
