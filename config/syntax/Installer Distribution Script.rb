# Encoding: UTF-8

{fileTypes: ["dist"],
 foldingStartMarker: 
  /^\s*(<[^!?%\/](?!.+?(\/>|<\/.+?>))|<[!%]--(?!.+?--%?>)|<%[!]?(?!.+?%>))/,
 foldingStopMarker: /^\s*(<\/[^>]+>|[\/%]>|-->)\s*$/,
 keyEquivalent: "^~I",
 name: "Installer Distribution Script",
 patterns: 
  [{begin: /((<)(script)(>))/,
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
           /\b(compareVersions|defaults|gestalt|localizedString(WithFormat)?|localizedStandardString(WithFormat)?|log|propertiesOf|run(Once)?|sysctl|users\.desktopSessionsCount|version)\b/,
          name: "support.function.apple-dist"},
         {begin: /\b(applications)\b/,
          end: "(?=(\\(|\\s))|$",
          name: "support.function.apple-dist",
          patterns: 
           [{match: /\b(fromPID|fromIdentifier|all)\b/,
             name: "support.variable.apple-dist"}]},
         {begin: /\b(files)\b/,
          end: "(?=(\\(|\\s))|$",
          name: "support.function.apple-dist",
          patterns: 
           [{match: /\b(fileExistsAtPath|plistAtPath|bundleAtPath)\b/,
             name: "support.variable.apple-dist"}]},
         {begin: /\b(ioregistry)\b/,
          end: "(?=(\\(|\\s))|$",
          name: "support.function.apple-dist",
          patterns: 
           [{match: /\b(fromPath|matching(Class|Name)|(children|parents)Of)\b/,
             name: "support.variable.apple-dist"}]}]},
      {begin: /\b(choices)\b/,
       end: "(?=(\\(|\\s))|$",
       name: "support.class.apple-dist",
       patterns: 
        [{match: 
           /\b(.*)\.(bundle|customLocation(AllowAlternateVolumes)?|description(-mime-type)?|(start_)?enabled|id|(start_)?selected|tooltip|(start_)?visible|title|packages|packageUpgradeAction)\b/,
          name: "support.variable.apple-dist"}]},
      {begin: /\bmy\b/,
       end: "(?=(\\(|\\s))|$",
       name: "support.class.apple-dist",
       patterns: 
        [{begin: /\b(choice)\b/,
          end: "(?=(\\(|\\s))|$",
          name: "support.function.apple-dist",
          patterns: 
           [{match: 
              /\b(bundle|customLocation(AllowAlternateVolumes)?|description(-mime-type)?|(start_)?enabled|id|(start_)?selected|tooltip|(start_)?visible|title|packages|packageUpgradeAction)\b/,
             name: "support.variable.apple-dist"}]},
         {begin: /\b(result)\b/,
          end: "(?=(\\(|\\s))|$",
          name: "support.function.apple-dist",
          patterns: 
           [{match: /\b(type|title|message)\b/,
             name: "support.variable.apple-dist"}]},
         {begin: /\b(target)\b/,
          end: "(?=(\\(|\\s))|$",
          name: "support.function.apple-dist",
          patterns: 
           [{match: 
              /\b(mountpoint|availableKilobytes|systemVersion|receiptForIdentifier)\b/,
             name: "support.variable.apple-dist"}]}]},
      {include: "source.js"}]},
   {include: "text.xml"}],
 scopeName: "text.xml.apple-dist",
 uuid: "25D29CD3-07B7-44C6-A96A-46CF771130EB"}
