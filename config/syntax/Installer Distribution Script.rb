# Encoding: UTF-8

{fileTypes: ["dist"],
 foldingStartMarker: 
  /^\s*(?<_1><[^!?%\/](?!.+?(?<_2>\/>|<\/.+?>))|<[!%]--(?!.+?--%?>)|<%[!]?(?!.+?%>))/,
 foldingStopMarker: /^\s*(?<_1><\/[^>]+>|[\/%]>|-->)\s*$/,
 keyEquivalent: "^~I",
 name: "Installer Distribution Script",
 patterns: 
  [{begin: /(?<_1>(?<_2><)(?<_3>script)(?<_4>>))/,
    captures: 
     {1 => {name: "meta.tag.xml"},
      2 => {name: "punctuation.definition.tag.xml"},
      3 => {name: "entity.name.tag.xml"},
      4 => {name: "punctuation.definition.tag.xml"}},
    end: "((</)(script)(>))",
    name: "source.js.embedded.apple-dist",
    patterns: 
     [{begin: /\bsystem\b/,
       end: "(?=(\\(|\\s))|$",
       name: "support.class.apple-dist",
       patterns: 
        [{match: 
           /\b(?<_1>compareVersions|defaults|gestalt|localizedString(?<_2>WithFormat)?|localizedStandardString(?<_3>WithFormat)?|log|propertiesOf|run(?<_4>Once)?|sysctl|users\.desktopSessionsCount|version)\b/,
          name: "support.function.apple-dist"},
         {begin: /\b(?<_1>applications)\b/,
          end: "(?=(\\(|\\s))|$",
          name: "support.function.apple-dist",
          patterns: 
           [{match: /\b(?<_1>fromPID|fromIdentifier|all)\b/,
             name: "support.variable.apple-dist"}]},
         {begin: /\b(?<_1>files)\b/,
          end: "(?=(\\(|\\s))|$",
          name: "support.function.apple-dist",
          patterns: 
           [{match: /\b(?<_1>fileExistsAtPath|plistAtPath|bundleAtPath)\b/,
             name: "support.variable.apple-dist"}]},
         {begin: /\b(?<_1>ioregistry)\b/,
          end: "(?=(\\(|\\s))|$",
          name: "support.function.apple-dist",
          patterns: 
           [{match: 
              /\b(?<_1>fromPath|matching(?<_2>Class|Name)|(?<_3>children|parents)Of)\b/,
             name: "support.variable.apple-dist"}]}]},
      {begin: /\b(?<_1>choices)\b/,
       end: "(?=(\\(|\\s))|$",
       name: "support.class.apple-dist",
       patterns: 
        [{match: 
           /\b(?<_1>.*)\.(?<_2>bundle|customLocation(?<_3>AllowAlternateVolumes)?|description(?<_4>-mime-type)?|(?<_5>start_)?enabled|id|(?<_6>start_)?selected|tooltip|(?<_7>start_)?visible|title|packages|packageUpgradeAction)\b/,
          name: "support.variable.apple-dist"}]},
      {begin: /\bmy\b/,
       end: "(?=(\\(|\\s))|$",
       name: "support.class.apple-dist",
       patterns: 
        [{begin: /\b(?<_1>choice)\b/,
          end: "(?=(\\(|\\s))|$",
          name: "support.function.apple-dist",
          patterns: 
           [{match: 
              /\b(?<_1>bundle|customLocation(?<_2>AllowAlternateVolumes)?|description(?<_3>-mime-type)?|(?<_4>start_)?enabled|id|(?<_5>start_)?selected|tooltip|(?<_6>start_)?visible|title|packages|packageUpgradeAction)\b/,
             name: "support.variable.apple-dist"}]},
         {begin: /\b(?<_1>result)\b/,
          end: "(?=(\\(|\\s))|$",
          name: "support.function.apple-dist",
          patterns: 
           [{match: /\b(?<_1>type|title|message)\b/,
             name: "support.variable.apple-dist"}]},
         {begin: /\b(?<_1>target)\b/,
          end: "(?=(\\(|\\s))|$",
          name: "support.function.apple-dist",
          patterns: 
           [{match: 
              /\b(?<_1>mountpoint|availableKilobytes|systemVersion|receiptForIdentifier)\b/,
             name: "support.variable.apple-dist"}]}]},
      {include: "source.js"}]},
   {include: "text.xml"}],
 scopeName: "text.xml.apple-dist",
 uuid: "25D29CD3-07B7-44C6-A96A-46CF771130EB"}
