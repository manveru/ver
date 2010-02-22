# Encoding: UTF-8

{fileTypes: ["man"],
 foldingStartMarker: /^[A-Z](?:(?:\S+\s\S+)+|\S+)$/,
 foldingStopMarker: /^_{2,}$/,
 name: "Man",
 patterns: 
  [{match: /^[A-Z](?:(?:\S+\s\S+)+|\S+)$/, name: "markup.heading.man"},
   {match: 
     /(?<_1>(?<_2>https?|ftp|file|txmt):\/\/|mailto:)[-:@a-zA-Z0-9_.~%+\/?=&#]+(?<![.?:])/,
    name: "markup.underline.link.man"},
   {match: /(?<_1>[\w\.]+\(\d[a-z]?\))/,
    name: "markup.underline.link.internal.man"},
   {match: /^_{2,}$/, name: "meta.foldingStopMarker.man"}],
 scopeName: "text.man",
 uuid: "E8BAC30A-16BF-498D-941D-73FBAED37891"}
