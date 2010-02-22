# Encoding: UTF-8

{fileTypes: ["mail"],
 firstLineMatch: "^From: .*(?=\\w+@[\\w-]+\\.\\w+)",
 keyEquivalent: "^~M",
 name: "Mail",
 patterns: 
  [{begin: /(?<_1>(?i:subject))(?<_2>:)\s*/,
    beginCaptures: 
     {1 => {name: "keyword.other.mail"},
      2 => {name: "punctuation.separator.key-value.mail"}},
    contentName: "entity.name.section.mail",
    end: "^(?![ \\t\\v])",
    name: "meta.header.mail"},
   {begin: /(?<_1>[\x21-\x39\x3B-\x7E]+)(?<_2>:)\s*/,
    beginCaptures: 
     {1 => {name: "keyword.other.mail"},
      2 => {name: "punctuation.separator.key-value.mail"}},
    end: "^(?![ \\t\\v])",
    name: "meta.header.mail",
    patterns: 
     [{include: "#string"},
      {include: "#comment"},
      {include: "#reference"},
      {include: "#atom"}]},
   {begin: /^(?![A-Za-z0-9]+:)/,
    end: "^(?=not)possible$",
    name: "text.html.markdown",
    patterns: 
     [{match: /^-- $\n/, name: "meta.separator.signature.mail"},
      {include: "text.html.markdown"}]}],
 repository: 
  {any: 
    {patterns: 
      [{include: "#group"},
       {include: "#reference"},
       {include: "#string"},
       {include: "#comment"},
       {include: "#domain_literal"},
       {include: "#atom"}]},
   atom: 
    {match: /[^ \t\v\n(?<_1>)<>@,;:\\".\[\]]+/,
     name: "string.unquoted.atom.mail"},
   comment: 
    {begin: /\(/,
     captures: {0 => {name: "punctuation.definition.comment.mail"}},
     end: "\\)",
     name: "comment.line.parentheses.mail",
     patterns: [{include: "#quote_pair"}, {include: "#comment"}]},
   domain_literal: 
    {begin: /\[/,
     end: "\\]",
     name: "meta.domain-literal.mail",
     patterns: 
      [{include: "#quote_pair"},
       {include: "#group"},
       {include: "#reference"},
       {include: "#string"},
       {include: "#comment"},
       {include: "#atom"}]},
   encoded_text: 
    {captures: 
      {1 => {name: "constant.other.charset.mail"},
       2 => {name: "constant.other.encoding.mail"}},
     match: /=\?(?<_1>.*?)(?:\*[^?]+)?\?(?<_2>[QB])\?(?<_3>.*?)\?=/,
     name: "meta.encoded-text.mail"},
   group: 
    {begin: /:(?=.*;)/,
     comment: 
      "this is to group addresses, RFC822 says that these “must occur in  matched pairs,” but e.g. the date header uses : as a time separator.",
     end: ";",
     name: "meta.group.mail",
     patterns: 
      [{include: "#reference"},
       {include: "#string"},
       {include: "#comment"},
       {include: "#domain_literal"},
       {include: "#atom"}]},
   quote_pair: {match: /\\./, name: "constant.other.escape.mail"},
   reference: 
    {begin: /</,
     captures: {0 => {name: "punctuation.definition.constant.mail"}},
     end: ">",
     name: "constant.other.reference.mail",
     patterns: 
      [{include: "#string"},
       {include: "#comment"},
       {include: "#domain_literal"},
       {include: "#atom"}]},
   string: 
    {begin: /"/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.mail"}},
     end: "\"",
     endCaptures: {0 => {name: "punctuation.definition.string.end.mail"}},
     name: "string.quoted.double.mail",
     patterns: [{include: "#quote_pair"}, {include: "#encoded_text"}]}},
 scopeName: "text.mail.markdown",
 uuid: "15615A0C-37B0-4B3F-9105-53ED536AFBB4"}
