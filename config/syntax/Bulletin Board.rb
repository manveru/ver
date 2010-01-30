# Encoding: UTF-8

{fileTypes: ["bbcode"],
 foldingStartMarker: 
  /(?x)
        (\[(?i:quote|code|list)\b.*?\]
        |<!--(?!.*-->)
        |\{\s*($|\?>\s*$|\/\/|\/\*(.*\*\/\s*$|(?!.*?\*\/)))
        )/,
 foldingStopMarker: 
  /(?x)
        (\[\/(?i:quote|code|list)\b.*?\]
        |^\s*-->
        |(^|\s)\}
        )/,
 keyEquivalent: "^~B",
 name: "Bulletin Board",
 patterns: 
  [{begin: /(\[)(?i:list)(\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    end: "(\\[/)(?i:list)(\\])",
    patterns: 
     [{begin: /(\[\*\])/,
       captures: 
        {0 => {name: "meta.tag.bbcode"},
         1 => {name: "punctuation.definition.tag.bbcode"}},
       contentName: "markup.list.unnumbered.bbcode",
       end: "(?=\\[\\*\\]|\\[/(?i:list)\\])",
       patterns: [{include: "$self"}]}]},
   {begin: /(\[)(?i:list)=(1|a)(\])/,
    beginCaptures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "constant.other.list-type.bbcode"},
      3 => {name: "punctuation.definition.tag.bbcode"}},
    end: "(\\[/)(?i:list)(\\])",
    endCaptures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    patterns: 
     [{begin: /(\[\*\])/,
       captures: 
        {0 => {name: "meta.tag.bbcode"},
         1 => {name: "punctuation.definition.tag.bbcode"}},
       contentName: "markup.list.numbered.bbcode",
       end: "(?=\\[\\*\\]|\\[/(?i:list)\\])",
       patterns: [{include: "$self"}]}]},
   {begin: /(\[)(?i:quote)(?:=[^\]]+)?(\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.quote.bbcode",
    end: "(\\[/)(?i:quote)(\\])",
    patterns: [{include: "$self"}]},
   {begin: /(\[)(?i:code)(\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.raw.block.bbcode",
    end: "(\\[/)(?i:code)(\\])"},
   {begin: /(\[)(?i:i)(\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.italic.bbcode",
    end: "(\\[/)(?i:i)(\\])",
    patterns: [{include: "$self"}]},
   {begin: /(\[)(?i:b)(\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.bold.bbcode",
    end: "(\\[/)(?i:b)(\\])",
    patterns: [{include: "$self"}]},
   {begin: /(\[)(?i:u)(\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.underline.bbcode",
    end: "(\\[/)(?i:u)(\\])",
    patterns: [{include: "$self"}]},
   {begin: /(\[)(?i:strike)(\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.other.strikethrough.bbcode",
    end: "(\\[/)(?i:strike)(\\])",
    patterns: [{include: "$self"}]},
   {begin: 
     /(?x)(\[)(?i:color)=(
	            (?i:(red|green|blue|yellow
	                |white|black|pink
	                |purple|brown|grey))
                    |(\#([0-9a-fA-F]{6}))
                    |([^\]]+))
                (\])/,
    beginCaptures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "constant.other.named-color.bbcode"},
      3 => {name: "constant.other.rgb-value.bbcode"},
      6 => {name: "invalid.illegal.expected-a-color.bbcode"},
      7 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.other.colored.bbcode",
    end: "(\\[/)(?i:color)(\\])",
    endCaptures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    patterns: [{include: "$self"}]},
   {begin: 
     /(?x)(\[)(?i:size)=
                 (?i:([0-9]{1,3})\b
                     |([^\]]+))
                 (\])/,
    beginCaptures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "constant.numeric.size.bbcode"},
      3 => {name: "invalid.illegal.expected-a-size.bbcode"},
      4 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.other.resized.bbcode",
    end: "(\\[/)(?i:size)(\\])",
    endCaptures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    patterns: [{include: "$self"}]},
   {begin: /(\[)(?i:url)=([^\]]+)(\])/,
    beginCaptures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "markup.underline.link.bbcode"},
      3 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "string.other.link.title.bbcode",
    end: "(\\[/)(?i:url)(\\])",
    endCaptures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    name: "meta.link.inline.bbcode",
    patterns: [{include: "$self"}]},
   {begin: /(\[)(?i:url)(\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.underline.link.bbcode",
    end: "(\\[/)(?i:url)(\\])",
    name: "meta.link.inline.bbcode",
    patterns: [{match: /[\[\]]+/}]},
   {begin: /(\[)(?i:email)(\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.underline.link.email.bbcode",
    end: "(\\[/)(?i:email)(\\])",
    name: "meta.link.inline.bbcode",
    patterns: [{match: /[\[\]]+/}]},
   {begin: /(\[)(?i:img)(:((?i:right|left|top))|([^\]]+))?(\])/,
    beginCaptures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      3 => {name: "constant.other.alignment.bbcode"},
      4 => {name: "invalid.illegal.expected-an-alignment.bbcode"},
      5 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.underline.link.image.bbcode",
    end: "(\\[/)(?i:img)(\\])",
    endCaptures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    name: "meta.link.image.bbcode",
    patterns: [{match: /[\[\]]+?/}]},
   {captures: 
     {3 => {name: "punctuation.definition.constant.bbcode"},
      5 => {name: "punctuation.definition.constant.bbcode"}},
    match: 
     /(?x)
	(
	(
	(:)
	(mad|rolleyes|cool|eek|confused|devious|
	judge|scared|eyebrow|bigdumbgrin)
	(:)
	)
	  | (?::\)|;\)|:D|:\(|:p|:o)
	)/,
    name: "constant.other.smiley.bbcode"}],
 scopeName: "text.bbcode",
 uuid: "AC4E0E7E-CC15-4394-A858-6C7E3C09C414"}
