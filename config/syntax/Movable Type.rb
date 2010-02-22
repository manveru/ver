# Encoding: UTF-8

{fileTypes: ["mtml"],
 firstLineMatch: "<\\$?[Mm][Tt]",
 foldingStartMarker: 
  /(?x)
	(?<_1><(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|li|form|dl)\b.*?>
	|<(?i:MT:?(?!Else))(?<_2>\w+:)?\w+\b.*?>
	|<!--(?!.*--\s*>)
	|^<!--\ \#tminclude\ (?>.*?-->)$
	|<\?(?:php)?.*\b(?<_3>if|for(?<_4>each)?|while)\b.+:
	|\{\{?(?<_5>if|foreach|capture|literal|foreach|php|section|strip)
	|\{\s*(?<_6>$|\?>\s*$|\/\/|\/\*(?<_7>.*\*\/\s*$|(?!.*?\*\/)))
	)/,
 foldingStopMarker: 
  /(?x)
	(?<_1><\/(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|li|form|dl)>
	|<\/(?i:MT:?(?!Else))(?<_2>\w+:)?\w+\b.*?>
	|^(?!.*?<!--).*?--\s*>
	|^<!--\ end\ tminclude\ -->$
	|<\?(?:php)?.*\bend(?<_3>if|for(?<_4>each)?|while)\b
	|\{\{?\/(?<_5>if|foreach|capture|literal|foreach|php|section|strip)
	|^[^{]*\}
	)/,
 keyEquivalent: "^~M",
 name: "Movable Type",
 patterns: 
  [{include: "#trans-tag"},
   {include: "#mt-container-tag"},
   {include: "#mt-variable-tag"},
   {comment: 
     "This is set to use XHTML standards, but you can change that by changing .strict to .basic for HTML standards",
    include: "text.html.basic"},
   {begin: /{{/,
    captures: {0 => {name: "punctuation.section.embedded.smarty"}},
    end: "}}",
    name: "source.smarty.embedded.html",
    patterns: [{include: "source.smarty"}]}],
 repository: 
  {:"embedded-code" => 
    {patterns: [{include: "#php"}, {include: "#ruby"}, {include: "#smarty"}]},
   entities: 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.constant.html"},
          3 => {name: "punctuation.definition.constant.html"}},
        match: /(?<_1>&)(?<_2>[a-zA-Z0-9]+|#[0-9]+|#x[0-9a-fA-F]+)(?<_3>;)/,
        name: "constant.character.entity.html"},
       {match: /&/, name: "invalid.illegal.bad-ampersand.html"}]},
   :"mt-container-tag" => 
    {patterns: 
      [{begin: /(?<_1><\/?)(?<_2>[Mm][Tt]:?(?<_3>\w+:)?\w+)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.tag.mt"},
          2 => {name: "entity.name.tag.mt"}},
        end: ">",
        endCaptures: {0 => {name: "punctuation.definition.tag.mt"}},
        name: "meta.tag.mt.container.html",
        patterns: [{include: "#tag-stuff"}]}]},
   :"mt-variable-tag" => 
    {patterns: 
      [{begin: /(?<_1><)(?<_2>\$[Mm][Tt]:?(?<_3>\w+:)?\w+)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.tag.mt"},
          2 => {name: "variable.other.mt"}},
        end: "(\\$)?(>)",
        endCaptures: 
         {1 => {name: "variable.other.mt"},
          2 => {name: "punctuation.definition.tag.mt"}},
        name: "meta.tag.mt.variable.html",
        patterns: [{include: "#tag-stuff"}]}]},
   php: 
    {patterns: 
      [{begin: /(?:^\s*)(?<_1><\?(?<_2>php|=)?)(?!.*\?>)/,
        captures: {1 => {name: "punctuation.section.embedded.php"}},
        comment: "match only multi-line PHP with leading whitespace",
        end: "(\\?>)(?:\\s*$\\n)?",
        name: "source.php.embedded.html",
        patterns: [{include: "#php-source"}]},
       {begin: /<\?(?<_1>php|=)?/,
        captures: {0 => {name: "punctuation.section.embedded.php"}},
        end: "\\?>",
        name: "source.php.embedded.html",
        patterns: [{include: "#php-source"}]}]},
   :"php-source" => 
    {patterns: 
      [{captures: {1 => {name: "punctuation.definition.comment.php"}},
        match: /(?<_1>#).*?(?=\?>)/,
        name: "comment.line.number-sign.ruby"},
       {captures: {1 => {name: "punctuation.definition.comment.php"}},
        match: /(?<_1>\/\/).*?(?=\?>)/,
        name: "comment.line.double-slash.ruby"},
       {include: "source.php"}]},
   ruby: 
    {begin: /<%+(?!>)=?/,
     captures: {0 => {name: "punctuation.section.embedded.ruby"}},
     end: "-?%>",
     name: "source.ruby.embedded.html",
     patterns: 
      [{captures: {1 => {name: "punctuation.definition.comment.ruby"}},
        match: /(?<_1>#).*?(?=-?%>)/,
        name: "comment.line.number-sign.ruby"},
       {include: "source.ruby"}]},
   smarty: 
    {begin: /{{|{/,
     captures: {0 => {name: "punctuation.section.embedded.smarty"}},
     disabled: "1",
     end: "}}|}",
     name: "source.smarty.embedded.xhtml",
     patterns: [{include: "source.smarty"}]},
   :"string-double-quoted" => 
    {begin: /"/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.html"}},
     end: "\"",
     endCaptures: {0 => {name: "punctuation.definition.string.end.html"}},
     name: "string.quoted.double.html",
     patterns: 
      [{include: "#trans-tag"},
       {include: "#mt-variable-tag"},
       {include: "#mt-container-tag"},
       {include: "#embedded-code"},
       {include: "#entities"}]},
   :"string-single-quoted" => 
    {begin: /'/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.html"}},
     end: "'",
     endCaptures: {0 => {name: "punctuation.definition.string.end.html"}},
     name: "string.quoted.single.html",
     patterns: 
      [{include: "#trans-tag"},
       {include: "#mt-variable-tag"},
       {include: "#mt-container-tag"},
       {include: "#embedded-code"},
       {include: "#entities"}]},
   :"tag-generic-attribute" => 
    {match: /\b(?<_1>[a-zA-Z_:-]+)/, name: "entity.other.attribute-name.html"},
   :"tag-stuff" => 
    {patterns: 
      [{include: "#trans-tag"},
       {include: "#tag-generic-attribute"},
       {include: "#string-double-quoted"},
       {include: "#string-single-quoted"}]},
   :"trans-tag" => 
    {patterns: 
      [{begin: /(?<_1><)(?<_2>__trans)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.tag.mt"},
          2 => {name: "variable.other.mt"}},
        end: "(>)",
        endCaptures: 
         {1 => {name: "variable.other.mt"},
          2 => {name: "punctuation.definition.tag.mt"}},
        name: "meta.tag.mt.trans.html",
        patterns: [{include: "#tag-stuff"}]}]}},
 scopeName: "text.html.mt",
 uuid: "7071B5CA-849A-4D88-A96E-DD725ED622BF"}
