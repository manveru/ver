# Encoding: UTF-8

{comment: 
  "This is a modified version of the HTML language that uses ASP VB.NET for embedded source code instead of ruby. Thomas Aylott subtleGradient.com",
 fileTypes: ["aspx", "ascx"],
 foldingStartMarker: 
  /(?x)
	(<(?i:mm:dataset|mm:insert|mm:update|asp:DataGrid|asp:Repeater|asp:TemplateColumn|head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)\b
	|<!--(?!.*-->)
	|<%(?!.*%>)
	|\{\{?(if|foreach|capture|literal|foreach|php|section|strip)
	|\{\s*($|\?>\s*$|\/\/|\/\*(.*\*\/\s*$|(?!.*?\*\/)))
	)/,
 foldingStopMarker: 
  /(?x)
	(<\/(?i:mm:dataset|mm:insert|mm:update|asp:DataGrid|asp:Repeater|asp:TemplateColumn|head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)>
	|^\s*-->
	|^\s*%>
	|\{\{?\/(if|foreach|capture|literal|foreach|php|section|strip)
	|(^|\s)\}
	)/,
 keyEquivalent: "^~A",
 name: "HTML (ASP.net)",
 patterns: 
  [{include: "#php"},
   {include: "#asp"},
   {include: "#smarty"},
   {captures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.html"},
      3 => {name: "punctuation.definition.tag.html"},
      4 => {name: "meta.scope.between-tag-pair.html"},
      5 => {name: "entity.name.tag.html"},
      6 => {name: "punctuation.definition.tag.html"}},
    match: /(<)(\w+)[^>]*((>)<\/)(\2)(>)/,
    name: "meta.tag.html"},
   {begin: /(<\?)(xml)/,
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
    captures: {0 => {name: "punctuation.definition.comment.asp.net"}},
    end: "-->",
    name: "comment.block.html",
    patterns: 
     [{match: /--/, name: "invalid.illegal.bad-comments-or-CDATA.html"}]},
   {begin: /<!/,
    captures: {0 => {name: "punctuation.definition.tag.asp.net"}},
    end: ">",
    name: "meta.tag.sgml.html",
    patterns: 
     [{begin: /(DOCTYPE)/,
       captures: {1 => {name: "entity.name.tag.doctype.html"}},
       end: "(?=>)",
       name: "meta.tag.sgml.doctype.html",
       patterns: 
        [{match: /"[^">]*"/,
          name: "string.quoted.double.doctype.identifiers-and-DTDs.html"}]},
      {begin: /\[CDATA\[/,
       end: "]](?=>)",
       name: "constant.other.inline-data.html"},
      {match: /(\s*)(?!--|>)\S(\s*)/,
       name: "invalid.illegal.bad-comments-or-CDATA.html"}]},
   {begin: /(?:^\s+)?(<)((?i:script))\b(?![^>]*\/>)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.script.html"}},
    end: "(?<=</(script|SCRIPT))(>)(?:\\s*\\n)?",
    name: "source.js.embedded.html",
    patterns: 
     [{include: "#tag-stuff"},
      {begin: /(?<!<\/(?:script|SCRIPT))(>)/,
       captures: {1 => {name: "punctuation.definition.tag.html"}},
       end: "(</)((?i:script))",
       patterns: [{include: "source.js"}]}]},
   {begin: /(?:^\s+)?(<)((?i:style))\b(?![^>]*\/>)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.style.html"},
      3 => {name: "punctuation.definition.tag.html"}},
    end: "(</)((?i:style))(>)(?:\\s*\\n)?",
    name: "source.css.embedded.html",
    patterns: 
     [{include: "#tag-stuff"},
      {begin: /(>)/,
       beginCaptures: {1 => {name: "punctuation.definition.tag.html"}},
       end: "(?=</(?i:style))",
       patterns: [{include: "source.css"}]}]},
   {begin: /(<\/?)((?i:body|head|html)\b)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.structure.any.html"}},
    end: "(>)",
    name: "meta.tag.structure.any.html",
    patterns: [{include: "#tag-stuff"}]},
   {begin: 
     /(<\/?)((?i:address|blockquote|dd|div|dl|dt|fieldset|form|frame|frameset|h1|h2|h3|h4|h5|h6|iframe|noframes|object|ol|p|ul|applet|center|dir|hr|menu|pre)\b)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.block.any.html"}},
    end: "(>)",
    name: "meta.tag.block.any.html",
    patterns: [{include: "#tag-stuff"}]},
   {begin: 
     /(<\/?)((?i:a|abbr|acronym|area|b|base|basefont|bdo|big|br|button|caption|cite|code|col|colgroup|del|dfn|em|font|head|html|i|img|input|ins|isindex|kbd|label|legend|li|link|map|meta|noscript|optgroup|option|param|q|s|samp|script|select|small|span|strike|strong|style|sub|sup|table|tbody|td|textarea|tfoot|th|thead|title|tr|tt|u|var)\b)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.html"},
      2 => {name: "entity.name.tag.inline.any.html"}},
    end: "(>)",
    name: "meta.tag.inline.any.html",
    patterns: [{include: "#tag-stuff"}]},
   {begin: /(<\/?)([a-zA-Z0-9:]+)/,
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
  {asp: 
    {patterns: 
      [{include: "#source-asp-embedded-scripttag"},
       {include: "#source-asp-embedded"},
       {include: "#source-asp-bound"},
       {include: "#source-asp-return"},
       {captures: 
         {1 => {name: "punctuation.definition.tag.asp"},
          3 => {name: "punctuation.definition.tag.asp"}},
        match: /(<!--)\s+#include.*(-->)/,
        name: "meta.source.embedded.asp.include"}]},
   :"embedded-code" => 
    {patterns: [{include: "#php"}, {include: "#asp"}, {include: "#smarty"}]},
   entities: 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.entity.html"},
          3 => {name: "punctuation.definition.entity.html"}},
        match: /(&)([a-zA-Z0-9]+|#[0-9]+|#x[0-9a-fA-F]+)(;)/,
        name: "constant.character.entity.html"},
       {match: /&/, name: "invalid.illegal.bad-ampersand.html"}]},
   php: 
    {patterns: 
      [{begin: /(?:^\s*)(<\?(php|=)?)(?!.*\?>)/,
        captures: {1 => {name: "punctuation.section.embedded.php"}},
        comment: "match only multi-line PHP with leading whitespace",
        end: "(\\?>)(?:\\s*$\\n)?",
        name: "source.php.embedded.html",
        patterns: [{include: "#php-source"}]},
       {begin: /<\?(php|=)?/,
        beginCaptures: {0 => {name: "punctuation.section.embedded.begin.php"}},
        end: "\\?>",
        endCaptures: {0 => {name: "punctuation.section.embedded.end.php"}},
        name: "source.php.embedded.html",
        patterns: [{include: "#php-source"}]}]},
   :"php-source" => 
    {patterns: 
      [{captures: {1 => {name: "punctuation.definition.comment.php"}},
        match: /(#).*?(?=\?>)/,
        name: "comment.line.number-sign.php"},
       {captures: {1 => {name: "punctuation.definition.comment.php"}},
        match: /(\/\/).*?(?=\?>)/,
        name: "comment.line.double-slash.php"},
       {include: "source.php"}]},
   ruby: 
    {begin: /<%+(?!>)=?/,
     beginCaptures: {0 => {name: "punctuation.section.embedded.begin.ruby"}},
     end: "-?%>",
     endCaptures: {0 => {name: "punctuation.section.embedded.end.ruby"}},
     name: "source.ruby.embedded.html",
     patterns: 
      [{captures: {1 => {name: "punctuation.definition.comment.ruby"}},
        match: /(#).*?(?=-?%>)/,
        name: "comment.line.number-sign.ruby"},
       {include: "source.ruby"}]},
   smarty: 
    {patterns: 
      [{begin: /((\{)(literal)(\}))/,
        captures: 
         {1 => {name: "source.smarty.embedded.html"},
          2 => {name: "punctuation.section.embedded.smarty"},
          3 => {name: "support.function.built-in.smarty"},
          4 => {name: "punctuation.section.embedded.smarty"}},
        end: "((\\{/)(literal)(\\}))"},
       {begin: /{{|{/,
        captures: {0 => {name: "punctuation.section.embedded.smarty"}},
        disabled: 1,
        end: "}}|}",
        name: "source.smarty.embedded.html",
        patterns: [{include: "source.smarty"}]}]},
   :"source-asp-bound" => 
    {begin: /<%#/,
     beginCaptures: {0 => {name: "punctuation.section.embedded.begin.asp"}},
     end: "%>",
     endCaptures: {0 => {name: "punctuation.section.embedded.end.asp"}},
     name: "meta.source.embedded.bound",
     patterns: 
      [{begin: /(?<=<%#)/,
        end: "(?=%>)",
        name: "source.asp.embedded.html",
        patterns: [{include: "source.asp.vb.net"}]}]},
   :"source-asp-embedded" => 
    {begin: /<%(?![=#])/,
     beginCaptures: {0 => {name: "punctuation.section.embedded.begin.asp"}},
     end: "%>",
     endCaptures: {0 => {name: "punctuation.section.embedded.end.asp"}},
     name: "meta.source.embedded",
     patterns: 
      [{begin: /(?<=<%)/,
        end: "(?=%>)",
        name: "source.asp.embedded.html",
        patterns: [{include: "source.asp.vb.net"}]}]},
   :"source-asp-embedded-scripttag" => 
    {begin: /(?:^\s+)?(<)(script).*runat=.server[^>]*(>)/,
     captures: 
      {1 => {name: "punctuation.definition.tag.html"},
       2 => {name: "entity.name.tag.script.html"},
       3 => {name: "punctuation.definition.tag.html"}},
     end: "(</)(script)(>)(?:\\s*$\\n)?",
     name: "meta.source.embedded.script-tag",
     patterns: 
      [{begin: /(?<=(>))/,
        end: "(?=</script>)",
        name: "source.asp.embedded.html",
        patterns: [{include: "source.asp.vb.net"}]}]},
   :"source-asp-return" => 
    {begin: /<%=/,
     beginCaptures: {0 => {name: "punctuation.section.embedded.begin.asp"}},
     end: "%>",
     endCaptures: {0 => {name: "punctuation.section.embedded.end.asp"}},
     name: "meta.source.embedded.return-value",
     patterns: 
      [{begin: /(?<=<%=)/,
        end: "(?=%>)",
        name: "source.asp.embedded.html",
        patterns: [{include: "source.asp.vb.net"}]}]},
   :"source-asp-single-line" => 
    {begin: /<%(=|#|@)/,
     beginCaptures: {0 => {name: "punctuation.section.embedded.begin.asp"}},
     comment: "DEBUG",
     end: "%>",
     endCaptures: {0 => {name: "punctuation.section.embedded.end.asp"}},
     name: "meta.source.embedded.single-line",
     patterns: 
      [{begin: /(?<=<%)/,
        end: "(?=%>)",
        name: "source.asp.embedded.html",
        patterns: [{include: "source.asp.vb.net"}]}]},
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
    {match: /\b([a-zA-Z:-]+)/, name: "entity.other.attribute-name.html"},
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
   :"tag-stuff" => 
    {patterns: 
      [{include: "#tag-id-attribute"},
       {include: "#tag-generic-attribute"},
       {include: "#string-double-quoted"},
       {include: "#string-single-quoted"}]}},
 scopeName: "text.html.asp.net",
 uuid: "426BF395-E61E-430F-8E4C-47F2E15C769B"}
