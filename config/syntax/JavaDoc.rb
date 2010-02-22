# Encoding: UTF-8

{fileTypes: [],
 foldingStartMarker: /\/\*\*/,
 foldingStopMarker: /\*\*\//,
 name: "JavaDoc",
 patterns: 
  [{begin: /(?<_1>\/\*\*)\s*$/,
    beginCaptures: 
     {1 => {name: "punctuation.definition.comment.begin.javadoc"}},
    contentName: "text.html",
    end: "\\*/",
    endCaptures: {0 => {name: "punctuation.definition.comment.end.javadoc"}},
    name: "comment.block.documentation.javadoc",
    patterns: 
     [{include: "#inline"},
      {begin: /(?<_1>(?<_2>\@)param)/,
       beginCaptures: 
        {1 => {name: "keyword.other.documentation.param.javadoc"},
         2 => {name: "punctuation.definition.keyword.javadoc"}},
       end: "(?=^\\s*\\*?\\s*@|\\*/)",
       name: "meta.documentation.tag.param.javadoc",
       patterns: [{include: "#inline"}]},
      {begin: /(?<_1>(?<_2>\@)return)/,
       beginCaptures: 
        {1 => {name: "keyword.other.documentation.return.javadoc"},
         2 => {name: "punctuation.definition.keyword.javadoc"}},
       end: "(?=^\\s*\\*?\\s*@|\\*/)",
       name: "meta.documentation.tag.return.javadoc",
       patterns: [{include: "#inline"}]},
      {begin: /(?<_1>(?<_2>\@)throws)/,
       beginCaptures: 
        {1 => {name: "keyword.other.documentation.throws.javadoc"},
         2 => {name: "punctuation.definition.keyword.javadoc"}},
       end: "(?=^\\s*\\*?\\s*@|\\*/)",
       name: "meta.documentation.tag.throws.javadoc",
       patterns: [{include: "#inline"}]},
      {begin: /(?<_1>(?<_2>\@)exception)/,
       beginCaptures: 
        {1 => {name: "keyword.other.documentation.exception.javadoc"},
         2 => {name: "punctuation.definition.keyword.javadoc"}},
       end: "(?=^\\s*\\*?\\s*@|\\*/)",
       name: "meta.documentation.tag.exception.javadoc",
       patterns: [{include: "#inline"}]},
      {begin: /(?<_1>(?<_2>\@)author)/,
       beginCaptures: 
        {1 => {name: "keyword.other.documentation.author.javadoc"},
         2 => {name: "punctuation.definition.keyword.javadoc"}},
       end: "(?=^\\s*\\*?\\s*@|\\*/)",
       name: "meta.documentation.tag.author.javadoc",
       patterns: [{include: "#inline"}]},
      {begin: /(?<_1>(?<_2>\@)version)/,
       beginCaptures: 
        {1 => {name: "keyword.other.documentation.version.javadoc"},
         2 => {name: "punctuation.definition.keyword.javadoc"}},
       end: "(?=^\\s*\\*?\\s*@|\\*/)",
       name: "meta.documentation.tag.version.javadoc",
       patterns: [{include: "#inline"}]},
      {begin: /(?<_1>(?<_2>\@)see)/,
       beginCaptures: 
        {1 => {name: "keyword.other.documentation.see.javadoc"},
         2 => {name: "punctuation.definition.keyword.javadoc"}},
       end: "(?=^\\s*\\*?\\s*@|\\*/)",
       name: "meta.documentation.tag.see.javadoc",
       patterns: [{include: "#inline"}]},
      {begin: /(?<_1>(?<_2>\@)since)/,
       beginCaptures: 
        {1 => {name: "keyword.other.documentation.since.javadoc"},
         2 => {name: "punctuation.definition.keyword.javadoc"}},
       end: "(?=^\\s*\\*?\\s*@|\\*/)",
       name: "meta.documentation.tag.since.javadoc",
       patterns: [{include: "#inline"}]},
      {begin: /(?<_1>(?<_2>\@)serial)/,
       beginCaptures: 
        {1 => {name: "keyword.other.documentation.serial.javadoc"},
         2 => {name: "punctuation.definition.keyword.javadoc"}},
       end: "(?=^\\s*\\*?\\s*@|\\*/)",
       name: "meta.documentation.tag.serial.javadoc",
       patterns: [{include: "#inline"}]},
      {begin: /(?<_1>(?<_2>\@)serialField)/,
       beginCaptures: 
        {1 => {name: "keyword.other.documentation.serialField.javadoc"},
         2 => {name: "punctuation.definition.keyword.javadoc"}},
       end: "(?=^\\s*\\*?\\s*@|\\*/)",
       name: "meta.documentation.tag.serialField.javadoc",
       patterns: [{include: "#inline"}]},
      {begin: /(?<_1>(?<_2>\@)serialData)/,
       beginCaptures: 
        {1 => {name: "keyword.other.documentation.serialData.javadoc"},
         2 => {name: "punctuation.definition.keyword.javadoc"}},
       end: "(?=^\\s*\\*?\\s*@|\\*/)",
       name: "meta.documentation.tag.serialData.javadoc",
       patterns: [{include: "#inline"}]},
      {begin: /(?<_1>(?<_2>\@)deprecated)/,
       beginCaptures: 
        {1 => {name: "keyword.other.documentation.deprecated.javadoc"},
         2 => {name: "punctuation.definition.keyword.javadoc"}},
       end: "(?=^\\s*\\*?\\s*@|\\*/)",
       name: "meta.documentation.tag.deprecated.javadoc",
       patterns: [{include: "#inline"}]},
      {captures: 
        {1 => {name: "keyword.other.documentation.custom.javadoc"},
         2 => {name: "punctuation.definition.keyword.javadoc"}},
       match: /(?<_1>(?<_2>\@)\S+)\s/}]}],
 repository: 
  {inline: 
    {patterns: 
      [{include: "#inline-formatting"},
       {include: "text.html.basic"},
       {match: 
         /(?<_1>(?<_2>https?|s?ftp|ftps|file|smb|afp|nfs|(?<_3>x-)?man|gopher|txmt):\/\/|mailto:)[-:@a-zA-Z0-9_.~%+\/?=&#]+(?<![.?:])/,
        name: "markup.underline.link"}]},
   :"inline-formatting" => 
    {patterns: 
      [{begin: /(?<_1>\{)(?<_2>(?<_3>\@)code)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.tag.begin.javadoc"},
          2 => {name: "keyword.other.documentation.directive.code.javadoc"},
          3 => {name: "punctuation.definition.keyword.javadoc"}},
        contentName: "markup.raw.code.javadoc",
        end: "\\}",
        endCaptures: {0 => {name: "punctuation.definition.tag.end.javadoc"}},
        name: "meta.tag.template.code.javadoc",
        patterns: []},
       {begin: /(?<_1>\{)(?<_2>(?<_3>\@)literal)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.tag.begin.javadoc"},
          2 => {name: "keyword.other.documentation.directive.literal.javadoc"},
          3 => {name: "punctuation.definition.keyword.javadoc"}},
        contentName: "markup.raw.literal.javadoc",
        end: "\\}",
        endCaptures: {0 => {name: "punctuation.definition.tag.end.javadoc"}},
        name: "meta.tag.template.literal.javadoc",
        patterns: []},
       {captures: 
         {1 => {name: "punctuation.definition.tag.begin.javadoc"},
          2 => {name: "keyword.other.documentation.directive.docRoot.javadoc"},
          3 => {name: "punctuation.definition.keyword.javadoc"},
          4 => {name: "punctuation.definition.tag.end.javadoc"}},
        match: /(?<_1>\{)(?<_2>(?<_3>\@)docRoot)(?<_4>\})/,
        name: "meta.tag.template.docRoot.javadoc"},
       {captures: 
         {1 => {name: "punctuation.definition.tag.begin.javadoc"},
          2 => 
           {name: "keyword.other.documentation.directive.inheritDoc.javadoc"},
          3 => {name: "punctuation.definition.keyword.javadoc"},
          4 => {name: "punctuation.definition.tag.end.javadoc"}},
        match: /(?<_1>\{)(?<_2>(?<_3>\@)inheritDoc)(?<_4>\})/,
        name: "meta.tag.template.inheritDoc.javadoc"},
       {captures: 
         {1 => {name: "punctuation.definition.tag.begin.javadoc"},
          2 => {name: "keyword.other.documentation.directive.link.javadoc"},
          3 => {name: "punctuation.definition.keyword.javadoc"},
          4 => {name: "markup.underline.link.javadoc"},
          5 => {name: "string.other.link.title.javadoc"},
          6 => {name: "punctuation.definition.tag.end.javadoc"}},
        match: 
         /(?<_1>\{)(?<_2>(?<_3>\@)link)(?:\s+(?<_4>\S+?))?(?:\s+(?<_5>.+?))?\s*(?<_6>\})/,
        name: "meta.tag.template.link.javadoc"},
       {captures: 
         {1 => {name: "punctuation.definition.tag.begin.javadoc"},
          2 => 
           {name: "keyword.other.documentation.directive.linkplain.javadoc"},
          3 => {name: "punctuation.definition.keyword.javadoc"},
          4 => {name: "markup.underline.linkplain.javadoc"},
          5 => {name: "string.other.link.title.javadoc"},
          6 => {name: "punctuation.definition.tag.end.javadoc"}},
        match: 
         /(?<_1>\{)(?<_2>(?<_3>\@)linkplain)(?:\s+(?<_4>\S+?))?(?:\s+(?<_5>.+?))?\s*(?<_6>\})/,
        name: "meta.tag.template.linkplain.javadoc"},
       {captures: 
         {1 => {name: "punctuation.definition.tag.begin.javadoc"},
          2 => {name: "keyword.other.documentation.directive.value.javadoc"},
          3 => {name: "punctuation.definition.keyword.javadoc"},
          4 => {name: "variable.other.javadoc"},
          5 => {name: "punctuation.definition.tag.end.javadoc"}},
        match: /(?<_1>\{)(?<_2>(?<_3>\@)value)\s*(?<_4>\S+?)?\s*(?<_5>\})/,
        name: "meta.tag.template.value.javadoc"}]}},
 scopeName: "text.html.javadoc",
 uuid: "64BB98A4-59D4-474E-9091-C1E1D04BDD03"}
