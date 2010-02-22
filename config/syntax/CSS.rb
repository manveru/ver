# Encoding: UTF-8

{comment: "",
 fileTypes: ["css", "css.erb"],
 foldingStartMarker: /\/\*\*(?!\*)|\{\s*(?<_1>$|\/\*(?!.*?\*\/.*\S))/,
 foldingStopMarker: /(?<!\*)\*\*\/|^\s*\}/,
 keyEquivalent: "^~C",
 name: "CSS",
 patterns: 
  [{begin: /^(?=\s*[:.*#a-zA-Z])/,
    end: "(?=\\{)",
    name: "meta.selector.css",
    patterns: 
     [{include: "#comment-block"},
      {match: 
        /\b(?<_1>a|abbr|acronym|address|area|b|base|big|blockquote|body|br|button|caption|cite|code|col|colgroup|dd|del|dfn|div|dl|dt|em|fieldset|form|frame|frameset|(?<_2>h[1-6])|head|hr|html|i|iframe|img|input|ins|kbd|label|legend|li|link|map|meta|noframes|noscript|object|ol|optgroup|option|p|param|pre|q|samp|script|select|small|span|strike|strong|style|sub|sup|table|tbody|td|textarea|tfoot|th|thead|title|tr|tt|ul|var)\b/,
       name: "entity.name.tag.css"},
      {captures: {1 => {name: "punctuation.definition.entity.css"}},
       match: /(?<_1>\.)[a-zA-Z0-9_-]+/,
       name: "entity.other.attribute-name.class.css"},
      {captures: {1 => {name: "punctuation.definition.entity.css"}},
       match: /(?<_1>#)[a-zA-Z][a-zA-Z0-9_-]*/,
       name: "entity.other.attribute-name.id.css"},
      {match: /\*/, name: "entity.name.tag.wildcard.css"},
      {captures: {1 => {name: "punctuation.definition.entity.css"}},
       match: 
        /(?<_1>:+)\b(?<_2>after|before|first-child|first-letter|first-line|selection)\b/,
       name: "entity.other.attribute-name.pseudo-element.css"},
      {captures: {1 => {name: "punctuation.definition.entity.css"}},
       match: /(?<_1>:)\b(?<_2>active|hover|link|visited|focus)\b/,
       name: "entity.other.attribute-name.pseudo-class.css"},
      {captures: 
        {1 => {name: "punctuation.definition.entity.css"},
         2 => {name: "entity.other.attribute-name.attribute.css"},
         3 => {name: "punctuation.separator.operator.css"},
         4 => {name: "string.unquoted.attribute-value.css"},
         5 => {name: "string.quoted.double.attribute-value.css"},
         6 => {name: "punctuation.definition.string.begin.css"},
         7 => {name: "punctuation.definition.string.end.css"}},
       match: 
        /(?i)(?<_1>\[)\s*(?<_2>-?[_a-z\\[[:^ascii:]]][_a-z0-9\-\\[[:^ascii:]]]*)(?:\s*(?<_3>[~|^$*]?=)\s*(?:(?<_4>-?[_a-z\\[[:^ascii:]]][_a-z0-9\-\\[[:^ascii:]]]*)|(?<_5>(?>(?<_6>['"])(?:[^\\]|\\.)*?(?<_7>\k<_6>)))))?\s*(?<_8>\])/,
       name: "meta.attribute-selector.css"}]},
   {include: "#comment-block"},
   {begin: /^\s*(?<_1>(?<_2>@)import\b)/,
    captures: 
     {1 => {name: "keyword.control.at-rule.import.css"},
      2 => {name: "punctuation.definition.keyword.css"}},
    end: "\\s*((?=;|\\}))",
    name: "meta.at-rule.import.css",
    patterns: 
     [{include: "#string-double"},
      {begin: /(?<_1>url)\s*(?<_2>\()\s*/,
       beginCaptures: 
        {1 => {name: "support.function.url.css"},
         2 => {name: "punctuation.section.function.css"}},
       end: "\\s*(\\))\\s*",
       endCaptures: {1 => {name: "punctuation.section.function.css"}},
       patterns: 
        [{match: /[^'") \t]+/, name: "variable.parameter.url.css"},
         {include: "#string-single"},
         {include: "#string-double"}]}]},
   {begin: 
     /^\s*(?<_1>(?<_2>@)media)\s+(?<_3>(?<_4>(?<_5>all|aural|braille|embossed|handheld|print|projection|screen|tty|tv)\s*,?\s*)+)\s*{/,
    captures: 
     {1 => {name: "keyword.control.at-rule.media.css"},
      2 => {name: "punctuation.definition.keyword.css"},
      3 => {name: "support.constant.media.css"}},
    end: "\\s*((?=;|\\}))",
    name: "meta.at-rule.media.css",
    patterns: [{include: "$self"}]},
   {begin: /\{/,
    captures: {0 => {name: "punctuation.section.property-list.css"}},
    end: "\\}",
    name: "meta.property-list.css",
    patterns: 
     [{include: "#comment-block"},
      {begin: /(?<![-a-z])(?=[-a-z])/,
       end: "$|(?![-a-z])",
       name: "meta.property-name.css",
       patterns: 
        [{match: 
           /\b(?<_1>azimuth|background-attachment|background-color|background-image|background-position|background-repeat|background|border-bottom-color|border-bottom-style|border-bottom-width|border-bottom|border-collapse|border-color|border-left-color|border-left-style|border-left-width|border-left|border-right-color|border-right-style|border-right-width|border-right|border-spacing|border-style|border-top-color|border-top-style|border-top-width|border-top|border-width|border|bottom|caption-side|clear|clip|color|content|counter-increment|counter-reset|cue-after|cue-before|cue|cursor|direction|display|elevation|empty-cells|float|font-family|font-size-adjust|font-size|font-stretch|font-style|font-variant|font-weight|font|height|left|letter-spacing|line-height|list-style-image|list-style-position|list-style-type|list-style|margin-bottom|margin-left|margin-right|margin-top|marker-offset|margin|marks|max-height|max-width|min-height|min-width|-moz-border-radius|opacity|orphans|outline-color|outline-style|outline-width|outline|overflow(?<_2>-[xy])?|padding-bottom|padding-left|padding-right|padding-top|padding|page-break-after|page-break-before|page-break-inside|page|pause-after|pause-before|pause|pitch-range|pitch|play-during|position|quotes|richness|right|size|speak-header|speak-numeral|speak-punctuation|speech-rate|speak|stress|table-layout|text-align|text-decoration|text-indent|text-shadow|text-transform|top|unicode-bidi|vertical-align|visibility|voice-family|volume|white-space|widows|width|word-spacing|z-index)\b/,
          name: "support.type.property-name.css"}]},
      {begin: /(?<_1>:)\s*/,
       beginCaptures: {1 => {name: "punctuation.separator.key-value.css"}},
       end: "\\s*(;|(?=\\}))",
       endCaptures: {1 => {name: "punctuation.terminator.rule.css"}},
       name: "meta.property-value.css",
       patterns: 
        [{match: 
           /\b(?<_1>absolute|all-scroll|always|armenian|auto|baseline|below|bidi-override|block|bold|bolder|both|bottom|break-all|break-word|capitalize|center|char|circle|cjk-ideographic|col-resize|collapse|crosshair|dashed|decimal-leading-zero|decimal|default|disabled|disc|distribute-all-lines|distribute-letter|distribute-space|distribute|dotted|double|e-resize|ellipsis|fixed|georgian|groove|hand|hebrew|help|hidden|hiragana-iroha|hiragana|horizontal|ideograph-alpha|ideograph-numeric|ideograph-parenthesis|ideograph-space|inactive|inherit|inline-block|inline|inset|inside|inter-ideograph|inter-word|italic|justify|katakana-iroha|katakana|keep-all|left|lighter|line-edge|line-through|line|list-item|loose|lower-alpha|lower-greek|lower-latin|lower-roman|lowercase|lr-tb|ltr|medium|middle|move|n-resize|ne-resize|newspaper|no-drop|no-repeat|nw-resize|none|normal|not-allowed|nowrap|oblique|outset|outside|overline|pointer|progress|relative|repeat-x|repeat-y|repeat|right|ridge|row-resize|rtl|s-resize|scroll|se-resize|separate|small-caps|solid|square|static|strict|super|sw-resize|table-footer-group|table-header-group|tb-rl|text-bottom|text-top|text|thick|thin|top|transparent|underline|upper-alpha|upper-latin|upper-roman|uppercase|vertical-ideographic|vertical-text|visible|w-resize|wait|whitespace|zero)\b/,
          name: "support.constant.property-value.css"},
         {match: 
           /(?<_1>\b(?i:arial|century|comic|courier|garamond|georgia|helvetica|impact|lucida|symbol|system|tahoma|times|trebuchet|utopia|verdana|webdings|sans-serif|serif|monospace)\b)/,
          name: "support.constant.font-name.css"},
         {comment: "http://www.w3.org/TR/CSS21/syndata.html#value-def-color",
          match: 
           /\b(?<_1>aqua|black|blue|fuchsia|gray|green|lime|maroon|navy|olive|orange|purple|red|silver|teal|white|yellow)\b/,
          name: "support.constant.color.w3c-standard-color-name.css"},
         {comment: 
           "These colours are mostly recognised but will not validate. ref: http://www.w3schools.com/css/css_colornames.asp",
          match: 
           /\b(?<_1>aliceblue|antiquewhite|aquamarine|azure|beige|bisque|blanchedalmond|blueviolet|brown|burlywood|cadetblue|chartreuse|chocolate|coral|cornflowerblue|cornsilk|crimson|cyan|darkblue|darkcyan|darkgoldenrod|darkgray|darkgreen|darkgrey|darkkhaki|darkmagenta|darkolivegreen|darkorange|darkorchid|darkred|darksalmon|darkseagreen|darkslateblue|darkslategray|darkslategrey|darkturquoise|darkviolet|deeppink|deepskyblue|dimgray|dimgrey|dodgerblue|firebrick|floralwhite|forestgreen|gainsboro|ghostwhite|gold|goldenrod|greenyellow|grey|honeydew|hotpink|indianred|indigo|ivory|khaki|lavender|lavenderblush|lawngreen|lemonchiffon|lightblue|lightcoral|lightcyan|lightgoldenrodyellow|lightgray|lightgreen|lightgrey|lightpink|lightsalmon|lightseagreen|lightskyblue|lightslategray|lightslategrey|lightsteelblue|lightyellow|limegreen|linen|magenta|mediumaquamarine|mediumblue|mediumorchid|mediumpurple|mediumseagreen|mediumslateblue|mediumspringgreen|mediumturquoise|mediumvioletred|midnightblue|mintcream|mistyrose|moccasin|navajowhite|oldlace|olivedrab|orangered|orchid|palegoldenrod|palegreen|paleturquoise|palevioletred|papayawhip|peachpuff|peru|pink|plum|powderblue|rosybrown|royalblue|saddlebrown|salmon|sandybrown|seagreen|seashell|sienna|skyblue|slateblue|slategray|slategrey|snow|springgreen|steelblue|tan|thistle|tomato|turquoise|violet|wheat|whitesmoke|yellowgreen)\b/,
          name: "invalid.deprecated.color.w3c-non-standard-color-name.css"},
         {match: /(?<_1>-|\+)?\s*[0-9]+(?<_2>\.[0-9]+)?/,
          name: "constant.numeric.css"},
         {match: /(?<=[\d])(?<_1>px|pt|cm|mm|in|em|ex|pc)\b|%/,
          name: "keyword.other.unit.css"},
         {captures: {1 => {name: "punctuation.definition.constant.css"}},
          match: /(?<_1>#)(?<_2>[0-9a-fA-F]{3}|[0-9a-fA-F]{6})\b/,
          name: "constant.other.color.rgb-value.css"},
         {include: "#string-double"},
         {include: "#string-single"},
         {begin: /(?<_1>rgb|url|attr|counter|counters)\s*(?<_2>\()/,
          beginCaptures: 
           {1 => {name: "support.function.misc.css"},
            2 => {name: "punctuation.section.function.css"}},
          end: "(\\))",
          endCaptures: {1 => {name: "punctuation.section.function.css"}},
          patterns: 
           [{include: "#string-single"},
            {include: "#string-double"},
            {match: 
              /(?<_1>\b0*(?<_2>(?<_3>1?[0-9]{1,2})|(?<_4>2(?<_5>[0-4][0-9]|5[0-5])))\s*,\s*)(?<_6>0*(?<_7>(?<_8>1?[0-9]{1,2})|(?<_9>2(?<_10>[0-4][0-9]|5[0-5])))\s*,\s*)(?<_11>0*(?<_12>(?<_13>1?[0-9]{1,2})|(?<_14>2(?<_15>[0-4][0-9]|5[0-5])))\b)/,
             name: "constant.other.color.rgb-value.css"},
            {match: 
              /\b(?<_1>[0-9]{1,2}|100)\s*%,\s*(?<_2>[0-9]{1,2}|100)\s*%,\s*(?<_3>[0-9]{1,2}|100)\s*%/,
             name: "constant.other.color.rgb-percentage.css"},
            {match: /[^'") \t]+/, name: "variable.parameter.misc.css"}]},
         {match: /\!\s*important/, name: "keyword.other.important.css"}]}]}],
 repository: 
  {:"comment-block" => 
    {begin: /\/\*/,
     captures: {0 => {name: "punctuation.definition.comment.css"}},
     end: "\\*/",
     name: "comment.block.css"},
   :"string-double" => 
    {begin: /"/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.css"}},
     end: "\"",
     endCaptures: {0 => {name: "punctuation.definition.string.end.css"}},
     name: "string.quoted.double.css",
     patterns: [{match: /\\./, name: "constant.character.escape.css"}]},
   :"string-single" => 
    {begin: /'/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.css"}},
     end: "'",
     endCaptures: {0 => {name: "punctuation.definition.string.end.css"}},
     name: "string.quoted.single.css",
     patterns: [{match: /\\./, name: "constant.character.escape.css"}]}},
 scopeName: "source.css",
 uuid: "69AA0917-B7BB-11D9-A7E2-000D93C8BE28"}
