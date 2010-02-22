# Encoding: UTF-8

{fileTypes: 
  ["html",
   "htm",
   "shtml",
   "xhtml",
   "phtml",
   "php",
   "inc",
   "tmpl",
   "tpl",
   "ctp"],
 firstLineMatch: "<!DOCTYPE|<(?i:html)|<\\?(?i:php)",
 foldingStartMarker: 
  /(?x)
	(?<_1><(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|li|form|dl)\b.*?>
	|<!--(?!.*--\s*>)
	|^<!--\ \#tminclude\ (?>.*?-->)$
	|<\?(?:php)?.*\b(?<_2>if|for(?<_3>each)?|while)\b.+:
	|\{\{?(?<_4>if|foreach|capture|literal|foreach|php|section|strip)
	|\{\s*(?<_5>$|\?>\s*$|\/\/|\/\*(?<_6>.*\*\/\s*$|(?!.*?\*\/)))
	)/,
 foldingStopMarker: 
  /(?x)
	(?<_1><\/(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|li|form|dl)>
	|^(?!.*?<!--).*?--\s*>
	|^<!--\ end\ tminclude\ -->$
	|<\?(?:php)?.*\bend(?<_2>if|for(?<_3>each)?|while)\b
	|\{\{?\/(?<_4>if|foreach|capture|literal|foreach|php|section|strip)
	|^[^{]*\}
	)/,
 keyEquivalent: "^~H",
 name: "HTML",
 patterns: 
  [{begin: /(?<_1><)(?<_2>[a-zA-Z0-9:]++)(?=[^>]*><\/\k<_2>>)/,
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
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.xml.html"}},
    end: "(\\?>)",
    name: "meta.tag.preprocessor.xml.html",
    patterns: 
     [{include: "#tag-generic-attribute"},
      {include: "#string-double-quoted"},
      {include: "#string-single-quoted"}]},
   {begin: /<!--/,
    captures: {0 => {name: "punctuation.definition.comment.html"}},
    end: "--\\s*>",
    name: "comment.block.html",
    patterns: 
     [{match: /--/, name: "invalid.illegal.bad-comments-or-CDATA.html"},
      {include: "#embedded-code"}]},
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
    endCaptures: {2 => {name: "punctuation.definition.tag.html"}},
    name: "source.js.embedded.html",
    patterns: 
     [{include: "#tag-stuff"},
      {begin: /(?<!<\/(?:script|SCRIPT))(?<_1>>)/,
       captures: 
        {1 => {name: "punctuation.definition.tag.html"},
         2 => {name: "entity.name.tag.script.html"}},
       end: "(</)((?i:script))",
       patterns: 
        [{captures: {1 => {name: "punctuation.definition.comment.js"}},
          match: /(?<_1>\/\/).*?(?<_2>(?=<\/script)|$\n?)/,
          name: "comment.line.double-slash.js"},
         {begin: /\/\*/,
          captures: {0 => {name: "punctuation.definition.comment.js"}},
          end: "\\*/|(?=</script)",
          name: "comment.block.js"},
         {include: "#php"},
         {include: "source.js"}]}]},
   {begin: /(?<_1><\/?)(?<_2>(?i:body|head|html)\b)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.structure.any.html"}},
    end: "(>)",
    name: "meta.tag.structure.any.html",
    patterns: [{include: "#tag-stuff"}]},
   {begin: 
     /(?<_1><\/?)(?<_2>(?i:address|blockquote|dd|div|dl|dt|fieldset|form|frame|frameset|h1|h2|h3|h4|h5|h6|iframe|noframes|object|ol|p|ul|applet|center|dir|hr|menu|pre)\b)/,
    beginCaptures: 
     {1 => {name: "punctuation.definition.tag.begin.html"},
      2 => {name: "entity.name.tag.block.any.html"}},
    end: "(>)",
    endCaptures: {1 => {name: "punctuation.definition.tag.end.html"}},
    name: "meta.tag.block.any.html",
    patterns: [{include: "#tag-stuff"}]},
   {begin: 
     /(?<_1><\/?)(?<_2>(?i:a|abbr|acronym|area|b|base|basefont|bdo|big|br|button|caption|cite|code|col|colgroup|del|dfn|em|font|head|html|i|img|input|ins|isindex|kbd|label|legend|li|link|map|meta|noscript|optgroup|option|param|q|s|samp|script|select|small|span|strike|strong|style|sub|sup|table|tbody|td|textarea|tfoot|th|thead|title|tr|tt|u|var)\b)/,
    beginCaptures: 
     {1 => {name: "punctuation.definition.tag.begin.html"},
      2 => {name: "entity.name.tag.inline.any.html"}},
    end: "((?: ?/)?>)",
    endCaptures: {1 => {name: "punctuation.definition.tag.end.html"}},
    name: "meta.tag.inline.any.html",
    patterns: [{include: "#tag-stuff"}]},
   {begin: /(?<_1><\/?)(?<_2>[a-zA-Z0-9:]+)/,
    beginCaptures: 
     {1 => {name: "punctuation.definition.tag.begin.html"},
      2 => {name: "entity.name.tag.other.html"}},
    end: "(>)",
    endCaptures: {1 => {name: "punctuation.definition.tag.end.html"}},
    name: "meta.tag.other.html",
    patterns: [{include: "#tag-stuff"}]},
   {include: "#entities"},
   {match: /<>/, name: "invalid.illegal.incomplete.html"},
   {match: /</, name: "invalid.illegal.bad-angle-bracket.html"}],
 repository: 
  {:"embedded-code" => 
    {patterns: 
      [{include: "#ruby"},
       {include: "#php"},
       {include: "#smarty"},
       {include: "#python"}]},
   entities: 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.entity.html"},
          3 => {name: "punctuation.definition.entity.html"}},
        match: /(?<_1>&)(?<_2>[a-zA-Z0-9]+|#[0-9]+|#x[0-9a-fA-F]+)(?<_3>;)/,
        name: "constant.character.entity.html"},
       {match: /&/, name: "invalid.illegal.bad-ampersand.html"}]},
   php: 
    {begin: /(?=(?<_1>^\s*)?<\?)/,
     end: "(?!(^\\s*)?<\\?)",
     patterns: [{include: "source.php"}]},
   python: 
    {begin: /(?:^\s*)<\?python(?!.*\?>)/,
     end: "\\?>(?:\\s*$\\n)?",
     name: "source.python.embedded.html",
     patterns: [{include: "source.python"}]},
   ruby: 
    {patterns: 
      [{begin: /<%+#/,
        captures: {0 => {name: "punctuation.definition.comment.erb"}},
        end: "%>",
        name: "comment.block.erb"},
       {begin: /<%+(?!>)=?/,
        captures: {0 => {name: "punctuation.section.embedded.ruby"}},
        end: "-?%>",
        name: "source.ruby.embedded.html",
        patterns: 
         [{captures: {1 => {name: "punctuation.definition.comment.ruby"}},
           match: /(?<_1>#).*?(?=-?%>)/,
           name: "comment.line.number-sign.ruby"},
          {include: "source.ruby"}]},
       {begin: /<\?r(?!>)=?/,
        captures: {0 => {name: "punctuation.section.embedded.ruby.nitro"}},
        end: "-?\\?>",
        name: "source.ruby.nitro.embedded.html",
        patterns: 
         [{captures: 
            {1 => {name: "punctuation.definition.comment.ruby.nitro"}},
           match: /(?<_1>#).*?(?=-?\?>)/,
           name: "comment.line.number-sign.ruby.nitro"},
          {include: "source.ruby"}]}]},
   smarty: 
    {patterns: 
      [{begin: /(?<_1>\{(?<_2>literal)\})/,
        captures: 
         {1 => {name: "source.smarty.embedded.html"},
          2 => {name: "support.function.built-in.smarty"}},
        end: "(\\{/(literal)\\})"},
       {begin: /{{|{/,
        disabled: 1,
        end: "}}|}",
        name: "source.smarty.embedded.html",
        patterns: [{include: "source.smarty"}]}]},
   :"string-double-quoted" => 
    {begin: /"/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.html"}},
     end: "\"",
     endCaptures: {0 => {name: "punctuation.definition.string.end.html"}},
     name: "string.quoted.double.html",
     patterns: [{include: "#embedded-code"}, {include: "#entities"}]},
   :"string-single-quoted" => 
    {begin: /'/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.html"}},
     end: "'",
     endCaptures: {0 => {name: "punctuation.definition.string.end.html"}},
     name: "string.quoted.single.html",
     patterns: [{include: "#embedded-code"}, {include: "#entities"}]},
   :"tag-generic-attribute" => 
    {match: /\b(?<_1>[a-zA-Z\-:]+)/, name: "entity.other.attribute-name.html"},
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
 scopeName: "text.html.basic",
 uuid: "17994EC8-6B1D-11D9-AC3A-000D93589AF6"}
