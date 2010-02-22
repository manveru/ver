# Encoding: UTF-8

{fileTypes: ["doxygen"],
 name: "Doxygen",
 patterns: 
  [{begin: /\/\*\*\<?/,
    captures: {0 => {name: "punctuation.definition.comment.doxygen"}},
    end: "\\*\\/",
    name: "comment.block.doxygen",
    patterns: [{include: "#source_doxygen"}]},
   {begin: /\/\*!\<?/,
    captures: {0 => {name: "punctuation.definition.comment.doxygen"}},
    end: "\\*\\/",
    name: "comment.block.doxygen",
    patterns: [{include: "#source_doxygen"}]},
   {begin: /\/\/[\/!]\<?/,
    beginCaptures: {0 => {name: "punctuation.definition.comment.doxygen"}},
    end: "$\\n?",
    name: "comment.line.doxygen",
    patterns: [{include: "#source_doxygen"}]}],
 repository: 
  {keywords: 
    {patterns: 
      [{captures: {1 => {name: "punctuation.definition.keyword.doxygen"}},
        match: 
         /(?<_1>[\\@])(?<_2>(?<_3>a|addindex|addtogroup|anchor|arg|attention|author|b|brief|bug|c|callgraph|callergraph|category|class|code|cond|copydoc|date|def|defgroup|deprecated|dir|dontinclude|dot|dotfile|e|else|elseif|em|endcode|endcond|enddot|endhtmlonly|endif|endlatexonly|endlink|endmanonly|endverbatim|endxmlonly|enum|example|exception|file|fn|hideinitializer|htmlinclude|htmlonly|if|ifnot|image|include|includelineno|ingroup|internal|invariant|interface|latexonly|li|line|link|mainpage|manonly|n|name|namespace|nosubgrouping|note|overload|p|package|page|par|paragraph|param|post|pre|private|privatesection|property|protected|protectedsection|protocol|public|publicsection|ref|relates|relatesalso|remarks|return|retval|sa|section|see|showinitializer|since|skip|skipline|struct|subpage|subsection|subsubsection|test|throw|todo|typedef|union|until|var|verbatim|verbinclude|version|warning|weakgroup|xmlonly|xrefitem)\b|(?<_4>\$|\@|\\|\&|\~|\<|\>|\#|\%|f\$|f\[|f\]))/,
        name: "keyword.control.doxygen"}]},
   source_doxygen: 
    {patterns: [{include: "#keywords"}, {include: "text.html.basic"}]}},
 scopeName: "text.html.doxygen",
 uuid: "9725E602-6D7C-4E98-911A-C66802142451"}
