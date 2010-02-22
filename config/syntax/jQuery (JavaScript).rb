# Encoding: UTF-8

{comment: "jQuery Javascript Framework. By Jonathan Chaffer & Karl Swedberg.",
 foldingStartMarker: /(?<_1>^.*{[^}]*$|^.*\([^\)]*$|^.*\/\*(?!.*\*\/).*$)/,
 foldingStopMarker: /(?<_1>^\s*\}|^\s*\)|^(?!.*\/\*).*\*\/)/,
 keyEquivalent: "^~J",
 name: "jQuery (JavaScript)",
 patterns: 
  [{begin: /(?<_1>\$)(?<_2>\()/,
    beginCaptures: 
     {1 => {name: "support.class.js.jquery"},
      2 => {name: "punctuation.section.class.js"}},
    contentName: "meta.selector.jquery",
    end: "(\\))",
    endCaptures: {1 => {name: "punctuation.section.class.js"}},
    patterns: 
     [{include: "#nested-parens"},
      {begin: /'(?!<)/,
       beginCaptures: 
        {0 => {name: "punctuation.definition.selector.begin.js"}},
       end: "'",
       endCaptures: {0 => {name: "punctuation.definition.selector.end.js"}},
       patterns: [{include: "#css-selector"}]},
      {begin: /"(?!<)/,
       beginCaptures: 
        {0 => {name: "punctuation.definition.selector.begin.js"}},
       end: "\"",
       endCaptures: {0 => {name: "punctuation.definition.selector.end.js"}},
       patterns: [{include: "#css-selector"}]},
      {begin: /'(?=<)/,
       beginCaptures: 
        {0 => {name: "punctuation.definition.selector.begin.js"}},
       end: "'",
       endCaptures: {0 => {name: "punctuation.definition.selector.end.js"}},
       patterns: [{include: "text.html.basic"}]},
      {begin: /"(?=<)/,
       beginCaptures: 
        {0 => {name: "punctuation.definition.selector.begin.js"}},
       end: "\"",
       endCaptures: {0 => {name: "punctuation.definition.selector.end.js"}},
       patterns: [{include: "text.html.basic"}]},
      {include: "source.js"}]},
   {begin: 
     /\b(?<_1>filter|is|not|add|children|find|next|nextAll|parent|parents|prev|prevAll|siblings|appendTo|prependTo|insertAfter|insertBefore|replaceAll|remove)\s*(?<_2>\()/,
    beginCaptures: 
     {1 => {name: "support.function.js.jquery"},
      2 => {name: "punctuation.section.function.js"}},
    contentName: "meta.selector.jquery",
    end: "(\\))",
    endCaptures: {1 => {name: "punctuation.section.function.js"}},
    patterns: 
     [{include: "#nested-parens"},
      {begin: /'(?!<)/,
       beginCaptures: 
        {0 => {name: "punctuation.definition.selector.begin.js"}},
       end: "'",
       endCaptures: {0 => {name: "punctuation.definition.selector.end.js"}},
       patterns: [{include: "#css-selector"}]},
      {begin: /"(?!<)/,
       beginCaptures: 
        {0 => {name: "punctuation.definition.selector.begin.js"}},
       end: "\"",
       endCaptures: {0 => {name: "punctuation.definition.selector.end.js"}},
       patterns: [{include: "#css-selector"}]},
      {begin: /'(?=<)/,
       beginCaptures: 
        {0 => {name: "punctuation.definition.selector.begin.js"}},
       end: "'",
       endCaptures: {0 => {name: "punctuation.definition.selector.end.js"}},
       patterns: [{include: "text.html.basic"}]},
      {begin: /"(?=<)/,
       beginCaptures: 
        {0 => {name: "punctuation.definition.selector.begin.js"}},
       end: "\"",
       endCaptures: {0 => {name: "punctuation.definition.selector.end.js"}},
       patterns: [{include: "text.html.basic"}]},
      {include: "source.js"}]},
   {match: 
     /\.(?<_1>each|size|length|get|index|extend|noConflict|attr|removeAttr|addClass|removeClass|toggleClass|html|text|val|eq|hasClass|map|slice|contents|andSelf|end|append|prepend|after|before|wrap|wrapAll|wrapInner|replaceWith|empty|clone|css|offset|height|width|ready|bind|one|trigger|triggerHandler|unbind|hover|toggle|blur|change|click|dblclick|error|focus|keydown|keypress|keyup|load|mousedown|mousemove|mouseout|mouseover|mouseup|resize|scroll|select|submit|unload|show|hide|toggle|slideDown|slideUp|slideToggle|fadeIn|fadeOut|fadeTo|animate|stop|queue|dequeue|load|ajaxComplete|ajaxError|ajaxSend|ajaxStart|ajaxStop|ajaxSuccess|serialize|serializeArray|ajax|get|getJSON|getScript|post|ajaxSetup|css|offset|height|width)\b/,
    name: "support.function.js.jquery"},
   {include: "source.js"}],
 repository: 
  {:"css-selector" => 
    {begin: /(?=\s*[.*#a-zA-Z])/,
     end: "(?=[\"'])",
     name: "meta.selector.css",
     patterns: 
      [{match: 
         /\b(?<_1>a|abbr|acronym|address|area|b|base|big|blockquote|body|br|button|caption|cite|code|col|colgroup|dd|del|dfn|div|dl|dt|em|fieldset|form|frame|frameset|(?<_2>h[1-6])|head|hr|html|i|iframe|img|input|ins|kbd|label|legend|li|link|map|meta|noframes|noscript|object|ol|optgroup|option|p|param|pre|q|samp|script|select|small|span|strike|strong|style|sub|sup|table|tbody|td|textarea|tfoot|th|thead|title|tr|tt|ul|var)\b/,
        name: "entity.name.tag.css"},
       {captures: {1 => {name: "punctuation.definition.attribute-name.css"}},
        match: /(?<_1>\.)[a-zA-Z0-9_-]+/,
        name: "entity.other.attribute-name.class.css"},
       {captures: {1 => {name: "punctuation.definition.attribute-name.css"}},
        match: /(?<_1>#)[a-zA-Z0-9_-]+/,
        name: "entity.other.attribute-name.id.css"},
       {match: /\*/, name: "entity.name.tag.wildcard.css"},
       {captures: {1 => {name: "punctuation.definition.attribute-name.css"}},
        match: 
         /(?<_1>:)\b(?<_2>active|after|before|first-letter|first-line|hover|link|visited)\b/,
        name: "entity.other.attribute-name.pseudo-class.css"}]},
   :"nested-parens" => 
    {begin: /\(/,
     captures: {0 => {name: "punctuation.section.scope.js"}},
     end: "\\)",
     patterns: [{include: "#nested-parens"}, {include: "source.js"}]}},
 scopeName: "source.js.jquery",
 uuid: "1AD8EB10-62BE-417C-BC4B-29B5C6F0B36A"}
