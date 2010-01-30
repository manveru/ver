# Encoding: UTF-8

{fileTypes: ["txt"],
 keyEquivalent: "^~P",
 name: "Plain Text",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.item.text"}},
    match: /^\s*(•).*$\n?/,
    name: "meta.bullet-point.strong.text"},
   {captures: {1 => {name: "punctuation.definition.item.text"}},
    match: /^\s*(·).*$\n?/,
    name: "meta.bullet-point.light.text"},
   {captures: {1 => {name: "punctuation.definition.item.text"}},
    match: /^\s*(\*).*$\n?/,
    name: "meta.bullet-point.star.text"},
   {begin: /^([ \t]*)(?=\S)/,
    contentName: "meta.paragraph.text",
    end: "^(?!\\1(?=\\S))",
    patterns: 
     [{match: 
        /(?x)
	( (https?|s?ftp|ftps|file|smb|afp|nfs|(x-)?man|gopher|txmt):\/\/|mailto:)
	[-:@a-zA-Z0-9_.,~%+\/?=&#]+(?<![.,?:])
	/,
       name: "markup.underline.link.text"}]}],
 scopeName: "text.plain",
 uuid: "3130E4FA-B10E-11D9-9F75-000D93589AF6"}
