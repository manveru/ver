# Encoding: UTF-8

{fileTypes: ["mtml"],
 firstLineMatch: "<\\$?[Mm][Tt]",
 foldingStartMarker: 
  /(?x)
	(<(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|li|form|dl)\b.*?>
	|<(?i:MT:?(?!Else))(\w+:)?\w+\b.*?>
	|<!--(?!.*--\s*>)
	|^<!--\ \#tminclude\ (?>.*?-->)$
	|<\?(?:php)?.*\b(if|for(each)?|while)\b.+:
	|\{\{?(if|foreach|capture|literal|foreach|php|section|strip)
	|\{\s*($|\?>\s*$|\/\/|\/\*(.*\*\/\s*$|(?!.*?\*\/)))
	)/,
 foldingStopMarker: 
  /(?x)
	(<\/(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|li|form|dl)>
	|<\/(?i:MT:?(?!Else))(\w+:)?\w+\b.*?>
	|^(?!.*?<!--).*?--\s*>
	|^<!--\ end\ tminclude\ -->$
	|<\?(?:php)?.*\bend(if|for(each)?|while)\b
	|\{\{?\/(if|foreach|capture|literal|foreach|php|section|strip)
	|^[^{]*\}
	)/,
 keyEquivalent: /^~M/,
 name: "Movable Type (MT only)",
 patterns: [{include: "#mt"}],
 repository: 
  {:"basic-html" => 
    {begin: /(<)([a-zA-Z0-9:]+)(?=[^>]*><\/\2>)/,
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
   :"embedded-code" => 
    {patterns: [{include: "#mt"}, {include: "#php"}, {include: "#smarty"}]},
   entities: 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.constant.html"},
          3 => {name: "punctuation.definition.constant.html"}},
        match: /(&)([a-zA-Z0-9]+|#[0-9]+|#x[0-9a-fA-F]+)(;)/,
        name: "constant.character.entity.html"},
       {match: /&/, name: "invalid.illegal.bad-ampersand.html"}]},
   mt: 
    {patterns: 
      [{include: "#trans-tag"},
       {include: "#mt-container-tag"},
       {include: "#mt-variable-tag"},
       {include: "#basic-html"},
       {comment: "text.html.basic"}]},
   :"mt-container-tag" => 
    {patterns: 
      [{begin: /(<\/?)([mM][tT]:?(?:\w+)?:?\w+)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.tag.mt"},
          2 => {name: "entity.name.tag.mt"}},
        end: ">",
        endCaptures: {0 => {name: "punctuation.definition.tag.mt"}},
        name: "meta.tag.mt.container.html",
        patterns: [{include: "#tag-stuff"}]}]},
   :"mt-variable-tag" => 
    {patterns: 
      [{begin: /(<)(\$[mM][tT]:?(?:\w+)?:?\w+)/,
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
      [{begin: /<\?(php|=)?/,
        captures: {0 => {name: "punctuation.section.embedded.php"}},
        end: "\\?>",
        name: "source.php.embedded.html",
        patterns: [{include: "#php-source"}]}]},
   :"php-source" => {patterns: [{include: "source.php"}]},
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
    {match: /\b([a-zA-Z_:-]+)/, name: "entity.other.attribute-name.html"},
   :"tag-id-attribute" => 
    {begin: /\b(id)\b\s*(=)/,
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
   :"tag-stuff" => {patterns: [{include: "#embedded-code"}]},
   :"trans-tag" => 
    {patterns: 
      [{begin: /(<)(__trans)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.tag.mt"},
          2 => {name: "variable.other.mt"}},
        end: "(>)",
        endCaptures: 
         {1 => {name: "variable.other.mt"},
          2 => {name: "punctuation.definition.tag.mt"}},
        name: "meta.tag.mt.trans.html",
        patterns: [{include: "#tag-stuff"}]}]}},
 scopeName: "text.html.mt.pure",
 uuid: "AC9320E4-DE28-4D36-905D-AFBE099F7466"}
