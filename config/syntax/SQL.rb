# Encoding: UTF-8

{fileTypes: ["sql", "ddl", "dml"],
 foldingStartMarker: /\s*\(\s*$/,
 foldingStopMarker: /^\s*\)/,
 keyEquivalent: "^~S",
 name: "SQL",
 patterns: 
  [{include: "#comments"},
   {captures: 
     {1 => {name: "keyword.other.create.sql"},
      2 => {name: "keyword.other.sql"},
      5 => {name: "entity.name.function.sql"}},
    match: 
     /(?i:^\s*(?<_1>create)\s+(?<_2>aggregate|conversion|database|domain|function|group|(?<_3>unique\s+)?index|language|operator class|operator|rule|schema|sequence|table|tablespace|trigger|type|user|view)\s+)(?<_4>['"`]?)(?<_5>\w+)\k<_4>/,
    name: "meta.create.sql"},
   {captures: 
     {1 => {name: "keyword.other.create.sql"},
      2 => {name: "keyword.other.sql"}},
    match: 
     /(?i:^\s*(?<_1>drop)\s+(?<_2>aggregate|conversion|database|domain|function|group|index|language|operator class|operator|rule|schema|sequence|table|tablespace|trigger|type|user|view))/,
    name: "meta.drop.sql"},
   {captures: 
     {1 => {name: "keyword.other.create.sql"},
      2 => {name: "keyword.other.table.sql"},
      3 => {name: "entity.name.function.sql"},
      4 => {name: "keyword.other.cascade.sql"}},
    match: 
     /(?i:\s*(?<_1>drop)\s+(?<_2>table)\s+(?<_3>\w+)(?<_4>\s+cascade)?\b)/,
    name: "meta.drop.sql"},
   {captures: 
     {1 => {name: "keyword.other.create.sql"},
      2 => {name: "keyword.other.table.sql"}},
    match: 
     /(?i:^\s*(?<_1>alter)\s+(?<_2>aggregate|conversion|database|domain|function|group|index|language|operator class|operator|rule|schema|sequence|table|tablespace|trigger|type|user|view)\s+)/,
    name: "meta.alter.sql"},
   {captures: 
     {1 => {name: "storage.type.sql"},
      10 => {name: "constant.numeric.sql"},
      11 => {name: "storage.type.sql"},
      12 => {name: "storage.type.sql"},
      13 => {name: "storage.type.sql"},
      14 => {name: "constant.numeric.sql"},
      15 => {name: "storage.type.sql"},
      2 => {name: "storage.type.sql"},
      3 => {name: "constant.numeric.sql"},
      4 => {name: "storage.type.sql"},
      5 => {name: "constant.numeric.sql"},
      6 => {name: "storage.type.sql"},
      7 => {name: "constant.numeric.sql"},
      8 => {name: "constant.numeric.sql"},
      9 => {name: "storage.type.sql"}},
    match: 
     /(?xi)

	# normal stuff, capture 1
	 \b(?<_1>bigint|bigserial|bit|boolean|box|bytea|cidr|circle|date|double\sprecision|inet|int|integer|line|lseg|macaddr|money|oid|path|point|polygon|real|serial|smallint|sysdate|text)\b

	# numeric suffix, capture 2 + 3i
	|\b(?<_2>bit\svarying|character\s(?:varying)?|tinyint|var\schar|float|interval)\((?<_3>\d+)\)

	# optional numeric suffix, capture 4 + 5i
	|\b(?<_4>char|number|varchar\d?)\b(?:\((?<_5>\d+)\))?

	# special case, capture 6 + 7i + 8i
	|\b(?<_6>numeric)\b(?:\((?<_7>\d+),(?<_8>\d+)\))?

	# special case, captures 9, 10i, 11
	|\b(?<_9>times)(?:\((?<_10>\d+)\))(?<_11>\swithoutstimeszone\b)?

	# special case, captures 12, 13, 14i, 15
	|\b(?<_12>timestamp)(?:(?<_13>s)\((?<_14>\d+)\)(?<_15>\swithoutstimeszone\b)?)?

	/},
   {match: 
     /(?i:\b(?<_1>(?:primary|foreign)\s+key|references|on\sdelete(?<_2>\s+cascade)?|check|constraint)\b)/,
    name: "storage.modifier.sql"},
   {match: /\b\d+\b/, name: "constant.numeric.sql"},
   {match: 
     /(?i:\b(?<_1>select(?<_2>\s+distinct)?|insert\s+(?<_3>ignore\s+)?into|update|delete|from|set|where|group\sby|or|like|and|union(?<_4>\s+all)?|having|order\sby|limit|(?<_5>inner|cross)\s+join|join|straight_join|(?<_6>left|right)(?<_7>\s+outer)?\s+join|natural(?<_8>\s+(?<_9>left|right)(?<_10>\s+outer)?)?\s+join)\b)/,
    name: "keyword.other.DML.sql"},
   {match: /(?i:\b(?<_1>on|(?<_2>(?<_3>is\s+)?not\s+)?null)\b)/,
    name: "keyword.other.DDL.create.II.sql"},
   {match: /(?i:\bvalues\b)/, name: "keyword.other.DML.II.sql"},
   {match: 
     /(?i:\b(?<_1>begin(?<_2>\s+work)?|start\s+transaction|commit(?<_3>\s+work)?|rollback(?<_4>\s+work)?)\b)/,
    name: "keyword.other.LUW.sql"},
   {match: /(?i:\b(?<_1>grant(?<_2>\swith\sgrant\soption)?|revoke)\b)/,
    name: "keyword.other.authorization.sql"},
   {match: /(?i:\bin\b)/, name: "keyword.other.data-integrity.sql"},
   {match: 
     /(?i:^\s*(?<_1>comment\s+on\s+(?<_2>table|column|aggregate|constraint|database|domain|function|index|operator|rule|schema|sequence|trigger|type|view))\s+.*?\s+(?<_3>is)\s+)/,
    name: "keyword.other.object-comments.sql"},
   {match: /(?i)\bAS\b/, name: "keyword.other.alias.sql"},
   {match: /(?i)\b(?<_1>DESC|ASC)\b/, name: "keyword.other.order.sql"},
   {match: /\*/, name: "keyword.operator.star.sql"},
   {match: /[!<>]?=|<>|<|>/, name: "keyword.operator.comparison.sql"},
   {match: /-|\+|\//, name: "keyword.operator.math.sql"},
   {match: /\|\|/, name: "keyword.operator.concatenator.sql"},
   {comment: 
     "List of SQL99 built-in functions from http://www.oreilly.com/catalog/sqlnut/chapter/ch04.html",
    match: 
     /(?i)\b(?<_1>CURRENT_(?<_2>DATE|TIME(?<_3>STAMP)?|USER)|(?<_4>SESSION|SYSTEM)_USER)\b/,
    name: "support.function.scalar.sql"},
   {comment: 
     "List of SQL99 built-in functions from http://www.oreilly.com/catalog/sqlnut/chapter/ch04.html",
    match: /(?i)\b(?<_1>AVG|COUNT|MIN|MAX|SUM)(?=\s*\()/,
    name: "support.function.aggregate.sql"},
   {match: 
     /(?i)\b(?<_1>CONCATENATE|CONVERT|LOWER|SUBSTRING|TRANSLATE|TRIM|UPPER)\b/,
    name: "support.function.string.sql"},
   {captures: 
     {1 => {name: "constant.other.database-name.sql"},
      2 => {name: "constant.other.table-name.sql"}},
    match: /(?<_1>\w+?)\.(?<_2>\w+)/},
   {include: "#strings"},
   {include: "#regexps"}],
 repository: 
  {comments: 
    {patterns: 
      [{captures: {1 => {name: "punctuation.definition.comment.sql"}},
        match: /(?<_1>--).*$\n?/,
        name: "comment.line.double-dash.sql"},
       {captures: {1 => {name: "punctuation.definition.comment.sql"}},
        match: /(?<_1>#).*$\n?/,
        name: "comment.line.number-sign.sql"},
       {begin: /\/\*/,
        captures: {0 => {name: "punctuation.definition.comment.sql"}},
        end: "\\*/",
        name: "comment.block.c"}]},
   regexps: 
    {patterns: 
      [{begin: /\/(?=\S.*\/)/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.sql"}},
        end: "/",
        endCaptures: {0 => {name: "punctuation.definition.string.end.sql"}},
        name: "string.regexp.sql",
        patterns: 
         [{include: "#string_interpolation"},
          {match: /\\\//, name: "constant.character.escape.slash.sql"}]},
       {begin: /%r\{/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.sql"}},
        comment: "We should probably handle nested bracket pairs!?! -- Allan",
        end: "\\}",
        endCaptures: {0 => {name: "punctuation.definition.string.end.sql"}},
        name: "string.regexp.modr.sql",
        patterns: [{include: "#string_interpolation"}]}]},
   string_escape: {match: /\\./, name: "constant.character.escape.sql"},
   string_interpolation: 
    {captures: {1 => {name: "punctuation.definition.string.end.sql"}},
     match: /(?<_1>#\{)(?<_2>[^\}]*)(?<_3>\})/,
     name: "string.interpolated.sql"},
   strings: 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.string.begin.sql"},
          3 => {name: "punctuation.definition.string.end.sql"}},
        comment: 
         "this is faster than the next begin/end rule since sub-pattern will match till end-of-line and SQL files tend to have very long lines.",
        match: /(?<_1>')[^'\\]*(?<_2>')/,
        name: "string.quoted.single.sql"},
       {begin: /'/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.sql"}},
        end: "'",
        endCaptures: {0 => {name: "punctuation.definition.string.end.sql"}},
        name: "string.quoted.single.sql",
        patterns: [{include: "#string_escape"}]},
       {captures: 
         {1 => {name: "punctuation.definition.string.begin.sql"},
          3 => {name: "punctuation.definition.string.end.sql"}},
        comment: 
         "this is faster than the next begin/end rule since sub-pattern will match till end-of-line and SQL files tend to have very long lines.",
        match: /(?<_1>`)[^`\\]*(?<_2>`)/,
        name: "string.quoted.other.backtick.sql"},
       {begin: /`/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.sql"}},
        end: "`",
        endCaptures: {0 => {name: "punctuation.definition.string.end.sql"}},
        name: "string.quoted.other.backtick.sql",
        patterns: [{include: "#string_escape"}]},
       {captures: 
         {1 => {name: "punctuation.definition.string.begin.sql"},
          3 => {name: "punctuation.definition.string.end.sql"}},
        comment: 
         "this is faster than the next begin/end rule since sub-pattern will match till end-of-line and SQL files tend to have very long lines.",
        match: /(?<_1>")[^"#]*(?<_2>")/,
        name: "string.quoted.double.sql"},
       {begin: /"/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.sql"}},
        end: "\"",
        endCaptures: {0 => {name: "punctuation.definition.string.end.sql"}},
        name: "string.quoted.double.sql",
        patterns: [{include: "#string_interpolation"}]},
       {begin: /%\{/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.sql"}},
        end: "\\}",
        endCaptures: {0 => {name: "punctuation.definition.string.end.sql"}},
        name: "string.other.quoted.brackets.sql",
        patterns: [{include: "#string_interpolation"}]}]}},
 scopeName: "source.sql",
 uuid: "C49120AC-6ECC-11D9-ACC8-000D93589AF6"}
