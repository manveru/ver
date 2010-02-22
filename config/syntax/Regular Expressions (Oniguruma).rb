# Encoding: UTF-8

{comment: 
  "Matches Oniguruma's Ruby regexp syntax (TextMate uses Oniguruma in Ruby mode).",
 fileTypes: ["re"],
 foldingStartMarker: /(?<_1>\/\*|\{|\()/,
 foldingStopMarker: /(?<_1>\*\/|\}|\))/,
 name: "Regular Expressions (Oniguruma)",
 patterns: 
  [{match: /\\[bBAZzG]|\^|\$/, name: "keyword.control.anchor.regexp"},
   {match: /\\(?<_1>[0-7]{3}|\\x(?<_2>\h\h|\{\h{,8}\}))/,
    name: "constant.character.numeric.regexp"},
   {match: /\\[1-9]\d*/, name: "keyword.other.back-reference.regexp"},
   {captures: 
     {1 => {name: "keyword.other.back-reference.named.regexp"},
      2 => {name: "entity.name.section.back-reference"},
      3 => {name: "keyword.other.back-reference.named.regexp"}},
    match: /(?<_1>\\k\<)(?<_2>[a-z]\w*)(?<_3>\>)/,
    name: "keyword.other.back-reference.named.regexp"},
   {match: 
     /\[\:(?<_1>\^)?(?<_2>alnum|alpha|ascii|blank|cntrl|x?digit|graph|lower|print|punct|space|upper)\]/,
    name: "constant.other.character-class.posix.regexp"},
   {match: /[?+*][?+]?|\{(?<_1>\d+,\d+|\d+,|,\d+|\d+)\}\??/,
    name: "keyword.operator.quantifier.regexp"},
   {match: /\|/, name: "keyword.operator.or.regexp"},
   {begin: /\(\?\#/, end: "\\)", name: "comment.block.regexp"},
   {comment: 
     "We are restrictive in what we allow to go after the comment character to avoid false positives, since the availability of comments depend on regexp flags.",
    match: /(?<=^|\s)#\s[[a-zA-Z0-9,. \t?!-:][^\x00-\x7F]]*$/,
    name: "comment.line.number-sign.regexp"},
   {match: /\(\?[imx-]+\)/, name: "keyword.other.option-toggle.regexp"},
   {begin: /(?<_1>\()(?<_2>(?<_3>\?=)|(?<_4>\?!)|(?<_5>\?<=)|(?<_6>\?<!))/,
    beginCaptures: 
     {1 => {name: "punctuation.definition.group.regexp"},
      3 => {name: "meta.assertion.look-ahead.regexp"},
      4 => {name: "meta.assertion.negative-look-ahead.regexp"},
      5 => {name: "meta.assertion.look-behind.regexp"},
      6 => {name: "meta.assertion.negative-look-behind.regexp"}},
    end: "(\\))",
    endCaptures: {1 => {name: "punctuation.definition.group.regexp"}},
    name: "meta.group.assertion.regexp",
    patterns: [{include: "$self"}]},
   {begin: 
     /(?<_1>\()(?<_2>(?<_3>\?(?<_4>>|[imx-]*:))|(?<_5>\?<)(?<_6>[a-z]\w*)(?<_7>>))?/,
    beginCaptures: 
     {1 => {name: "punctuation.definition.group.regexp"},
      3 => {name: "keyword.other.group-options.regexp"},
      5 => {name: "keyword.other.group-options.regexp"},
      6 => {name: "entity.name.section.group.regexp"},
      7 => {name: "keyword.other.group-options.regexp"}},
    end: "(\\))",
    endCaptures: {1 => {name: "punctuation.definition.group.regexp"}},
    name: "meta.group.regexp",
    patterns: [{include: "$self"}]},
   {include: "#character-class"}],
 repository: 
  {:"character-class" => 
    {patterns: 
      [{match: /\\[wWsSdDhH]|\./,
        name: "constant.character.character-class.regexp"},
       {match: /\\./, name: "constant.character.escape.backslash.regexp"},
       {begin: /(?<_1>\[)(?<_2>\^)?/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.character-class.regexp"},
          2 => {name: "keyword.operator.negation.regexp"}},
        end: "(\\])",
        endCaptures: 
         {1 => {name: "punctuation.definition.character-class.regexp"}},
        name: "constant.other.character-class.set.regexp",
        patterns: 
         [{include: "#character-class"},
          {captures: 
            {2 => {name: "constant.character.escape.backslash.regexp"},
             4 => {name: "constant.character.escape.backslash.regexp"}},
           match: /(?<_1>.|(?<_2>\\.))\-(?<_3>[^\]]|(?<_4>\\.))/,
           name: "constant.other.character-class.range.regexp"},
          {match: /&&/, name: "keyword.operator.intersection.regexp"}]}]}},
 scopeName: "source.regexp.oniguruma",
 uuid: "D609BF3F-BEDB-41AE-BA6F-903CC77A7BB3"}
