# Encoding: UTF-8

{fileTypes: [],
 keyEquivalent: "^~R",
 name: "R Console (R.app)",
 patterns: 
  [{begin: /^> /,
    beginCaptures: {0 => {name: "punctuation.section.embedded.rapp-console"}},
    end: "\\n|\\z",
    name: "source.r.embedded.rapp-console",
    patterns: [{include: "source.r"}]}],
 scopeName: "source.rapp-console",
 uuid: "F629C7F3-823B-4A4C-8EEE-9971490C5710"}
