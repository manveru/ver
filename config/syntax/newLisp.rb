# Encoding: UTF-8

{comment: "newLisp",
 fileTypes: ["lsp", "qwerty"],
 foldingStartMarker: /^\((define(-macro)?)\s*?\(.+?\)$/,
 foldingStopMarker: /^(?!\((define(-macro)?)\s*?\(.+?\))/,
 keyEquivalent: /@l/,
 name: "newLisp",
 patterns: 
  [{match: /\b(\S+?):(\S+)\b/, name: "storage.context.lsp"},
   {captures: {1 => {name: "storage.function.lsp"}},
    match: /(?<=\(define-macro \()(\S+)\b/},
   {captures: {1 => {name: "storage.function.lsp"}},
    match: /(?<=\(define \()(\S+)\b/},
   {match: /(^;;\s*$)/, name: "comment.doc.empty.lsp"},
   {begin: /^;;[^;]/, end: "\\n(?!=;;)", name: "comment.doc.lsp"},
   {captures: {1 => {name: "punctuation.definition.comment.lsp"}},
    match: /(?<!(?:\{|"|\]))(?:\s*)(;+.*)$/,
    name: "comment.line.lsp"},
   {match: /([\(\)'])/, name: "operator.lsp"},
   {match: /(?<=')([^\s\(\)']+)\b/, name: "constant.quote.symbol.lsp"},
   {match: 
     /(?<=['\(\s])(!|!=|\$|%|&|\*|\+|-|\/|:|<|<<|<=|=|>|>=|>>|\?|@|NaN\?|\^|abort|abs|acos|acosh|add|address|amb|and|append|append-file|apply|args|array|array-list|array\?|asin|asinh|assoc|assoc-set|atan|atan2|atanh|atom\?|base64-dec|base64-enc|bayes-query|bayes-train|begin|beta|betai|bind|binomial|callback|case|catch|ceil|change-dir|char|chop|clean|close|command-event|cond|cons|constant|context|context\?|copy-file|cos|cosh|count|cpymem|crc32|crit-chi2|crit-z|current-line|curry|date|date-value|debug|dec|def-new|default|define|define-macro|define-method|delete|delete-file|delete-url|destroy|det|device|difference|directory|directory\?|div|do-until|do-while|doargs|dolist|dostring|dotimes|dotree|dump|dup|empty\?|encrypt|ends-with|env|erf|error-event|error-number|error-text|eval|eval-string|exec|exists|exit|exp|expand|explode|factor|fft|file-info|file\?|filter|find|find-all|first|flat|float|float\?|floor|flt|fn|for|for-all|fork|format|fv|gammai|gammaln|gcd|get-char|get-float|get-int|get-long|get-string|get-url|global|global\?|if|if-not|ifft|import|inc|index|int|integer|integer\?|intersect|invert|irr|join|lambda|lambda\?|lambda-macro|last|legal\?|length|let|letex|letn|list|list\?|load|local|log|lookup|lower-case|macro\?|main-args|make-dir|map|mat|match|max|member|min|mod|mul|multiply|name|net-accept|net-close|net-connect|net-error|net-eval|net-listen|net-local|net-lookup|net-peek|net-peer|net-ping|net-receive|net-receive-from|net-receive-udp|net-select|net-send|net-send-to|net-send-udp|net-service|net-sessions|new|nil|nil\?|normal|not|now|nper|npv|nth|nth-set|null\?|number\?|open|or|ostype|pack|parse|parse-date|peek|pipe|pmt|pop|pop-assoc|post-url|pow|pretty-print|primitive\?|print|println|prob-chi2|prob-z|process|prompt-event|protected\?|push|put-url|pv|quote|quote\?|rand|random|randomize|read-buffer|read-char|read-expr|read-file|read-key|read-line|real-path|ref|ref-all|ref-set|regex|regex-comp|remove-dir|rename-file|replace|replace-assoc|reset|rest|reverse|rotate|round|save|search|seed|seek|select|semaphore|sequence|series|set|set-assoc|set-locale|set-nth|set-ref|set-ref-all|setf|setq|sgn|share|signal|silent|sin|sinh|sleep|slice|sort|source|spawn|sqrt|starts-with|string|string\?|sub|swap|sym|symbol\?|symbols|sync|sys-error|sys-info|tan|tanh|throw|throw-error|time|time-of-day|timer|title-case|trace|trace-highlight|transpose|trim|true|true\?|unicode|unify|unique|unless|unpack|until|upper-case|utf8|utf8len|uuid|wait-pid|when|while|write-buffer|write-char|write-file|write-line|x|xml-error|xml-parse|xml-type-tags|zero\?|\||~)(?=[\s\)])/,
    name: "support.function.lsp"},
   {match: 
     /\b(?<!\w\-)((?:[\(\s])[-+])?((0(x|X)[0-9a-fA-F]*)|(([0-9]+\.?[0-9]*)|(\.[0-9]+))((e|E)(\+|-)?[0-9]+)?)(L|l|UL|ul|u|U|F|f|ll|LL|ull|ULL)?(?![\w\-])\b/,
    name: "constant.numeric.lsp"},
   {begin: /"/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.lsp"}},
    end: "(?<!\\\\(?<!\\\\))\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.lsp"}},
    name: "string.quoted.double.lsp",
    patterns: 
     [{include: "#constant_placeholder"}, {include: "#escaped_char"}]},
   {begin: /{/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.lsp"}},
    end: "(?<!\\\\(?<!\\\\))}",
    endCaptures: {0 => {name: "punctuation.definition.string.end.lsp"}},
    name: "string.quoted.braces.lsp",
    patterns: 
     [{include: "#constant_placeholder"}, {include: "#escaped_char"}]},
   {begin: /\[text\]/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.lsp"}},
    end: "\\[/text\\]",
    endCaptures: {0 => {name: "punctuation.definition.string.end.lsp"}},
    name: "string.quoted.texttag.lsp",
    patterns: 
     [{include: "#constant_placeholder"}, {include: "#escaped_char"}]},
   {match: 
     /(?<=['\(\s])(\$1|\$10|\$11|\$12|\$13|\$14|\$15|\$2|\$3|\$4|\$5|\$6|\$7|\$8|\$9|\$idx|\$it|\?|@|nil|true)(?=[\s\)])/,
    name: "constant.language.lsp"},
   {begin: /\(/,
    end: "\\)",
    name: "list.lsp",
    patterns: [{include: "#list"}]}],
 repository: 
  {constant_placeholder: 
    {match: 
      /(?i:%(\([a-z_]+\))?#?0?\-?[ ]?\+?([0-9]*|\*)(\.([0-9]*|\*))?[hL]?[a-z%])/,
     name: "constant.other.placeholder.lsp"},
   escaped_char: 
    {captures: 
      {1 => {name: "constant.character.escape.hex.lsp"},
       10 => {name: "constant.character.escape.linefeed.lsp"},
       11 => {name: "constant.character.escape.return.lsp"},
       12 => {name: "constant.character.escape.tab.lsp"},
       13 => {name: "constant.character.escape.vertical-tab.lsp"},
       2 => {name: "constant.character.escape.octal.lsp"},
       3 => {name: "constant.character.escape.newline.lsp"},
       4 => {name: "constant.character.escape.backlash.lsp"},
       5 => {name: "constant.character.escape.double-quote.lsp"},
       6 => {name: "constant.character.escape.single-quote.lsp"},
       7 => {name: "constant.character.escape.bell.lsp"},
       8 => {name: "constant.character.escape.backspace.lsp"},
       9 => {name: "constant.character.escape.formfeed.lsp"}},
     match: 
      /(\\x[0-9A-F]{2})|(\\[0-7]{3})|(\\\n)|(\\\\)|(\\\")|(\\')|(\\a)|(\\b)|(\\f)|(\\n)|(\\r)|(\\t)|(\\v)/},
   list: {begin: /\(/, end: "\\)", patterns: [{include: "#list"}]}},
 scopeName: "source.lsp",
 uuid: "5587E93C-3603-4275-B124-026441367B47",
 xfoldingStartMarker: "^\\(define \\(.+?\\)$",
 xfoldingStopMarker: "(\\n)(?:\\n)"}
