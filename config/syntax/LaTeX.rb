# Encoding: UTF-8

{fileTypes: ["tex"],
 firstLineMatch: "^\\\\documentclass(?!.*\\{beamer\\})",
 foldingStartMarker: /\\begin\{.*\}|%.*\(fold\)\s*$/,
 foldingStopMarker: /\\end\{.*\}|%.*\(end\)\s*$/,
 keyEquivalent: "^~L",
 name: "LaTeX",
 patterns: 
  [{match: 
     /(?=\s)(?<=\\[\w@]|\\[\w@]{2}|\\[\w@]{3}|\\[\w@]{4}|\\[\w@]{5}|\\[\w@]{6})\s/,
    name: "meta.space-after-command.latex"},
   {begin: 
     /(?<_1>(?<_2>\\)(?:usepackage|documentclass))(?:(?<_3>\[)(?<_4>[^\]]*)(?<_5>\]))?(?<_6>\{)/,
    beginCaptures: 
     {1 => {name: "keyword.control.preamble.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"},
      4 => {name: "variable.parameter.latex"},
      5 => {name: "punctuation.definition.arguments.end.latex"},
      6 => {name: "punctuation.definition.arguments.begin.latex"}},
    contentName: "support.class.latex",
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.arguments.end.latex"}},
    name: "meta.preamble.latex",
    patterns: [{include: "$self"}]},
   {begin: /(?<_1>(?<_2>\\)(?:include|input))(?<_3>\{)/,
    beginCaptures: 
     {1 => {name: "keyword.control.include.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"}},
    contentName: "support.class.latex",
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.arguments.end.latex"}},
    name: "meta.include.latex",
    patterns: [{include: "$self"}]},
   {begin: 
     /(?x)
	(?<_1>													# Capture 1
	(?<_2>\\)											# Marker
	(?:
	(?:sub){0,2}section							# Functions
	  | (?:sub)?paragraph
	  | chapter|part|addpart
	  | addchap|addsec|minisec
	)
	(?:\*)?											# Optional Unnumbered
	)
	(?:
	(?<_3>\[)(?<_4>[^\[]*?)(?<_5>\])								# Optional Title
	)??
	(?<_6>\{)												# Opening Bracket
	/,
    beginCaptures: 
     {1 => {name: "support.function.section.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.optional.begin.latex"},
      4 => {name: "entity.name.section.latex"},
      5 => {name: "punctuation.definition.arguments.optional.end.latex"},
      6 => {name: "punctuation.definition.arguments.begin.latex"}},
    comment: 
     "this works OK with all kinds of crazy stuff as long as section is one line",
    contentName: "entity.name.section.latex",
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.arguments.end.latex"}},
    name: "meta.function.section.latex",
    patterns: [{include: "$self"}]},
   {begin: 
     /(?:\s*)(?<_1>(?<_2>\\)begin)(?<_3>\{)(?<_4>lstlisting)(?<_5>\})(?:(?<_6>\[).*(?<_7>\]))?(?<_8>\s*%\s*(?i:Java)\n?)/,
    captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.end.latex"},
      6 => {name: "punctuation.definition.arguments.optional.begin.latex"},
      7 => {name: "punctuation.definition.arguments.optional.end.latex"},
      8 => {name: "comment.line.percentage.latex"}},
    contentName: "source.java.embedded",
    end: "((\\\\)end)(\\{)(lstlisting)(\\})",
    name: "meta.function.embedded.java.latex",
    patterns: [{include: "source.java"}]},
   {begin: 
     /(?:\s*)(?<_1>(?<_2>\\)begin)(?<_3>\{)(?<_4>lstlisting)(?<_5>\})(?:(?<_6>\[).*(?<_7>\]))?(?<_8>\s*%\s*(?i:Python)\n?)/,
    captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.end.latex"},
      6 => {name: "punctuation.definition.arguments.optional.begin.latex"},
      7 => {name: "punctuation.definition.arguments.optional.end.latex"},
      8 => {name: "comment.line.percentage.latex"}},
    comment: 
     "Put the lstlisting match before the more general environment listing. Someday it would be nice to make this rule general enough to figure out which language is inside the lstlisting environment rather than my own personal use for python. --Brad",
    contentName: "source.python.embedded",
    end: "((\\\\)end)(\\{)(lstlisting)(\\})",
    name: "meta.function.embedded.python.latex",
    patterns: [{include: "source.python"}]},
   {begin: 
     /(?:\s*)(?<_1>(?<_2>\\)begin)(?<_3>\{)(?<_4>lstlisting)(?<_5>\})(?:(?<_6>\[).*(?<_7>\]))?(?<_8>\s*%.*\n?)?/,
    captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.end.latex"},
      6 => {name: "punctuation.definition.arguments.optional.begin.latex"},
      7 => {name: "punctuation.definition.arguments.optional.end.latex"},
      8 => {name: "comment.line.percentage.latex"}},
    comment: 
     "Put the lstlisting match before the more general environment listing. Someday it would be nice to make this rule general enough to figure out which language is inside the lstlisting environment rather than my own personal use for python. --Brad",
    contentName: "source.generic.embedded",
    end: "((\\\\)end)(\\{)(lstlisting)(\\})",
    name: "meta.function.embedded.generic.latex"},
   {begin: 
     /(?:\s*)(?<_1>(?<_2>\\)begin)(?<_3>\{)(?<_4>(?:V|v)erbatim|alltt)(?<_5>\})/,
    captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.end.latex"}},
    contentName: "markup.raw.verbatim.latex",
    end: "((\\\\)end)(\\{)(\\4)(\\})",
    name: "meta.function.verbatim.latex"},
   {captures: 
     {1 => {name: "support.function.url.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"},
      4 => {name: "markup.underline.link.latex"},
      5 => {name: "punctuation.definition.arguments.end.latex"}},
    match: /(?:\s*)(?<_1>(?<_2>\\)(?:url|href))(?<_3>\{)(?<_4>[^}]*)(?<_5>\})/,
    name: "meta.function.link.url.latex"},
   {captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.end.latex"}},
    comment: 
     "These two patterns match the \\begin{document} and \\end{document} commands, so that the environment matching pattern following them will ignore those commands.",
    match: /(?:\s*)(?<_1>(?<_2>\\)begin)(?<_3>\{)(?<_4>document)(?<_5>\})/,
    name: "meta.function.begin-document.latex"},
   {captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.end.latex"}},
    match: /(?:\s*)(?<_1>(?<_2>\\)end)(?<_3>\{)(?<_4>document)(?<_5>\})/,
    name: "meta.function.end-document.latex"},
   {begin: 
     /(?x)
	(?:\s*)										# Optional whitespace
	(?<_1>(?<_2>\\)begin)									# Marker - Function
	(?<_3>\{)										# Open Bracket
	(?<_4>
	(?:
	align|equation|eqnarray			# Argument
	  | multline|aligned|alignat
	  | split|gather|gathered
	)
	(?:\*)?								# Optional Unnumbered
	)
	(?<_5>\})										# Close Bracket
	(?<_6>\s*\n)?				# Match to end of line absent of content
	/,
    captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.end.latex"}},
    contentName: "string.other.math.block.environment.latex",
    end: 
     "(?x)\n\t\t\t\t\t(?:\\s*)\t\t\t\t\t\t\t\t\t\t# Optional whitespace\n\t\t\t\t\t((\\\\)end)\t\t\t\t\t\t\t\t\t# Marker - Function\n\t\t\t\t\t(\\{)\t\t\t\t\t\t\t\t\t\t# Open Bracket\n\t\t\t\t\t\t(\\4)\t\t\t\t# Previous capture from begin\n\t\t\t\t\t(\\})\t\t\t\t\t\t\t\t\t\t# Close Bracket\n\t\t\t\t\t(?:\\s*\\n)?\t\t\t\t# Match to end of line absent of content\n\t\t\t\t",
    name: "meta.function.environment.math.latex",
    patterns: [{include: "$base"}]},
   {begin: 
     /(?x)
	(?:\s*)										# Optional whitespace
	(?<_1>(?<_2>\\)begin)									# Marker - Function
	(?<_3>\{)										# Open Bracket
	(?<_4>array|tabular[xy*]?)
	(?<_5>\})										# Close Bracket
	(?<_6>\s*\n)?				# Match to end of line absent of content
	/,
    captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.end.latex"}},
    contentName: "meta.data.environment.tabular.latex",
    end: 
     "(?x)\n\t\t\t\t\t(?:\\s*)\t\t\t\t\t\t\t\t\t\t# Optional whitespace\n\t\t\t\t\t((\\\\)end)\t\t\t\t\t\t\t\t\t# Marker - Function\n\t\t\t\t\t(\\{)\t\t\t\t\t\t\t\t\t\t# Open Bracket\n\t\t\t\t\t\t(\\4)\t\t\t\t# Previous capture from begin\n\t\t\t\t\t(\\})\t\t\t\t\t\t\t\t\t\t# Close Bracket\n\t\t\t\t\t(?:\\s*\\n)?\t\t\t\t# Match to end of line absent of content\n\t\t\t\t",
    name: "meta.function.environment.tabular.latex",
    patterns: 
     [{match: /\\/, name: "punctuation.definition.table.row.latex"},
      {begin: /(?:^|(?<=\\\\))(?!\\\\|\s*\\end\{(?:tabular|array))/,
       end: "(?=\\\\\\\\|\\s*\\\\end\\{(?:tabular|array))",
       name: "meta.row.environment.tabular.latex",
       patterns: 
        [{match: /&/, name: "punctuation.definition.table.cell.latex"},
         {begin: /(?:^|(?<=&))(?<_1>(?!&|\\\\|$))/,
          end: "(?=&|\\\\\\\\|\\s*\\\\end\\{(?:tabular|array))",
          name: "meta.cell.environment.tabular.latex",
          patterns: [{include: "$base"}]},
         {include: "$base"}]},
      {include: "$base"}]},
   {begin: 
     /(?:\s*)(?<_1>(?<_2>\\)begin)(?<_3>\{)(?<_4>itemize|enumerate|description|list)(?<_5>\})/,
    captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.latex"}},
    end: "((\\\\)end)(\\{)(\\4)(\\})(?:\\s*\\n)?",
    name: "meta.function.environment.list.latex",
    patterns: [{include: "$base"}]},
   {begin: /(?:\s*)(?<_1>(?<_2>\\)begin)(?<_3>\{)(?<_4>tikzpicture)(?<_5>\})/,
    captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.latex"}},
    end: "((\\\\)end)(\\{)(tikzpicture)(\\})(?:\\s*\\n)?",
    name: "meta.function.environment.latex.tikz",
    patterns: [{include: "text.tex.latex.tikz"}, {include: "text.tex.latex"}]},
   {begin: /(?:\s*)(?<_1>(?<_2>\\)begin)(?<_3>\{)(?<_4>\w+[*]?)(?<_5>\})/,
    captures: 
     {1 => {name: "support.function.be.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.arguments.latex"},
      4 => {name: "variable.parameter.function.latex"},
      5 => {name: "punctuation.definition.arguments.latex"}},
    end: "((\\\\)end)(\\{)(\\4)(\\})(?:\\s*\\n)?",
    name: "meta.function.environment.general.latex",
    patterns: [{include: "$base"}]},
   {captures: {1 => {name: "punctuation.definition.function.latex"}},
    match: /(?<_1>\\)(?<_2>newcommand|renewcommand)\b/,
    name: "storage.type.function.latex"},
   {begin: /(?<_1>(?<_2>\\)marginpar)(?<_3>\{)/,
    beginCaptures: 
     {1 => {name: "support.function.marginpar.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.marginpar.begin.latex"}},
    contentName: "meta.paragraph.margin.latex",
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.marginpar.end.latex"}},
    patterns: [{include: "$base"}]},
   {begin: /(?<_1>(?<_2>\\)footnote)(?<_3>\{)/,
    beginCaptures: 
     {1 => {name: "support.function.footnote.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.footnote.begin.latex"}},
    contentName: "meta.footnote.latex",
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.footnote.end.latex"}},
    patterns: [{include: "$base"}]},
   {begin: /(?<_1>(?<_2>\\)emph)(?<_3>\{)/,
    beginCaptures: 
     {1 => {name: "support.function.emph.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.emph.begin.latex"}},
    contentName: "markup.italic.emph.latex",
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.emph.end.latex"}},
    name: "meta.function.emph.latex",
    patterns: [{include: "$base"}]},
   {begin: /(?<_1>(?<_2>\\)textit)(?<_3>\{)/,
    captures: 
     {1 => {name: "support.function.textit.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.textit.begin.latex"}},
    comment: 
     "We put the keyword in a capture and name this capture, so that disabling spell checking for “keyword” won't be inherited by the argument to \\textit{...}.\n\nPut specific matches for particular LaTeX keyword.functions before the last two more general functions",
    contentName: "markup.italic.textit.latex",
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.textit.end.latex"}},
    name: "meta.function.textit.latex",
    patterns: [{include: "$base"}]},
   {begin: /(?<_1>(?<_2>\\)textbf)(?<_3>\{)/,
    captures: 
     {1 => {name: "support.function.textbf.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.textbf.begin.latex"}},
    contentName: "markup.bold.textbf.latex",
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.textbf.end.latex"}},
    name: "meta.function.textbf.latex",
    patterns: [{include: "$base"}]},
   {begin: /(?<_1>(?<_2>\\)texttt)(?<_3>\{)/,
    captures: 
     {1 => {name: "support.function.texttt.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.texttt.begin.latex"}},
    contentName: "markup.raw.texttt.latex",
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.texttt.end.latex"}},
    name: "meta.function.texttt.latex",
    patterns: [{include: "$base"}]},
   {captures: 
     {0 => {name: "keyword.other.item.latex"},
      1 => {name: "punctuation.definition.keyword.latex"}},
    match: /(?<_1>\\)item\b/,
    name: "meta.scope.item.latex"},
   {begin: 
     /(?x)
	(?<_1>
	(?<_2>\\)										# Marker
	(?:foot)?(?:full)?(?:no)?(?:short)?		# Function Name
	[cC]ite
	(?:al)?(?:t|p|author|year(?:par)?|title)?[ANP]*
	\*?											# Optional Unabreviated
	)
	(?:(?<_3>\[)[^\]]*(?<_4>\]))?								# Optional
	(?:(?<_5>\[)[^\]]*(?<_6>\]))?								#   Arguments
	(?<_7>\{)											# Opening Bracket
	/,
    captures: 
     {1 => {name: "keyword.control.cite.latex"},
      2 => {name: "punctuation.definition.keyword.latex"},
      3 => {name: "punctuation.definition.arguments.optional.begin.latex"},
      4 => {name: "punctuation.definition.arguments.optional.end.latex"},
      5 => {name: "punctuation.definition.arguments.optional.begin.latex"},
      6 => {name: "punctuation.definition.arguments.optional.end.latex"},
      7 => {name: "punctuation.definition.arguments.latex"}},
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.arguments.latex"}},
    name: "meta.citation.latex",
    patterns: 
     [{match: /[\w:.]+/, name: "constant.other.reference.citation.latex"}]},
   {begin: /(?<_1>(?<_2>\\)(?:\w*[r|R]ef\*?))(?<_3>\{)/,
    beginCaptures: 
     {1 => {name: "keyword.control.ref.latex"},
      2 => {name: "punctuation.definition.keyword.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"}},
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.arguments.begin.latex"}},
    name: "meta.reference.label.latex",
    patterns: 
     [{match: /[a-zA-Z0-9\.,:\/*!^_-]/,
       name: "constant.other.reference.label.latex"}]},
   {begin: /(?<_1>(?<_2>\\)label)(?<_3>\{)/,
    beginCaptures: 
     {1 => {name: "keyword.control.label.latex"},
      2 => {name: "punctuation.definition.keyword.latex"},
      3 => {name: "punctuation.definition.arguments.begin.latex"}},
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.arguments.end.latex"}},
    name: "meta.definition.label.latex",
    patterns: 
     [{match: /[a-zA-Z0-9\.,:\/*!^_-]/,
       name: "variable.parameter.definition.label.latex"}]},
   {begin: /(?<_1>(?<_2>\\)verb[\*]?)\s*(?<_3>(?<_4>\\)scantokens)(?<_5>\{)/,
    beginCaptures: 
     {1 => {name: "support.function.verb.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "support.function.verb.latex"},
      4 => {name: "punctuation.definition.verb.latex"},
      5 => {name: "punctuation.definition.begin.latex"}},
    contentName: "markup.raw.verb.latex",
    end: "(\\})",
    endCaptures: {1 => {name: "punctuation.definition.end.latex"}},
    name: "meta.function.verb.latex",
    patterns: [{include: "$self"}]},
   {captures: 
     {1 => {name: "support.function.verb.latex"},
      2 => {name: "punctuation.definition.function.latex"},
      3 => {name: "punctuation.definition.verb.latex"},
      4 => {name: "markup.raw.verb.latex"},
      5 => {name: "punctuation.definition.verb.latex"}},
    match: 
     /(?<_1>(?<_2>\\)verb[\*]?)\s*(?<_3>(?<=\s)\S|[^a-zA-Z])(?<_4>.*?)(?<_5>\k<_3>|$)/,
    name: "meta.function.verb.latex"},
   {begin: /"`/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.latex"}},
    end: "\"'",
    endCaptures: {0 => {name: "punctuation.definition.string.end.latex"}},
    name: "string.quoted.double.european.latex",
    patterns: [{include: "$base"}]},
   {begin: /``/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.latex"}},
    end: "''|\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.latex"}},
    name: "string.quoted.double.latex",
    patterns: [{include: "$base"}]},
   {begin: /">/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.latex"}},
    end: "\"<",
    endCaptures: {0 => {name: "punctuation.definition.string.end.latex"}},
    name: "string.quoted.double.guillemot.latex",
    patterns: [{include: "$base"}]},
   {begin: /"</,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.latex"}},
    end: "\">",
    endCaptures: {0 => {name: "punctuation.definition.string.end.latex"}},
    name: "string.quoted.double.guillemot.latex",
    patterns: [{include: "$base"}]},
   {begin: /\\\(/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.latex"}},
    end: "\\\\\\)",
    endCaptures: {0 => {name: "punctuation.definition.string.end.latex"}},
    name: "string.other.math.latex",
    patterns: [{include: "$base"}]},
   {begin: /\\\[/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.latex"}},
    end: "\\\\\\]",
    endCaptures: {0 => {name: "punctuation.definition.string.end.latex"}},
    name: "string.other.math.latex",
    patterns: [{include: "$base"}]},
   {match: /(?<!\S)'.*?'/, name: "invalid.illegal.string.quoted.single.latex"},
   {match: /(?<!\S)".*?"/, name: "invalid.illegal.string.quoted.double.latex"},
   {captures: {1 => {name: "punctuation.definition.constant.latex"}},
    match: 
     /(?<_1>\\)(?<_2>text(?<_3>s(?<_4>terling|ixoldstyle|urd|e(?<_5>ction|venoldstyle|rvicemark))|yen|n(?<_6>ineoldstyle|umero|aira)|c(?<_7>ircledP|o(?<_8>py(?<_9>left|right)|lonmonetary)|urrency|e(?<_10>nt(?<_11>oldstyle)?|lsius))|t(?<_12>hree(?<_13>superior|oldstyle|quarters(?<_14>emdash)?)|i(?<_15>ldelow|mes)|w(?<_16>o(?<_17>superior|oldstyle)|elveudash)|rademark)|interrobang(?<_18>down)?|zerooldstyle|o(?<_19>hm|ne(?<_20>superior|half|oldstyle|quarter)|penbullet|rd(?<_21>feminine|masculine))|d(?<_22>i(?<_23>scount|ed|v(?<_24>orced)?)|o(?<_25>ng|wnarrow|llar(?<_26>oldstyle)?)|egree|agger(?<_27>dbl)?|blhyphen(?<_28>char)?)|uparrow|p(?<_29>ilcrow|e(?<_30>so|r(?<_31>t(?<_32>housand|enthousand)|iodcentered))|aragraph|m)|e(?<_33>stimated|ightoldstyle|uro)|quotes(?<_34>traight(?<_35>dblbase|base)|ingle)|f(?<_36>iveoldstyle|ouroldstyle|lorin|ractionsolidus)|won|l(?<_37>not|ira|e(?<_38>ftarrow|af)|quill|angle|brackdbl)|a(?<_39>s(?<_40>cii(?<_41>caron|dieresis|acute|grave|macron|breve)|teriskcentered)|cutedbl)|r(?<_42>ightarrow|e(?<_43>cipe|ferencemark|gistered)|quill|angle|brackdbl)|g(?<_44>uarani|ravedbl)|m(?<_45>ho|inus|u(?<_46>sicalnote)?|arried)|b(?<_47>igcircle|orn|ullet|lank|a(?<_48>ht|rdbl)|rokenbar)))\b/,
    name: "constant.character.latex"},
   {captures: 
     {1 => {name: "punctuation.definition.column-specials.begin.latex"},
      2 => {name: "punctuation.definition.column-specials.end.latex"}},
    match: /(?:<|>)(?<_1>\{)\$(?<_2>\})/,
    name: "meta.column-specials.latex"},
   {include: "text.tex"}],
 scopeName: "text.tex.latex",
 uuid: "3BEEA00C-6B1D-11D9-B8AD-000D93589AF6"}
