# Encoding: UTF-8

{fileTypes: ["bbcode"],
 foldingStartMarker: 
  /(?x)
        (?<_1>\[(?i:quote|code|list)\b.*?\]
        |<!--(?!.*-->)
        |\{\s*(?<_2>$|\?>\s*$|\/\/|\/\*(?<_3>.*\*\/\s*$|(?!.*?\*\/)))
        )/,
 foldingStopMarker: 
  /(?x)
        (?<_1>\[\/(?i:quote|code|list)\b.*?\]
        |^\s*-->
        |(?<_2>^|\s)\}
        )/,
 keyEquivalent: "^~B",
 name: "Bulletin Board",
 patterns: 
  [{begin: /(?<_1>\[)(?i:list)(?<_2>\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    end: "(\\[/)(?i:list)(\\])",
    patterns: 
     [{begin: /(?<_1>\[\*\])/,
       captures: 
        {0 => {name: "meta.tag.bbcode"},
         1 => {name: "punctuation.definition.tag.bbcode"}},
       contentName: "markup.list.unnumbered.bbcode",
       end: "(?=\\[\\*\\]|\\[/(?i:list)\\])",
       patterns: [{include: "$self"}]}]},
   {begin: /(?<_1>\[)(?i:list)=(?<_2>1|a)(?<_3>\])/,
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
     [{begin: /(?<_1>\[\*\])/,
       captures: 
        {0 => {name: "meta.tag.bbcode"},
         1 => {name: "punctuation.definition.tag.bbcode"}},
       contentName: "markup.list.numbered.bbcode",
       end: "(?=\\[\\*\\]|\\[/(?i:list)\\])",
       patterns: [{include: "$self"}]}]},
   {begin: /(?<_1>\[)(?i:quote)(?:=[^\]]+)?(?<_2>\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.quote.bbcode",
    end: "(\\[/)(?i:quote)(\\])",
    patterns: [{include: "$self"}]},
   {begin: /(?<_1>\[)(?i:code)(?<_2>\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.raw.block.bbcode",
    end: "(\\[/)(?i:code)(\\])"},
   {begin: /(?<_1>\[)(?i:i)(?<_2>\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.italic.bbcode",
    end: "(\\[/)(?i:i)(\\])",
    patterns: [{include: "$self"}]},
   {begin: /(?<_1>\[)(?i:b)(?<_2>\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.bold.bbcode",
    end: "(\\[/)(?i:b)(\\])",
    patterns: [{include: "$self"}]},
   {begin: /(?<_1>\[)(?i:u)(?<_2>\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.underline.bbcode",
    end: "(\\[/)(?i:u)(\\])",
    patterns: [{include: "$self"}]},
   {begin: /(?<_1>\[)(?i:strike)(?<_2>\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.other.strikethrough.bbcode",
    end: "(\\[/)(?i:strike)(\\])",
    patterns: [{include: "$self"}]},
   {begin: 
     /(?x)(?<_1>\[)(?i:color)=(?<_2>
	            (?i:(?<_3>red|green|blue|yellow
	                |white|black|pink
	                |purple|brown|grey))
                    |(?<_4>\#(?<_5>[0-9a-fA-F]{6}))
                    |(?<_6>[^\]]+))
                (?<_7>\])/,
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
     /(?x)(?<_1>\[)(?i:size)=
                 (?i:(?<_2>[0-9]{1,3})\b
                     |(?<_3>[^\]]+))
                 (?<_4>\])/,
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
   {begin: /(?<_1>\[)(?i:url)=(?<_2>[^\]]+)(?<_3>\])/,
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
   {begin: /(?<_1>\[)(?i:url)(?<_2>\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.underline.link.bbcode",
    end: "(\\[/)(?i:url)(\\])",
    name: "meta.link.inline.bbcode",
    patterns: [{match: /[\[\]]+/}]},
   {begin: /(?<_1>\[)(?i:email)(?<_2>\])/,
    captures: 
     {0 => {name: "meta.tag.bbcode"},
      1 => {name: "punctuation.definition.tag.bbcode"},
      2 => {name: "punctuation.definition.tag.bbcode"}},
    contentName: "markup.underline.link.email.bbcode",
    end: "(\\[/)(?i:email)(\\])",
    name: "meta.link.inline.bbcode",
    patterns: [{match: /[\[\]]+/}]},
   {begin: 
     /(?<_1>\[)(?i:img)(?<_2>:(?<_3>(?i:right|left|top))|(?<_4>[^\]]+))?(?<_5>\])/,
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
	(?<_1>
	(?<_2>
	(?<_3>:)
	(?<_4>mad|rolleyes|cool|eek|confused|devious|
	judge|scared|eyebrow|bigdumbgrin)
	(?<_5>:)
	)
	  | (?::\)|;\)|:D|:\(|:p|:o)
	)/,
    name: "constant.other.smiley.bbcode"}],
 scopeName: "text.bbcode",
 uuid: "AC4E0E7E-CC15-4394-A858-6C7E3C09C414"}
