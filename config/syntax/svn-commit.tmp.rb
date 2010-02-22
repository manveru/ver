# Encoding: UTF-8

{fileTypes: ["svn-commit.tmp", "svn-commit.2.tmp"],
 name: "svn-commit.tmp",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.item.subversion-commit"}},
    match: /^\s*(?<_1>•).*$\n?/,
    name: "meta.bullet-point.strong"},
   {captures: {1 => {name: "punctuation.definition.item.subversion-commit"}},
    match: /^\s*(?<_1>·).*$\n?/,
    name: "meta.bullet-point.light"},
   {captures: {1 => {name: "punctuation.definition.item.subversion-commit"}},
    match: /^\s*(?<_1>\*).*$\n?/,
    name: "meta.bullet-point.star"},
   {begin: 
     /(?<_1>^--(?<_2>This line, and those below, will be ignored| Diese und die folgenden Zeilen werden ignoriert )--$\n?)/,
    beginCaptures: {1 => {name: "meta.separator.svn"}},
    end: "^--not gonna happen--$",
    name: "meta.scope.changed-files.svn",
    patterns: 
     [{match: /^A\s+.*$\n?/, name: "markup.inserted.svn"},
      {match: /^(?<_1>M|.M)\s+.*$\n?/, name: "markup.changed.svn"},
      {match: /^D\s+.*$\n?/, name: "markup.deleted.svn"}]}],
 scopeName: "text.subversion-commit",
 uuid: "5B201F55-90BC-4A69-9A44-1BABE5A9FE99"}
