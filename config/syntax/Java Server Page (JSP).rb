# Encoding: UTF-8

{fileTypes: ["jsp"],
 foldingStartMarker: /\/\*\*|\{\s*$/,
 foldingStopMarker: /\*\*\/|^\s*\}/,
 keyEquivalent: "^~J",
 name: "Java Server Page (JSP)",
 patterns: 
  [{begin: /<%--/,
    captures: {0 => {name: "punctuation.definition.comment.jsp"}},
    end: "--%>",
    name: "comment.block.jsp"},
   {begin: /<%@/,
    captures: {0 => {name: "punctuation.section.directive.jsp"}},
    end: "%>",
    name: "meta.directive.jsp",
    patterns: 
     [{begin: /\w+/,
       beginCaptures: {0 => {name: "keyword.other.directive.jsp"}},
       end: "(?=%>)",
       patterns: 
        [{match: /\w+/, name: "constant.other.directive.attribute.jsp"},
         {match: /=/, name: "keyword.operator.assignment.jsp"},
         {begin: /"/,
          beginCaptures: 
           {0 => {name: "punctuation.definition.string.begin.jsp"}},
          end: "\"",
          endCaptures: {0 => {name: "punctuation.definition.string.end.jsp"}},
          name: "string.quoted.double.jsp",
          patterns: [{match: /\\./, name: "constant.character.escape.jsp"}]},
         {begin: /'/,
          beginCaptures: 
           {0 => {name: "punctuation.definition.string.begin.jsp"}},
          end: "'",
          endCaptures: {0 => {name: "punctuation.definition.string.end.jsp"}},
          name: "string.quoted.single.jsp",
          patterns: 
           [{match: /\\./, name: "constant.character.escape.jsp"}]}]}]},
   {begin: 
     /(?<_1><%[!=]?)|(?<_2><jsp:scriptlet>|<jsp:expression>|<jsp:declaration>)/,
    beginCaptures: 
     {1 => {name: "punctuation.section.embedded.jsp"},
      2 => {name: "meta.tag.block.jsp"}},
    end: "(?<=</jsp:scriptlet>|</jsp:expression>|</jsp:declaration>|%>)",
    patterns: 
     [{captures: 
        {1 => {name: "meta.tag.block.jsp"},
         2 => {name: "punctuation.section.embedded.jsp"}},
       match: 
        /(?<_1><\/jsp:scriptlet>|<\/jsp:expression>|<\/jsp:declaration>)|(?<_2>%>)/},
      {begin: 
        /(?<!\n)(?!<\/jsp:scriptlet>|<\/jsp:expression>|<\/jsp:declaration>|%>|\{|\})/,
       end: 
        "(?=</jsp:scriptlet>|</jsp:expression>|</jsp:declaration>|%>|\\{|\\})|\\n",
       name: "source.java.embedded.html",
       patterns: [{include: "source.java"}]},
      {begin: /{/,
       end: "}",
       patterns: 
        [{begin: 
           /(?<_1><\/jsp:scriptlet>|<\/jsp:expression>|<\/jsp:declaration>)|(?<_2>%>)/,
          captures: 
           {1 => {name: "meta.tag.block.jsp"},
            2 => {name: "punctuation.section.embedded.jsp"}},
          end: 
           "(<jsp:scriptlet>|<jsp:expression>|<jsp:declaration>)|(<%[!=]?)",
          patterns: [{include: "text.html.jsp"}]},
         {include: "source.java"}]},
      {include: "source.java"}]},
   {include: "text.html.basic"}],
 scopeName: "text.html.jsp",
 uuid: "ACB58B55-9437-4AE6-AF42-854995CF51DF"}
