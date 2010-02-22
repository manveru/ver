# Encoding: UTF-8

{fileTypes: ["gsp"],
 foldingStartMarker: 
  /(?x)
	(?<_1><(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl|g:javascript)\b.*?>
	|<!--(?!.*-->)
	|\{\s*(?<_2>$|\?>\s*$|\/\/|\/\*(?<_3>.*\*\/\s*$|(?!.*?\*\/)))
	)/,
 foldingStopMarker: 
  /(?x)
	(?<_1><\/(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl|g:javascript)>
	|^\s*-->
	|(?<_2>^|\s)\}
	)/,
 keyEquivalent: "^~G",
 name: "Grails Server Page",
 patterns: 
  [{begin: /<%+(?!>)=?/,
    beginCaptures: {0 => {name: "punctuation.section.embedded.begin.groovy"}},
    end: "(%)>",
    endCaptures: 
     {0 => {name: "punctuation.section.embedded.end.groovy"},
      1 => {name: "source.groovy"}},
    name: "source.groovy",
    patterns: [{include: "source.groovy"}]},
   {include: "#embedded-groovy"},
   {begin: /(?<_1>^\s*)?(?=<(?i:g:javascript))/,
    beginCaptures: {0 => {name: "punctuation.whitespace.embedded.leading.js"}},
    contentName: "source.js",
    end: "(?<=>)(?!<(?i:g:javascript))(\\s*\\n)?",
    endCaptures: {0 => {name: "punctuation.whitespace.embedded.trailing.js"}},
    patterns: 
     [{begin: /(?<_1><)(?<_2>(?i:g:javascript))/,
       beginCaptures: 
        {1 => {name: "punctuation.definition.tag.html.grails"},
         2 => {name: "entity.name.tag.template.html.grails"}},
       end: "/>|(?=>)",
       endCaptures: {0 => {name: "punctuation.definition.tag.html.grails"}},
       name: "meta.tag.template.javascript.html.grails",
       patterns: [{include: "#tag-stuff"}]},
      {captures: 
        {1 => {name: "punctuation.definition.tag.html.grails"},
         2 => {name: "source.js"},
         3 => {name: "entity.name.tag.template.html.grails"},
         4 => {name: "punctuation.definition.tag.html.grails"}},
       match: /(?<_1>(?<_2><)\/)(?<_3>(?i:g:javascript))(?<_4>>)/,
       name: "meta.tag.template.javascript.html.grails"},
      {begin: /(?<_1>>)/,
       beginCaptures: 
        {0 => {name: "meta.tag.template.javascript.html.grails"},
         1 => {name: "punctuation.definition.tag.html.grails"}},
       contentName: "source.js",
       end: "(?=</(?i:g:javascript)>)",
       patterns: 
        [{captures: {1 => {name: "punctuation.definition.comment.begin.js"}},
          match: /(?<_1>\/\/).*?(?<_2>(?=<\/(?i:g:javascript))|$\n?)/,
          name: "comment.line.double-slash.js"},
         {begin: /\/\*/,
          beginCaptures: 
           {0 => {name: "punctuation.definition.comment.begin.js"}},
          end: "\\*/|(?=</(?i:g:javascript))",
          endCaptures: {0 => {name: "punctuation.definition.comment.end.js"}},
          name: "comment.block.js"},
         {include: "source.js"}]}]},
   {begin: /(?<_1><\/?)(?<_2>\w+:\w+)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.html.grails"},
      2 => {name: "entity.name.tag.template.html.grails"}},
    end: "(/?>)",
    name: "meta.tag.template.html.grails",
    patterns: [{include: "#tag-stuff"}]},
   {include: "text.html.basic"}],
 repository: 
  {:"embedded-groovy" => 
    {patterns: 
      [{begin: /\$\{/,
        captures: {0 => {name: "punctuation.section.embedded.groovy"}},
        end: "\\}",
        name: "source.groovy.embedded.html.grails",
        patterns: [{include: "source.groovy"}]}]},
   :"string-double-quoted" => 
    {begin: /"/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.string.begin.html.grails"}},
     end: "\"",
     endCaptures: 
      {0 => {name: "punctuation.definition.string.end.html.grails"}},
     name: "string.quoted.double.html.grails",
     patterns: [{include: "#embedded-groovy"}]},
   :"string-single-quoted" => 
    {begin: /'/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.string.begin.html.grails"}},
     end: "'",
     endCaptures: 
      {0 => {name: "punctuation.definition.string.end.html.grails"}},
     name: "string.quoted.single.html.grails"},
   :"tag-attribute" => 
    {match: /\b(?<_1>[a-zA-Z\-:]+)/,
     name: "entity.other.attribute-name.html.grails"},
   :"tag-stuff" => 
    {patterns: 
      [{include: "#tag-attribute"},
       {include: "#string-double-quoted"},
       {include: "#string-single-quoted"}]}},
 scopeName: "text.html.grails",
 uuid: "E4DECA1B-424C-4A75-AD67-E907F182E4FB"}
