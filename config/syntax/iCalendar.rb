# Encoding: UTF-8

{fileTypes: ["ics", "ifb"],
 foldingStartMarker: /^BEGIN:/,
 foldingStopMarker: /^END:/,
 keyEquivalent: "^~I",
 name: "iCalendar",
 patterns: 
  [{captures: {1 => {name: "entity.name.section.icalendar"}},
    match: /^BEGIN:(.*)/,
    name: "keyword.other.component-begin.icalendar"},
   {captures: {1 => {name: "entity.name.section.icalendar"}},
    match: /^END:(.*)/,
    name: "keyword.other.component-end.icalendar"},
   {match: 
     /\b((0(x|X)[0-9a-fA-F]*)|(([0-9]+\.?[0-9]*)|(\.[0-9]+))((e|E)(\+|-)?[0-9]+)?)(L|l|UL|ul|u|U|F|f)?\b/,
    name: "constant.numeric.icalendar"},
   {begin: /"/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.icalendar"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.icalendar"}},
    name: "string.quoted.double.icalendar"}],
 scopeName: "source.icalendar",
 uuid: "16771FA0-6B1D-11D9-A369-000D93589AF6"}
