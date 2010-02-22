# Encoding: UTF-8

{fileTypes: ["ant.xml", "build.xml"],
 firstLineMatch: "<\\!--\\s*ant\\s*-->",
 foldingStartMarker: 
  /^\s*(?<_1><[^!?%\/](?!.+?(?<_2>\/>|<\/.+?>))|<[!%]--(?!.+?--%?>)|<%[!]?(?!.+?%>))/,
 foldingStopMarker: /^\s*(?<_1><\/[^>]+>|[\/%]>|-->)\s*$/,
 keyEquivalent: "^~A",
 name: "Ant",
 patterns: 
  [{begin: /<[!%]--/,
    captures: {0 => {name: "punctuation.definition.comment.xml.ant"}},
    end: "--%?>",
    name: "comment.block.xml.ant"},
   {begin: /(?<_1><target)\b/,
    captures: {1 => {name: "entity.name.tag.target.xml.ant"}},
    end: "(/?>)",
    name: "meta.tag.target.xml.ant",
    patterns: [{include: "#tagStuff"}]},
   {begin: /(?<_1><macrodef)\b/,
    captures: {1 => {name: "entity.name.tag.macrodef.xml.ant"}},
    end: "(/?>)",
    name: "meta.tag.macrodef.xml.ant",
    patterns: [{include: "#tagStuff"}]},
   {begin: 
     /(?<_1><\/?)(?:(?<_2>[-_a-zA-Z0-9]+)(?<_3>(?<_4>:)))?(?<_5>[-_a-zA-Z0-9:]+)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.xml.ant"},
      2 => {name: "entity.name.tag.namespace.xml.ant"},
      3 => {name: "entity.name.tag.xml.ant"},
      4 => {name: "punctuation.separator.namespace.xml.ant"},
      5 => {name: "entity.name.tag.localname.xml.ant"}},
    end: "(/?>)",
    name: "meta.tag.xml.ant",
    patterns: [{include: "#tagStuff"}]},
   {include: "text.xml"},
   {include: "#javaProperties"},
   {include: "#javaAttributes"}],
 repository: 
  {doublequotedString: 
    {begin: /"/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.string.begin.xml.ant"}},
     end: "\"",
     endCaptures: {0 => {name: "punctuation.definition.string.end.xml.ant"}},
     name: "string.quoted.double.xml.ant",
     patterns: [{include: "#javaAttributes"}, {include: "#javaProperties"}]},
   javaAttributes: 
    {begin: /\@{/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.java-attrib.begin.ant"}},
     end: "}",
     endCaptures: {0 => {name: "punctuation.definition.java-attrib.end.ant"}},
     name: "source.java-attrib.embedded.ant"},
   javaProperties: 
    {begin: /\${/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.java-prop.begin.ant"}},
     end: "}",
     endCaptures: {0 => {name: "punctuation.definition.java-prop.end.ant"}},
     name: "source.java-props.embedded.ant"},
   singlequotedString: 
    {begin: /'/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.string.begin.xml.ant"}},
     end: "'",
     endCaptures: {0 => {name: "punctuation.definition.string.end.xml.ant"}},
     name: "string.quoted.single.xml.ant",
     patterns: [{include: "#javaAttributes"}, {include: "#javaProperties"}]},
   tagStuff: 
    {patterns: 
      [{captures: 
         {1 => {name: "entity.other.attribute-name.namespace.xml.ant"},
          2 => {name: "entity.other.attribute-name.xml.ant"},
          3 => {name: "punctuation.separator.namespace.xml.ant"},
          4 => {name: "entity.other.attribute-name.localname.xml.ant"}},
        match: 
         / (?:(?<_1>[-_a-zA-Z0-9]+)(?<_2>(?<_3>:)))?(?<_4>[_a-zA-Z-]+)=/},
       {include: "#doublequotedString"},
       {include: "#singlequotedString"}]}},
 scopeName: "text.xml.ant",
 uuid: "E1B78601-E584-4A7F-B011-A61710BFE035"}
