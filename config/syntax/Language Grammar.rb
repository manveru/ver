# Encoding: UTF-8

{fileTypes: ["textmate"],
 firstLineMatch: "^\\{\\s*scopeName = .*$",
 foldingStartMarker: /^\s*([a-zA-Z_-]+ = )?[{(](?!.*[)}][;,]?\s*$)/,
 foldingStopMarker: /^\s*(\}|\))/,
 keyEquivalent: "^~L",
 name: "Language Grammar",
 patterns: 
  [{begin: /(\{)/,
    captures: {1 => {name: "punctuation.section.dictionary.tm-grammar"}},
    end: "(\\})",
    patterns: 
     [{include: "#comment"},
      {begin: /\b(scopeName)\s*(=)/,
       beginCaptures: 
        {1 => {name: "support.constant.tm-grammar"},
         2 => {name: "punctuation.section.dictionary.tm-grammar"}},
       comment: "scopeName",
       end: "(;)",
       endCaptures: {1 => {name: "punctuation.section.dictionary.tm-grammar"}},
       name: "meta.value-pair.scopename.tm-grammar",
       patterns: 
        [{include: "#comment"},
         {include: "#scope-root"},
         {include: "#catch-all"}]},
      {begin: /\b(fileTypes)\s*(=)/,
       beginCaptures: 
        {1 => {name: "support.constant.tm-grammar"},
         2 => {name: "punctuation.separator.key-value.tm-grammar"}},
       comment: "fileTypes",
       end: "(;)",
       endCaptures: 
        {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
       patterns: 
        [{begin: /(\()/,
          captures: {1 => {name: "punctuation.section.array.tm-grammar"}},
          end: "(\\))",
          patterns: 
           [{include: "#comment"},
            {begin: /(?=[^\s,])/,
             end: "(,)|(?=\\))",
             endCaptures: 
              {1 => {name: "punctuation.separator.array.tm-grammar"}},
             patterns: 
              [{include: "#comment"},
               {match: /\s+(?=\/\/|\/\*)/},
               {begin: /[[^\n]&&\s](?!\s*(,|\)|$)).*/,
                end: "^$not possible$^",
                name: "invalid.illegal.missing-comma.tm-grammar"},
               {include: "#string"}]},
            {include: "#catch-all"}]}]},
      {begin: /\b(firstLineMatch|folding(Start|Stop)Marker)\s*(=)/,
       beginCaptures: 
        {1 => {name: "support.constant.tm-grammar"},
         3 => {name: "punctuation.separator.key-value.tm-grammar"}},
       comment: "firstLineMatch, foldingStartMarker, foldingStopMarker",
       end: "(;)",
       endCaptures: 
        {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
       patterns: 
        [{include: "#comment"},
         {include: "#regexp"},
         {include: "#catch-all"}]},
      {include: "#patterns"},
      {begin: /\b(repository)\s*(=)/,
       beginCaptures: 
        {1 => {name: "support.constant.repository.tm-grammar"},
         2 => {name: "punctuation.separator.key-value.tm-grammar"}},
       comment: "repository",
       end: "(;)",
       endCaptures: 
        {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
       name: "meta.dictionary.repository.tm-grammar",
       patterns: 
        [{begin: /(\{)/,
          captures: {1 => {name: "punctuation.section.dictionary.tm-grammar"}},
          end: "(\\})",
          patterns: 
           [{include: "#comment"},
            {begin: /(["']?)([-a-zA-Z0-9._]+)\1\s*(=)/,
             beginCaptures: 
              {2 => {name: "entity.name.section.repository.tm-grammar"},
               3 => {name: "punctuation.separator.key-value.tm-grammar"}},
             end: "(;)",
             endCaptures: 
              {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
             name: "meta.value-pair.repository-item.tm-grammar",
             patterns: 
              [{include: "#comment"},
               {include: "#rule"},
               {include: "#catch-all"}]},
            {include: "#string"},
            {begin: /(=)/,
             beginCaptures: 
              {1 => {name: "punctuation.separator.key-value.tm-grammar"}},
             end: "(;)",
             endCaptures: 
              {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
             patterns: [{include: "#any"}]},
            {match: /;/, name: "punctuation.terminator.dictionary.tm-grammar"},
            {include: "#catch-all"}]}]},
      {include: "#comment-keyword"},
      {include: "#invalid-keyword"},
      {include: "#string"},
      {begin: /(=)/,
       beginCaptures: 
        {1 => {name: "punctuation.separator.key-value.tm-grammar"}},
       end: "(;)",
       endCaptures: 
        {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
       patterns: [{include: "#any"}]},
      {match: /;/, name: "punctuation.terminator.dictionary.tm-grammar"},
      {include: "#catch-all"}]}],
 repository: 
  {any: 
    {patterns: 
      [{include: "#comment"},
       {include: "#string"},
       {include: "#array"},
       {include: "#dictionary"},
       {include: "#catch-all"}]},
   array: 
    {begin: /(\()/,
     captures: {1 => {name: "punctuation.section.array.tm-grammar"}},
     end: "(\\))",
     patterns: 
      [{include: "#comment"},
       {begin: /(?=[^\s,])/,
        end: "(,)|(?=\\))",
        endCaptures: {1 => {name: "punctuation.separator.array.tm-grammar"}},
        patterns: 
         [{include: "#comment"},
          {match: /\s+(?=\/\/|\/\*)/},
          {begin: /[[^\n]&&\s](?!\s*(,|\)|$)).*/,
           end: "^$not possible$^",
           name: "invalid.illegal.missing-comma.tm-grammar"},
          {include: "#any"}]},
       {include: "#catch-all"}]},
   :"catch-all" => 
    {patterns: 
      [{match: /\s+/},
       {match: /./,
        name: "invalid.illegal.unrecognized-character.tm-grammar"}]},
   comment: 
    {patterns: 
      [{begin: /\/\*/, end: "\\*/", name: "comment.block.tm-grammar"},
       {match: /\/\/.*$\n?/, name: "comment.line.double-slash.tm-grammar"}]},
   :"comment-keyword" => 
    {begin: /\b(comment)\s*(=)/,
     beginCaptures: 
      {1 => {name: "support.constant.tm-grammar"},
       2 => {name: "punctuation.separator.key-value.tm-grammar"}},
     end: "(;)",
     endCaptures: 
      {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
     patterns: 
      [{include: "#comment"},
       {applyEndPatternLast: 1,
        begin: /(')/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.tm-grammar"}},
        contentName: "comment.block.string.tm-grammar",
        end: "(')(?!')",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.tm-grammar"}},
        name: "string.quoted.single.tm-grammar",
        patterns: 
         [{match: /''/,
           name: "constant.character.escape.apostrophe.tm-grammar"}]},
       {begin: /(")/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.tm-grammar"}},
        contentName: "comment.block.string.tm-grammar",
        end: "(\")",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.tm-grammar"}},
        name: "string.quoted.double.tm-grammar",
        patterns: 
         [{match: /\\[\\"]/, name: "constant.character.escape.tm-grammar"}]},
       {include: "#catch-all"}]},
   dictionary: 
    {begin: /(\{)/,
     captures: {1 => {name: "punctuation.section.dictionary.tm-grammar"}},
     end: "(\\})",
     patterns: 
      [{include: "#comment"},
       {include: "#string"},
       {begin: /(=)/,
        beginCaptures: 
         {1 => {name: "punctuation.separator.key-value.tm-grammar"}},
        end: "(;)",
        endCaptures: 
         {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
        patterns: [{include: "#any"}]},
       {match: /;/, name: "punctuation.terminator.dictionary.tm-grammar"},
       {include: "#catch-all"}]},
   :"invalid-keyword" => 
    {patterns: 
      [{match: 
         /\b(fileTypes|foldingStartMarker|foldingStopMarker|patterns|match|begin|end|include|scopeName|captures|beginCaptures|endCaptures|firstLineMatch|comment|repository|disabled|contentName|applyEndPatternLast)\b(?=\s*=)/,
        name: "invalid.illegal.constant.misplaced-keyword.tm-grammar"},
       {match: /\b(swallow|mode)\b(?=\s*=)/,
        name: "invalid.deprecated.constant.tm-grammar"},
       {match: 
         /\b(foregroundColor|backgroundColor|fontStyle|elementForegroundColor|elementBackgroundColor|elementFontStyle|highlightPairs|smartTypingPairs|increaseIndentPattern)\b(?=\s*=)/,
        name: "invalid.illegal.constant.outdated.tm-grammar"},
       {match: /[-a-zA-Z_.]+(?=\s*=)/,
        name: "invalid.illegal.constant.unknown-keyword.tm-grammar"}]},
   patterns: 
    {begin: /\b(patterns)\s*(=)/,
     beginCaptures: 
      {1 => {name: "support.constant.tm-grammar"},
       2 => {name: "punctuation.separator.key-value.tm-grammar"}},
     end: "(;)",
     endCaptures: 
      {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
     name: "meta.array.patterns.tm-grammar",
     patterns: 
      [{include: "#comment"},
       {begin: /(\()/,
        captures: {1 => {name: "punctuation.section.array.tm-grammar"}},
        end: "(\\))",
        patterns: 
         [{include: "#comment"},
          {begin: /(?=[^\s,])/,
           end: "(,)|(?=\\))",
           endCaptures: 
            {1 => {name: "punctuation.separator.array.tm-grammar"}},
           patterns: 
            [{include: "#comment"},
             {match: /\s+(?=\/\/|\/\*)/},
             {begin: /[[^\n]&&\s](?!\s*(,|\)|$)).*/,
              end: "^$not possible$^",
              name: "invalid.illegal.missing-comma.tm-grammar"},
             {include: "#rule"},
             {include: "#catch-all"}]},
          {include: "#catch-all"}]},
       {include: "#catch-all"}]},
   regexp: 
    {patterns: 
      [{begin: /(')/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.tm-grammar"}},
        end: "(')(?!')",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.tm-grammar"}},
        name: "string.regexp.oniguruma.single.tm-grammar",
        patterns: 
         [{match: /''/,
           name: "constant.character.escape.apostrophe.tm-grammar"},
          {include: "source.regexp.oniguruma"}]},
       {begin: /(")/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.tm-grammar"}},
        end: "(\")",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.tm-grammar"}},
        name: "string.regexp.oniguruma.double.tm-grammar",
        patterns: 
         [{match: /\\\\|\\"/, name: "constant.character.escape.tm-grammar"},
          {include: "source.regexp.oniguruma"}]}]},
   rule: 
    {begin: /(\{)/,
     captures: {1 => {name: "punctuation.section.dictionary.tm-grammar"}},
     end: "(\\})",
     name: "meta.dictionary.rule.tm-grammar",
     patterns: 
      [{include: "#comment"},
       {begin: /\b((contentN|n)ame)\s*(=)/,
        beginCaptures: 
         {1 => {name: "support.constant.tm-grammar"},
          3 => {name: "punctuation.separator.key-value.tm-grammar"}},
        comment: "name, contentName",
        end: "(;)",
        endCaptures: 
         {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
        name: "meta.value-pair.tm-grammar",
        patterns: 
         [{include: "#comment"},
          {include: "#scope"},
          {include: "#catch-all"}]},
       {begin: /\b(begin|end|while|match)\s*(=)/,
        beginCaptures: 
         {1 => {name: "support.constant.tm-grammar"},
          2 => {name: "punctuation.separator.key-value.tm-grammar"}},
        comment: "begin, end, while, match",
        end: "(;)",
        endCaptures: 
         {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
        patterns: 
         [{include: "#comment"},
          {include: "#regexp"},
          {include: "#catch-all"}]},
       {begin: /\b(include)\s*(=)/,
        beginCaptures: 
         {1 => {name: "support.constant.tm-grammar"},
          2 => {name: "punctuation.separator.key-value.tm-grammar"}},
        comment: "include",
        end: "(;)",
        endCaptures: 
         {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
        patterns: 
         [{include: "#comment"},
          {captures: 
            {1 => {name: "punctuation.definition.string.begin.tm-grammar"},
             2 => 
              {name: "constant.other.reference.repository-item.tm-grammar"},
             3 => {name: "punctuation.definition.constant.tm-grammar"},
             4 => {name: "constant.other.reference.grammar.tm-grammar"},
             5 => {name: "punctuation.definition.constant.tm-grammar"},
             6 => {name: "punctuation.definition.string.end.tm-grammar"}},
           match: /(')(?:((#)[-a-zA-Z0-9._]+)|((\$)(?:base|self)))?(')/,
           name: "string.quoted.single.include.tm-grammar"},
          {captures: 
            {1 => {name: "punctuation.definition.string.begin.tm-grammar"},
             2 => 
              {name: "constant.other.reference.repository-item.tm-grammar"},
             3 => {name: "punctuation.definition.constant.tm-grammar"},
             4 => {name: "constant.other.reference.grammar.tm-grammar"},
             5 => {name: "punctuation.definition.constant.tm-grammar"},
             6 => {name: "punctuation.definition.string.end.tm-grammar"}},
           match: /(')(?:((#)[-a-zA-Z0-9._]+)|((\$)(?:base|self)))?(')/,
           name: "string.quoted.double.include.tm-grammar"},
          {include: "#scope-root"},
          {include: "#catch-all"}]},
       {begin: /\b((beginC|endC|whileC|c)aptures)\s*(=)/,
        beginCaptures: 
         {1 => {name: "support.constant.tm-grammar"},
          3 => {name: "punctuation.separator.key-value.tm-grammar"}},
        comment: "captures",
        end: "(;)",
        endCaptures: 
         {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
        name: "meta.dictionary.captures.tm-grammar",
        patterns: 
         [{begin: /(\{)/,
           captures: 
            {1 => {name: "punctuation.section.dictionary.tm-grammar"}},
           end: "(\\})",
           patterns: 
            [{include: "#comment"},
             {include: "#string"},
             {begin: /(=)/,
              beginCaptures: 
               {1 => {name: "punctuation.separator.key-value.tm-grammar"}},
              end: "(;)",
              endCaptures: 
               {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
              patterns: 
               [{include: "#comment"},
                {begin: /(\{)/,
                 captures: 
                  {1 => {name: "punctuation.section.dictionary.tm-grammar"}},
                 end: "(\\})",
                 patterns: 
                  [{include: "#comment"},
                   {include: "#comment-keyword"},
                   {begin: /\b(name)\s*(=)/,
                    beginCaptures: 
                     {1 => {name: "support.constant.tm-grammar"},
                      2 => 
                       {name: "punctuation.separator.key-value.tm-grammar"}},
                    comment: "name",
                    end: "(;)",
                    endCaptures: 
                     {1 => 
                       {name: "punctuation.terminator.dictionary.tm-grammar"}},
                    name: "meta.value-pair.tm-grammar",
                    patterns: 
                     [{include: "#comment"},
                      {include: "#scope"},
                      {include: "#catch-all"}]}]},
                {include: "#catch-all"}]},
             {match: /;/,
              name: "punctuation.terminator.dictionary.tm-grammar"},
             {include: "#catch-all"}]}]},
       {captures: 
         {1 => {name: "support.constant.tm-grammar"},
          10 => {name: "constant.numeric.tm-grammar"},
          11 => {name: "punctuation.definition.string.end.tm-grammar"},
          12 => {name: "punctuation.terminator.dictionary.tm-grammar"},
          2 => {name: "punctuation.separator.key-value.tm-grammar"},
          3 => {name: "constant.numeric.tm-grammar"},
          4 => {name: "string.quoted.double.tm-grammar"},
          5 => {name: "punctuation.definition.string.begin.tm-grammar"},
          6 => {name: "constant.numeric.tm-grammar"},
          7 => {name: "punctuation.definition.string.end.tm-grammar"},
          8 => {name: "string.quoted.single.tm-grammar"},
          9 => {name: "punctuation.definition.string.begin.tm-grammar"}},
        comment: "disabled, applyEndPatternLast",
        match: 
         /\b(disabled|applyEndPatternLast)\s*(=)\s*(?:(0|1)|((")(0|1)("))|((')(0|1)(')))\s*(;)/},
       {include: "#patterns"},
       {include: "#comment-keyword"},
       {include: "#invalid-keyword"},
       {include: "#string"},
       {begin: /(=)/,
        beginCaptures: 
         {1 => {name: "punctuation.separator.key-value.tm-grammar"}},
        end: "(;)",
        endCaptures: 
         {1 => {name: "punctuation.terminator.dictionary.tm-grammar"}},
        patterns: [{include: "#any"}]},
       {match: /;/, name: "punctuation.terminator.dictionary.tm-grammar"},
       {include: "#catch-all"}]},
   scope: 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.string.begin.tm-grammar"},
          2 => {name: "constant.other.scope.tm-grammar"},
          3 => {name: "constant.other.scope.tm-grammar"},
          4 => {name: "invalid.deprecated.scope_not_allowed.tm-grammar"},
          5 => {name: "punctuation.definition.string.end.tm-grammar"}},
        match: 
         /(?x)
	(')								# Open String
	(							# Optionally match the valid
	# scopes, and the following
	# part of the scope, meaning
	# anything else is invalid
	comment(?:
	\.(?:line|block)
	)?
	  | constant(?:
	\.(?:numeric|character|language|other)
	)?
	  | entity(?:
	\.name(?:
	\.(?:function|type|tag|section)
	)?
	  | \.other(?:
	\.(?:inherited-class|attribute-name)
	)?
	)?
	  | invalid(?:
	\.(?:illegal|deprecated)
	)?
	  | keyword(?:
	\.(?:control|operator|other)
	)?
	  | markup(?:
	\.(?:underline|bold|heading|italic|list|quote|raw|other)
	)?
	  | meta
	  | punctuation(?:
	\.(?:definition|section|separator|terminator|whitespace)
	)?
	  | source
	  | storage(?:
	\.(?:type|modifier)
	)?
	  | string(?:
	\.(?:
	quoted(?:
	\.(?:single|double|triple|other)
	)?
	  | (?:unquoted|interpolated|regexp|other)
	)
	)?
	  | support(?:
	\.(?:function|class|type|constant|variable|other)
	)?
	  | text
	  | variable(?:
	\.(?:parameter|language|other)
	)?
	)?
	((?<!')[^\s,()&|\[\]:"'{}<>*?=^;#]*(?<!\.))?
	([^']*)?
	(')								# Close String
	/,
        name: "string.quoted.single.scope.tm-grammar"},
       {captures: 
         {1 => {name: "punctuation.definition.string.begin.tm-grammar"},
          2 => {name: "constant.other.scope.tm-grammar"},
          3 => {name: "constant.other.scope.tm-grammar"},
          4 => {name: "invalid.deprecated.scope_not_allowed.tm-grammar"},
          5 => {name: "punctuation.definition.string.end.tm-grammar"}},
        match: 
         /(?x)
	(")								# Open String
	(							# Optionally match the valid
	# scopes, and the following
	# part of the scope, meaning
	# anything else is invalid
	comment(?:
	\.(?:line|block)
	)?
	  | constant(?:
	\.(?:numeric|character|language|other)
	)?
	  | entity(?:
	\.name(?:
	\.(?:function|type|tag|section)
	)?
	  | \.other(?:
	\.(?:inherited-class|attribute-name)
	)?
	)?
	  | invalid(?:
	\.(?:illegal|deprecated)
	)?
	  | keyword(?:
	\.(?:control|operator|other)
	)?
	  | markup(?:
	\.(?:underline|bold|heading|italic|list|quote|raw|other)
	)?
	  | meta
	  | punctuation(?:
	\.(?:definition|section|separator|terminator|whitespace)
	)?
	  | source
	  | storage(?:
	\.(?:type|modifier)
	)?
	  | string(?:
	\.(?:
	quoted(?:
	\.(?:single|double|triple|other)
	)?
	  | (?:unquoted|interpolated|regexp|other)
	)
	)?
	  | support(?:
	\.(?:function|class|type|constant|variable|other)
	)?
	  | text
	  | variable(?:
	\.(?:parameter|language|other)
	)?
	)?
	((?<!")[^\s,()&|\[\]:"'{}<>*?=^;#]*(?<!\.))?
	([^"]*)?
	(")								# Close String
	/,
        name: "string.quoted.double.scope.tm-grammar"}]},
   :"scope-root" => 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.string.begin.tm-grammar"},
          2 => {name: "constant.other.scope.tm-grammar"},
          3 => {name: "invalid.deprecated.scope_not_allowed.tm-grammar"},
          4 => {name: "invalid.deprecated.scope_not_allowed.tm-grammar"},
          5 => {name: "punctuation.definition.string.end.tm-grammar"}},
        match: 
         /(')(?:((?:source|text)\.[^\s,()&|\[\]:"'{}<>*?=^;#]*)([^']*)|([^']*))(')/,
        name: "string.quoted.single.scope.root.tm-grammar"},
       {captures: 
         {1 => {name: "punctuation.definition.string.begin.tm-grammar"},
          2 => {name: "constant.other.scope.tm-grammar"},
          3 => {name: "invalid.deprecated.scope_not_allowed.tm-grammar"},
          4 => {name: "invalid.deprecated.scope_not_allowed.tm-grammar"},
          5 => {name: "punctuation.definition.string.end.tm-grammar"}},
        match: 
         /(")(?:((?:source|text)\.[^\s,()&|\[\]:"'{}<>*?=^;#]*)([^"]*)|([^"]*))(")/,
        name: "string.quoted.double.scope.root.tm-grammar"}]},
   string: 
    {patterns: 
      [{match: /\b[0-9]+\b/, name: "constant.numeric.tm-grammar"},
       {match: /[-a-zA-Z0-9_.]+/, name: "string.unquoted.tm-grammar"},
       {applyEndPatternLast: 1,
        begin: /(')/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.tm-grammar"}},
        end: "('(?!'))",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.tm-grammar"}},
        name: "string.quoted.single.tm-grammar",
        patterns: 
         [{match: /''/,
           name: "constant.character.escape.apostrophe.tm-grammar"}]},
       {begin: /(")/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.tm-grammar"}},
        end: "(\")",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.tm-grammar"}},
        name: "string.quoted.double.tm-grammar",
        patterns: 
         [{match: /\\[\\"]/,
           name: "constant.character.escape.tm-grammar"}]}]}},
 scopeName: "source.plist.tm-grammar",
 uuid: "101D6FC2-6CBD-11D9-B329-000D93347A42"}
