# Encoding: UTF-8

{fileTypes: ["ics", "ifb"],
 foldingStartMarker: /^BEGIN:/,
 foldingStopMarker: /^END:/,
 keyEquivalent: "^~I",
 name: "iCalendar",
 patterns: 
  [{captures: {1 => {name: "entity.name.section.icalendar"}},
    match: /^BEGIN:(?<_1>.*)/,
    name: "keyword.other.component-begin.icalendar"},
   {captures: {1 => {name: "entity.name.section.icalendar"}},
    match: /^END:(?<_1>.*)/,
    name: "keyword.other.component-end.icalendar"},
   {match: 
     /\b(?<_1>(?<_2>0(?<_3>x|X)[0-9a-fA-F]*)|(?<_4>(?<_5>[0-9]+\.?[0-9]*)|(?<_6>\.[0-9]+))(?<_7>(?<_8>e|E)(?<_9>\+|-)?[0-9]+)?)(?<_10>L|l|UL|ul|u|U|F|f)?\b/,
    name: "constant.numeric.icalendar"},
   {begin: /"/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.icalendar"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.icalendar"}},
    name: "string.quoted.double.icalendar"}],
 scopeName: "source.icalendar",
 uuid: "16771FA0-6B1D-11D9-A369-000D93589AF6"}
