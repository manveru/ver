# Encoding: UTF-8

{fileTypes: ["a4d", "a4p"],
 foldingStartMarker: 
  /(?x)
	(?<_1><(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)\b.*?>
	|<!--(?!.*-->)
	|^\s*<%(?!.*%>)
	|(?<_2>^\s*|<%\s*)(?i:if|while|for\ each|for|case\ of|repeat|method|save\ output)\b
	)/,
 foldingStopMarker: 
  /(?x)
	(?<_1><\/(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)>
	|^(?!.*?<!--).*?-->
	|^\s*%>
	|(?<_2>^\s*|<%\s*)(?i:end\ (?<_3>if|while|for\ each|for|case|method|save\ output)|until)\b
	)/,
 keyEquivalent: "^~A",
 name: "HTML (Active4D)",
 patterns: 
  [{begin: /(?<_1><)(?<_2>[a-zA-Z0-9:]+)(?=[^>]*><\/\k<_2>>)/,
    beginCaptures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.html"}},
    end: "(>(<)/)(\\2)(>)",
    endCaptures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "meta.scope.between-tag-pair.html"},
      3 => {name: "entity.name.tag.html"},
      4 => {name: "punctuation.definition.tag.html"}},
    name: "meta.tag.any.html",
    patterns: [{include: "#tag-stuff"}]},
   {begin: /(?<_1><\?)(?<_2>xml)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.xml.html"},
      2 => {name: "entity.name.tag.xml.html"}},
    end: "(\\?>)",
    name: "meta.tag.preprocessor.xml.html",
    patterns: 
     [{include: "#tag-generic-attribute"},
      {include: "#string-double-quoted"},
      {include: "#string-single-quoted"}]},
   {begin: /<!--/,
    captures: {0 => {name: "punctuation.definition.comment.html"}},
    end: "-->",
    name: "comment.block.html",
    patterns: 
     [{match: /--/, name: "invalid.illegal.bad-comments-or-CDATA.html"}]},
   {begin: /<!/,
    captures: {0 => {name: "punctuation.definition.tag.html"}},
    end: ">",
    name: "meta.tag.sgml.html",
    patterns: 
     [{begin: /(?<_1>DOCTYPE)/,
       captures: {1 => {name: "entity.name.tag.doctype.html"}},
       end: "(?=>)",
       name: "meta.tag.sgml.doctype.html",
       patterns: 
        [{match: /"[^">]*"/,
          name: "string.quoted.double.doctype.identifiers-and-DTDs.html"}]},
      {begin: /\[CDATA\[/,
       end: "]](?=>)",
       name: "constant.other.inline-data.html"},
      {match: /(?<_1>\s*)(?!--|>)\S(?<_2>\s*)/,
       name: "invalid.illegal.bad-comments-or-CDATA.html"}]},
   {begin: /<%(?=%>)/,
    beginCaptures: {0 => {name: "punctuation.section.embedded.active4d"}},
    end: "(%)>",
    endCaptures: 
     {0 => {name: "punctuation.section.embedded.active4d"},
      1 => {name: "meta.scope.between-tag-pair.html"}},
    name: "meta.tag.processor.html",
    patterns: [{include: "#embedded-code"}]},
   {include: "#embedded-code"},
   {begin: /(?:^\s+)?(?<_1><)(?<_2>(?i:style))\b(?![^>]*\/>)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.style.html"},
      3 => {name: "punctuation.definition.tag.html"}},
    end: "(</)((?i:style))(>)(?:\\s*\\n)?",
    name: "source.css.embedded.html",
    patterns: 
     [{include: "#tag-stuff"},
      {begin: /(?<_1>>)/,
       beginCaptures: {1 => {name: "punctuation.definition.tag.html"}},
       end: "(?=</(?i:style))",
       patterns: [{include: "#embedded-code"}, {include: "source.css"}]}]},
   {begin: /(?:^\s+)?(?<_1><)(?<_2>(?i:script))\b(?![^>]*\/>)/,
    beginCaptures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.script.html"}},
    end: "(?<=</(script|SCRIPT))(>)(?:\\s*\\n)?",
    endCaptures: 
     {1 => {name: "entity.name.tag.script.html"},
      2 => {name: "punctuation.definition.tag.html"}},
    name: "source.js.embedded.html",
    patterns: 
     [{include: "#tag-stuff"},
      {begin: /(?<!<\/(?:script|SCRIPT))(?<_1>>)/,
       captures: {1 => {name: "punctuation.definition.tag.html"}},
       end: "(</)((?i:script))",
       patterns: [{include: "#embedded-js"}, {include: "source.js"}]}]},
   {begin: /(?<_1><\/?)(?<_2>(?i:body|head|html)\b)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.structure.any.html"}},
    end: "(>)",
    name: "meta.tag.structure.any.html",
    patterns: [{include: "#tag-stuff"}]},
   {begin: 
     /(?<_1><\/?)(?<_2>(?i:address|blockquote|dd|div|dl|dt|fieldset|form|frame|frameset|h1|h2|h3|h4|h5|h6|iframe|noframes|object|ol|p|ul|applet|center|dir|hr|menu|pre)\b)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.block.any.html"}},
    end: "(>)",
    name: "meta.tag.block.any.html",
    patterns: [{include: "#tag-stuff"}]},
   {begin: 
     /(?<_1><\/?)(?<_2>(?i:a|abbr|acronym|area|b|base|basefont|bdo|big|br|button|caption|cite|code|col|colgroup|del|dfn|em|font|head|html|i|img|input|ins|isindex|kbd|label|legend|li|link|map|meta|noscript|optgroup|option|param|q|s|samp|script|select|small|span|strike|strong|style|sub|sup|table|tbody|td|textarea|tfoot|th|thead|title|tr|tt|u|var)\b)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.inline.any.html"}},
    end: "(>)",
    name: "meta.tag.inline.any.html",
    patterns: [{include: "#tag-stuff"}]},
   {begin: /(?<_1><\/?)(?<_2>[a-zA-Z0-9:]+)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.other.html"}},
    end: "(>)",
    name: "meta.tag.other.html",
    patterns: [{include: "#tag-stuff"}]},
   {include: "#entities"},
   {match: /<>/, name: "invalid.illegal.incomplete.html"},
   {match: /<(?=\W)|>/, name: "invalid.illegal.bad-angle-bracket.html"}],
 repository: 
  {:"embedded-code" => 
    {begin: /<%/,
     beginCaptures: {0 => {name: "punctuation.section.embedded.active4d"}},
     end: "%>",
     endCaptures: {0 => {name: "punctuation.section.embedded.active4d"}},
     name: "source.active4d.embedded.html",
     patterns: [{include: "source.active4d"}]},
   :"embedded-js" => 
    {patterns: 
      [{include: "#string-double-quoted-js"},
       {include: "#string-single-quoted-js"},
       {include: "#embedded-code"}]},
   entities: 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.entity.html"},
          3 => {name: "punctuation.terminator.entity.html"}},
        match: /(?<_1>&)(?<_2>[a-zA-Z0-9]+|#[0-9]+|#x[0-9a-fA-F]+)(?<_3>;)/,
        name: "constant.character.entity.html"},
       {match: /&/, name: "invalid.illegal.bad-ampersand.html"}]},
   :"string-double-quoted" => 
    {begin: /"/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.html"}},
     end: "\"",
     endCaptures: {0 => {name: "punctuation.definition.string.end.html"}},
     name: "string.quoted.double.html",
     patterns: [{include: "#embedded-code"}, {include: "#entities"}]},
   :"string-double-quoted-js" => 
    {begin: /"/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.js"}},
     end: "\"",
     endCaptures: {0 => {name: "punctuation.definition.string.end.js"}},
     name: "string.quoted.double.js",
     patterns: [{include: "#embedded-code"}]},
   :"string-single-quoted" => 
    {begin: /'/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.html"}},
     end: "'",
     endCaptures: {0 => {name: "punctuation.definition.string.end.html"}},
     name: "string.quoted.single.html",
     patterns: [{include: "#embedded-code"}, {include: "#entities"}]},
   :"string-single-quoted-js" => 
    {begin: /'/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.js"}},
     end: "'",
     endCaptures: {0 => {name: "punctuation.definition.string.end.js"}},
     name: "string.quoted.single.js",
     patterns: [{include: "#embedded-code"}]},
   :"tag-generic-attribute" => 
    {match: /\b(?<_1>[a-zA-Z:-]+)/, name: "entity.other.attribute-name.html"},
   :"tag-id-attribute" => 
    {begin: /\b(?<_1>id)\b\s*(?<_2>=)/,
     captures: 
      {1 => {name: "entity.other.attribute-name.id.html"},
       2 => {name: "punctuation.separator.key-value.html"}},
     end: "(?<='|\")",
     name: "meta.attribute-with-value.id.html",
     patterns: 
      [{begin: /"/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.html"}},
        contentName: "meta.toc-list.id.html",
        end: "\"",
        endCaptures: {0 => {name: "punctuation.definition.string.end.html"}},
        name: "string.quoted.double.html",
        patterns: [{include: "#embedded-code"}, {include: "#entities"}]},
       {begin: /'/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.html"}},
        contentName: "meta.toc-list.id.html",
        end: "'",
        endCaptures: {0 => {name: "punctuation.definition.string.end.html"}},
        name: "string.quoted.single.html",
        patterns: [{include: "#embedded-code"}, {include: "#entities"}]}]},
   :"tag-stuff" => 
    {patterns: 
      [{include: "#tag-id-attribute"},
       {include: "#tag-generic-attribute"},
       {include: "#string-double-quoted"},
       {include: "#string-single-quoted"},
       {include: "#embedded-code"}]}},
 scopeName: "text.html.strict.active4d",
 uuid: "E666209C-4477-4D83-8B49-9463DFBACD9F"}
