# Encoding: UTF-8

{fileTypes: ["json"],
 foldingStartMarker: 
  /(?x:       # turn on extended mode
                          ^        # a line beginning with
                          \s*      # some optional space
                          [{\[]    # the start of an object or array
                          (?!      # but not followed by
                            .*     # whatever
                            [}\]]  # and the close of an object or array
                            ,?     # an optional comma
                            \s*    # some optional space
                            $      # at the end of the line
                          )
                          |        # ...or...
                          [{\[]    # the start of an object or array
                          \s*      # some optional space
                          $        # at the end of the line
                        )/,
 foldingStopMarker: 
  /(?x:     # turn on extended mode
                         ^      # a line beginning with
                         \s*    # some optional space
                         [}\]]  # and the close of an object or array
                       )/,
 keyEquivalent: "^~J",
 name: "JSON",
 patterns: [{include: "#value"}],
 repository: 
  {array: 
    {begin: /\[/,
     beginCaptures: {0 => {name: "punctuation.definition.array.begin.json"}},
     end: "\\]",
     endCaptures: {0 => {name: "punctuation.definition.array.end.json"}},
     name: "meta.structure.array.json",
     patterns: 
      [{include: "#value"},
       {match: /,/, name: "punctuation.separator.array.json"},
       {match: /[^\s\]]/,
        name: "invalid.illegal.expected-array-separator.json"}]},
   constant: 
    {match: /\b(?:true|false|null)\b/, name: "constant.language.json"},
   number: 
    {comment: "handles integer and decimal numbers",
     match: 
      /(?x:         # turn on extended mode
                 -?         # an optional minus
                 (?:
                   0        # a zero
                   |        # ...or...
                   [1-9]    # a 1-9 character
                   \d*      # followed by zero or more digits
                 )
                 (?:
                   \.       # a period
                   \d+      # followed by one or more digits
                   (?:
                     [eE]   # an e character
                     [+-]?  # followed by an option +\/-
                     \d+    # followed by one or more digits
                   )?       # make exponent optional
                 )?         # make decimal portion optional
               )/,
     name: "constant.numeric.json"},
   object: 
    {begin: /\{/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.dictionary.begin.json"}},
     comment: "a JSON object",
     end: "\\}",
     endCaptures: {0 => {name: "punctuation.definition.dictionary.end.json"}},
     name: "meta.structure.dictionary.json",
     patterns: 
      [{comment: "the JSON object key", include: "#string"},
       {begin: /:/,
        beginCaptures: 
         {0 => {name: "punctuation.separator.dictionary.key-value.json"}},
        end: "(,)|(?=\\})",
        endCaptures: 
         {1 => {name: "punctuation.separator.dictionary.pair.json"}},
        name: "meta.structure.dictionary.value.json",
        patterns: 
         [{comment: "the JSON object value", include: "#value"},
          {match: /[^\s,]/,
           name: "invalid.illegal.expected-dictionary-separator.json"}]},
       {match: /[^\s\}]/,
        name: "invalid.illegal.expected-dictionary-separator.json"}]},
   string: 
    {begin: /"/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.json"}},
     end: "\"",
     endCaptures: {0 => {name: "punctuation.definition.string.end.json"}},
     name: "string.quoted.double.json",
     patterns: 
      [{match: 
         /(?x:                # turn on extended mode
                     \\                # a literal backslash
                     (?:               # ...followed by...
                       ["\\\/bfnrt]     # one of these characters
                       |               # ...or...
                       u               # a u
                       [0-9a-fA-F]{4}  # and four hex digits
                     )
                   )/,
        name: "constant.character.escape.json"},
       {match: /\\./,
        name: "invalid.illegal.unrecognized-string-escape.json"}]},
   value: 
    {comment: "the 'value' diagram at http://json.org",
     patterns: 
      [{include: "#constant"},
       {include: "#number"},
       {include: "#string"},
       {include: "#array"},
       {include: "#object"}]}},
 scopeName: "source.json",
 uuid: "0C3868E4-F96B-4E55-B204-1DCB5A20748B"}
