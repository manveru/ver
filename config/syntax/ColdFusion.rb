# Encoding: UTF-8

{fileTypes: ["cfm", "cfml", "cfc"],
 foldingStartMarker: 
  /(?x)
	(?<_1><(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl|cfloop|cfif|cfswitch|cfcomponent)\b.*?>
	|<!---(?!.*---\s*>)
	)/,
 foldingStopMarker: 
  /(?x)
	(?<_1><\/(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl|cfloop|cfif|cfswitch|cfcomponent)>
	|^(?!.*?<!---).*?---\s*>
	)/,
 keyEquivalent: "^~C",
 name: "ColdFusion",
 patterns: 
  [{begin: /(?:^\s+)?<(?<_1>(?i:cfoutput))\b(?![^>]*\/>)/,
    captures: {1 => {name: "entity.name.tag.cfoutput.cfm"}},
    end: "</((?i:cfoutput))>(?:\\s*\\n)?",
    name: "meta.tag.cfoutput.cfm",
    patterns: 
     [{include: "#tag-stuff"},
      {begin: />/,
       contentName: "meta.scope.output.cfm",
       end: "(?=</(?i:cfoutput))",
       patterns: [{include: "$self"}]}]},
   {begin: /(?:^\s+)?<(?<_1>(?i:cfquery))\b(?![^>]*\/>)/,
    captures: {1 => {name: "entity.name.tag.cfquery.cfm"}},
    end: "</((?i:cfquery))>(?:\\s*\\n)?",
    name: "meta.tag.cfquery.cfm",
    patterns: 
     [{include: "#tag-stuff"},
      {begin: /(?<=>)/,
       end: "(?=</(?i:cfquery))",
       name: "source.sql.embedded",
       patterns: [{include: "source.sql"}]}]},
   {begin: /<\/?(?<_1>(?i:cf)(?<_2>[a-zA-Z0-9]+))(?=[^>]*>)/,
    beginCaptures: {1 => {name: "entity.name.tag.cfm"}},
    end: ">",
    name: "meta.tag.any.cfm",
    patterns: [{include: "#tag-stuff"}]},
   {include: "#coldfusion-comment"},
   {include: "text.html.basic"}],
 repository: 
  {:"coldfusion-comment" => 
    {begin: /<!---/,
     end: "--->",
     name: "comment.block.cfm",
     patterns: [{include: "#coldfusion-comment"}]},
   :"embedded-code" => {patterns: []},
   entities: 
    {patterns: 
      [{match: /&(?<_1>[a-zA-Z0-9]+|#[0-9]+|#x[0-9a-fA-F]+);/,
        name: "constant.character.entity.html"},
       {match: /&/, name: "invalid.illegal.bad-ampersand.html"}]},
   :"string-double-quoted" => 
    {begin: /"/,
     end: "\"",
     name: "string.quoted.double.cfm",
     patterns: [{include: "#embedded-code"}, {include: "#entities"}]},
   :"string-single-quoted" => 
    {begin: /'/,
     end: "'",
     name: "string.quoted.single.cfm",
     patterns: [{include: "#embedded-code"}, {include: "#entities"}]},
   :"tag-generic-attribute" => 
    {match: /\b(?<_1>[a-zA-Z\-:]+)/, name: "entity.other.attribute-name.cfm"},
   :"tag-id-attribute" => 
    {begin: /\b(?<_1>id)\b\s*=/,
     captures: {1 => {name: "entity.other.attribute-name.id.html"}},
     end: "(?<='|\")",
     name: "meta.attribute-with-value.id.cfm",
     patterns: 
      [{begin: /"/,
        contentName: "meta.toc-list.id.cfm",
        end: "\"",
        name: "string.quoted.double.cfm",
        patterns: [{include: "#embedded-code"}, {include: "#entities"}]},
       {begin: /'/,
        contentName: "meta.toc-list.id.cfm",
        end: "'",
        name: "string.quoted.single.cfm",
        patterns: [{include: "#embedded-code"}, {include: "#entities"}]}]},
   :"tag-stuff" => 
    {patterns: 
      [{include: "#tag-id-attribute"},
       {include: "#tag-generic-attribute"},
       {include: "#string-double-quoted"},
       {include: "#string-single-quoted"},
       {include: "#embedded-code"}]}},
 scopeName: "text.html.cfm",
 uuid: "97CAD6F7-0807-4EB4-876E-DA9E9C1CEC14"}
