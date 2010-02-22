# Encoding: UTF-8

{fileTypes: ["gtd"],
 keyEquivalent: "^~G",
 name: "GTD",
 patterns: 
  [{match: /[A-Z][a-z]+(?<_1>[A-Z][a-z]*)+/, name: "markup.other.pagename"},
   {match: /^-\s{2}\S+\s/, name: "string.unquoted.gtd"},
   {match: /^<-\s\S+\s/, name: "entity.name.tag.gtd"},
   {match: /^->\s\S+\s/, name: "constant.language.gtd"},
   {match: /^\+\s{2}\S+\s/, name: "variable.language.gtd"},
   {match: /^\^\s{2}\S+\s/, name: "comment.line.gtd"},
   {match: /^\!\s{2}\S+\s/, name: "support.class.exception.gtd"}],
 scopeName: "text.html.markdown.wiki.gtd",
 uuid: "A984336E-2C65-4152-8FC0-34D2E73721DA"}
