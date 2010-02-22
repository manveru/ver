# Encoding: UTF-8

{comment: 
  "\n\t\tThis language grammar tries to handle Mediawiki syntax.  Mediawiki\n\t\tsyntax is a mess.  This grammar will likely never quite work right.\n\t\tThis is unsurprising as Mediawiki itself has never quite worked right.\n\t\t\n\t\t\t\t--Jacob\n\t\t\n\t\tTODO: lots of fixes still to do:\n\t\t\n\t\t 1. Add a bunch of HTML tags.  See the #block and #style sections.\n\t\t 3. Correctly scope all the parser functions and their contents.\n\t\t    This on will be complicated, as there are several: expr, if, etc.\n\t\t 4. This is probably the biggest one: get all the lists to scope\n\t\t    correctly by type of list.  Right now we just scope every list\n\t\t    as a list, and do not worry about what happens beyond that.\n\t\t    Eventually we want to do numbered and unnumbered separately, etc.\n\t\t 5. Get some kind of folding by heading.  Maybe it should just fold\n\t\t    to the next header, no matter which level it is.  Then we can\n\t\t    make a contents just by folding everything.  Not completely sure\n\t\t\tthis is possible with current TM folding.\n\t\t 7. Make sure that illegal things are correctly scoped illegal.\n\t\t    This is non-trivial, and has several parts\n\t\t    \n\t\t      - Bold/italic are based on brain-dead heuristics.  I want to\n\t\t        be stricter than Mediawiki on this one.  Also, we should\n\t\t        scope as illegal when for instance a new heading starts\n\t\t        before an italic has been closed.\n\t\t      - Templates... these will be pretty tough to do, as they can\n\t\t        be so flexible.\n\t\t      - \n\t\t\n\t\t 9. <timeline></timeline> tag.  I am really not sure this one is\n\t\t    worth trying to do\n\t\t10. Figure out a better scope for meta.function-call.  Infininight\n\t\t    suggests entity.name.function.call, to be paralleled by\n\t\t    entity.name.function.definition.  I am not completly sure I like\n\t\t    that solution, but it is probably better than meta.function-call\n\t\t\n\t\t\n\t\tTODO items not closely related to the grammar:\n\t\t\n\t\t 2. Add a drop command for links/images, add keyboard shortcuts for\n\t\t    them too\n\t\t 3. Make sure all the preference items are sorted out, for instance\n\t\t    smart typing pairs, indent patterns, etc.\n\t\t 4. Commands to do bold/italic, and maybe things like big/small \n\t\t 5. \n\t\t\n\t\tFINISHED:\n\t\t 2. Add support for LaTeX math mode inside of <math></math> tags.\n\t\t 1. Add a command for new list item.  This one is trivial\n\t\t 6. Get the symbol list working on headings.  Trivial.\n\t\t 8. <gallery></gallery> tag.  This one adds some complication, but\n\t\t    is worth supporting.\n\t\t \n\t",
 fileTypes: ["mediawiki", "wikipedia", "wiki"],
 foldingStartMarker: /^(?<_1>=+)/,
 foldingStopMarker: /^.*$(?=\n(?<_1>=+)|(?!\n))/,
 keyEquivalent: "^~M",
 name: "Mediawiki",
 patterns: [{include: "#block"}, {include: "#inline"}],
 repository: 
  {block: 
    {patterns: 
      [{begin: /^\s*(?i)(?<_1>#redirect)/,
        beginCaptures: {1 => {name: "keyword.control.redirect.mediawiki"}},
        end: "\\n",
        name: "meta.redirect.mediawiki",
        patterns: [{include: "#link"}]},
       {match: /^=+\s*$/, name: "markup.heading.mediawiki"},
       {begin: /^(?<_1>=+)(?=.*\k<_1>\s*$)/,
        comment: 
         "\n\t\t\t\t\t\tThis matches lines which begin and end with some\n\t\t\t\t\t    number of “=” marks.  If they are mismatched, then\n\t\t\t\t\t    interior “=” marks will be treated as invalid.\n\t\t\t\t    ",
        end: "\\1\\s*$\\n?",
        name: "markup.heading.mediawiki",
        patterns: 
         [{match: /(?<=^=|^==|^===|^====|^=====|^======)=+|=(?==*\s*$)/,
           name: "invalid.illegal.extra-equals-sign.mediawiki"},
          {include: "#inline"}]},
       {comment: 
         "\n\t\t\t\t\t\tA separator is made up of 4 or more -s alone on a\n\t\t\t\t\t\tline by themselves.\n\t\t\t\t\t",
        match: /^-{4,}[ \t]*(?<_1>$\n)?/,
        name: "meta.separator.mediawiki"},
       {begin: /^ (?=\s*\S)/,
        comment: 
         "\n\t\t\t\t\t\tCode blocks start with one space.  Wiki text and\n\t\t\t\t\t\thtml are still interpreted in MediaWiki, unlike in\n\t\t\t\t\t\tmediawiki.\n\t\t\t\t\t",
        end: "^(?=[^ ])",
        name: "markup.raw.block.mediawiki",
        patterns: [{include: "#inline"}]},
       {begin: /^(?<_1>[#*:;])/,
        comment: 
         "\n\t\t\t\t\t\tThis is preliminary.  Eventually it would be nice\n\t\t\t\t\t\tto scope each type of list differently, and even to\n\t\t\t\t\t\tdo scopes of nested lists.  There are 4 main things\n\t\t\t\t\t\twhich will be scoped as lists:\n\t\t\t\t\t\t\n\t\t\t\t\t\t  - numbered lists (#)\n\t\t\t\t\t\t  - unnumbered lists (*)\n\t\t\t\t\t\t  - definition lists (; :)\n\t\t\t\t\t\t  - indented paragraphs, as used on talk pages (:)\n\t\t\t\t\t\t\n\t\t\t\t\t\tthis last one might not even be scoped as a list in\n\t\t\t\t\t\tthe ideal case.  It is fine as a list for now,\n\t\t\t\t\t\thowever.\n\t\t\t\t\t",
        end: "^(?!\\1)",
        name: "markup.list.mediawiki",
        patterns: [{include: "#inline"}]},
       {include: "#table"},
       {include: "#comments"},
       {begin: /^(?![\t ;*#:=]|----|$)/,
        comment: 
         "\n\t\t\t\t\t\tAnything that is not a code block, list, header, etc.\n\t\t\t\t\t\tis a paragraph.\n\t\t\t\t\t",
        end: "^(?:\\s*$|(?=[;*#:=]|----))",
        name: "meta.paragraph.mediawiki",
        patterns: [{include: "#inline"}]}]},
   block_html: 
    {comment: 
      "\n\t\t\t\tThe available block HTML tags supported are:\n\t\t\t\t\n\t\t\t\t  * blockquote, center, pre, div, hr, p\n\t\t\t\t  * tables: table, th, tr, td, caption\n\t\t\t\t  * lists: ul, ol, li\n\t\t\t\t  * definition lists: dl, dt, dd\n\t\t\t\t  * headers: h1, h2, h3, h4, h5, h6\n\t\t\t\t  * br\n\t\t\t",
     patterns: 
      [{begin: /(?<_1><math>)/,
        captures: {1 => {name: "meta.tag.inline.math.mediawiki"}},
        contentName: "source.math.tex.embedded.mediawiki",
        end: "(</math>)",
        patterns: [{include: "text.tex.math"}]},
       {begin: /(?<_1><ref>)/,
        captures: {1 => {name: "meta.tag.inline.ref.mediawiki"}},
        contentName: "meta.reference.content.mediawiki",
        end: "(</ref>)",
        patterns: [{include: "#inline"}]},
       {begin: /(?<_1><gallery>)/,
        captures: {1 => {name: "meta.tag.inline.ref.mediawiki"}},
        contentName: "meta.gallery.mediawiki",
        end: "(</gallery>)",
        patterns: 
         [{begin: 
            /(?x)
	^(?!\s*\n)				# not an empty line
	(?<_1> [ ]*(?<_2>(?<_3>(?<_4>i|I)mage)(?<_5>:))  # spaces, image, colon
	  (?<_6>[^\[\]|]+)           # anything
	  (?<!\s)[ ]*           # spaces
	)?
	/,
           beginCaptures: 
            {3 => {name: "constant.other.namespace.image.mediawiki"},
             5 => {name: "punctuation.fix_this_later.colon.mediawiki"},
             6 => {name: "constant.other.wiki-link.image.mediawiki"}},
           end: "\\n",
           name: "meta.item.gallery.mediawiki",
           patterns: 
            [{begin: /^(?!\|)|(?<_1>\|)/,
              beginCaptures: 
               {1 => {name: "punctuation.fix_this_later.pipe.mediawiki"}},
              contentName: "string.other.title.gallery.mediawiki",
              end: "\\n|(?=\\|)",
              patterns: [{include: "#inline"}]},
             {match: /\|/,
              name: "punctuation.fix_this_later.pipe.mediawiki"}]}]}]},
   comments: 
    {patterns: 
      [{begin: /<!--/,
        end: "--\\s*>",
        name: "comment.block.html.mediawiki",
        patterns: 
         [{match: /--/,
           name: "invalid.illegal.bad-comments-or-CDATA.html.mediawiki"}]}]},
   entities: 
    {comment: 
      "\n\t\t\t\tMediawiki supports Unicode, so these should not usually be\n\t\t\t\tnecessary, but they do show up on pages from time to time.\n\t\t\t",
     patterns: 
      [{match: /&(?<_1>[a-zA-Z0-9]+|#[0-9]+|#x[0-9a-fA-F]+);/,
        name: "constant.character.entity.html.mediawiki"},
       {match: /&/, name: "invalid.illegal.bad-ampersand.html.mediawiki"}]},
   inline: 
    {patterns: 
      [{captures: 
         {1 => {name: "constant.other.date-time.mediawiki"},
          2 => {name: "invalid.illegal.too-many-tildes.mediawiki"}},
        match: /(?<_1>~~~~~)(?<_2>~{0,2})(?!~)/},
       {comment: "3 ~s for sig, 4 for sig + timestamp",
        match: /~~~~?/,
        name: "constant.other.signature.mediawiki"},
       {include: "#link"},
       {include: "#style"},
       {include: "#template"},
       {include: "#block_html"},
       {include: "#comments"}]},
   link: 
    {patterns: 
      [{applyEndPatternLast: 1,
        begin: 
         /(?x:
	(?<_1>\[\[)                         # opening brackets
	  (?<_2> [ ]*(?<_3>(?<_4>(?<_5>i|I)mage)(?<_6>:))       # spaces, image, colon
	    (?<_7>[^\[\]|]+)                # anything
	    (?<!\s)[ ]*                # spaces
	  )
	)/,
        beginCaptures: 
         {1 => {name: "punctuation.fix_this_later.brackets.mediwiki"},
          4 => {name: "constant.other.namespace.image.mediawiki"},
          6 => {name: "punctuation.fix_this_later.colon.mediawiki"},
          7 => {name: "constant.other.wiki-link.image.mediawiki"}},
        end: 
         "(?x:\n\t\t\t\t\t\t  ((\\|)[ ]*( [^\\[\\]|]+ )[ ]*)? # pipe, spaces, anything, spaces\n\t\t\t\t\t\t(\\]\\])                         # closing brackets\n\t\t\t\t\t)",
        endCaptures: 
         {2 => {name: "punctuation.fix_this_later.pipe.mediawiki"},
          3 => {name: "string.other.title.link.wiki-link.mediawiki"}},
        name: "meta.image.wiki.mediawiki",
        patterns: 
         [{captures: 
            {1 => {name: "punctuation.fix_this_later.pipe.mediawiki"},
             2 => {name: "keyword.control.image.formatting.mediawiki"},
             3 => {name: "keyword.control.image.alignment.mediawiki"},
             4 => {name: "constant.numeric.image.width.mediawiki"},
             5 => {name: "constant.other.unit.mediawiki"}},
           match: 
            /(?x)
	(?<_1>\|)[ ]*
	(?<_2> (?<_3>thumb|thumbnail|frame)
	 |(?<_4>right|left|center|none)
	 |(?<_5>[0-9]+)(?<_6>px)
	)[ ]*
	/},
          {match: /\|/, name: "punctuation.fix_this_later.pipe.mediawiki"},
          {include: "#style_in_link"}]},
       {begin: 
         /(?x:
	(?<_1>\[\[)                       # opening brackets
	  (?<_2>:)?                       # colon to suppress image or category?
	  (?<_3>(?<_4>\s+):[^\[\]]*(?=\]\]))?  # a colon after spaces is invalid
	  [ ]*                       # spaces
	  (?<_5> (?<_6>(?<_7>[^\[\]|]+)(?<_8>:))?        # namespace
	    (?<_9>[^\[\]|]+)(?<!\s)[ ]*   # link name
	  )?
	)/,
        beginCaptures: 
         {1 => {name: "punctuation.fix_this_later.brackets.mediawiki"},
          2 => 
           {name: 
             "keyword.operator.wiki-link.suppress-image-or-category.mediawiki"},
          4 => {name: "invalid.illegal.whitespace.mediawiki"},
          7 => {name: "constant.other.namespace.mediawiki"},
          8 => {name: "punctuation.fix_this_later.colon.mediawiki"},
          9 => {name: "constant.other.wiki-link.mediawiki"}},
        end: 
         "(?x:\n\t\t\t\t\t\t  (\\|[ ]*([^\\[\\]|]+)[ ]*)?     # pipe, spaces, anything, spaces\n\t\t\t\t\t\t(\\]\\])                         # closing brackets\n\t\t\t\t\t)",
        endCaptures: 
         {2 => {name: "string.other.title.link.wiki-link.mediawiki"}},
        name: "meta.link.wiki.mediawiki",
        patterns: [{include: "#style_in_link"}]},
       {begin: /\[(?<_1>\S+)\s*(?=[^\]]*\])/,
        beginCaptures: 
         {1 => {name: "markup.underline.link.external.mediawiki"}},
        contentName: "string.other.title.link.external.mediawiki",
        end: "\\]",
        name: "meta.link.inline.external.mediawiki",
        patterns: [{include: "#style_in_link"}]},
       {match: 
         /(?<_1>(?<_2>https?|ftp|file):\/\/|mailto:)[-:@a-zA-Z0-9_.~%+\/?=&#]+(?<![.?:])/,
        name: "markup.underline.link.external.mediawiki"}]},
   style: 
    {comment: 
      "\n\t\t\t\tTODO: We still need to add:\n\n\t\t\t\t  * font\n\t\t\t\t  * ruby, rb, rp, rt\n\t\t\t\t  * cite\n\t\t\t\t\n\t\t\t\tinline tags to this section, and make sure that the other\n\t\t\t\ttags can accept attributes in the tag opening, etc.  The\n\t\t\t\tcurrent implementation is intended to be naive, but covering\n\t\t\t\tthe majority of uses in mediawiki code.\n\t\t\t\t\n\t\t\t\tWe also need to add mediawiki-specific tags:\n\t\t\t\t\n\t\t\t\t  * nowiki, noinclude, includeonly\n\t\t\t\t\n\t\t\t",
     patterns: 
      [{begin: /'''/,
        end: "'''",
        name: "markup.bold.mediawiki",
        patterns: [{include: "#inline"}]},
       {begin: /''/,
        end: "''(?!'[^'])",
        name: "markup.italic.mediawiki",
        patterns: [{include: "#inline"}]},
       {begin: /(?<_1><(?<_2>b|strong)>)/,
        captures: {1 => {name: "meta.tag.inline.bold.html.mediawiki"}},
        contentName: "markup.bold.html.mediawiki",
        end: "(</\\2>)",
        patterns: [{include: "#inline"}]},
       {begin: /(?<_1><(?<_2>i|em)>)/,
        captures: {1 => {name: "meta.tag.inline.italic.html.mediawiki"}},
        contentName: "markup.italic.html.mediawiki",
        end: "(</\\2>)",
        patterns: [{include: "#inline"}]},
       {begin: /(?<_1><(?<_2>s|strike)>)/,
        captures: 
         {1 => {name: "meta.tag.inline.strikethrough.html.mediawiki"}},
        contentName: "markup.other.strikethrough.html.mediawiki",
        end: "(</\\2>)",
        patterns: [{include: "#inline"}]},
       {begin: /(?<_1><(?<_2>u)>)/,
        captures: {1 => {name: "meta.tag.inline.underline.html.mediawiki"}},
        contentName: "markup.underline.html.mediawiki",
        end: "(</\\2>)",
        patterns: [{include: "#inline"}]},
       {begin: /(?<_1><(?<_2>tt|code)>)/,
        captures: {1 => {name: "meta.tag.inline.raw.html.mediawiki"}},
        contentName: "markup.raw.html.mediawiki",
        end: "(</\\2>)",
        patterns: [{include: "#inline"}]},
       {begin: /(?<_1><(?<_2>big|small|sub|sup)>)/,
        captures: {1 => {name: "meta.tag.inline.any.html.mediawiki"}},
        contentName: "markup.other.inline-styles.html.mediawiki",
        end: "(</\\2>)",
        patterns: [{include: "#inline"}]}]},
   style_in_link: 
    {patterns: 
      [{begin: /'''/,
        end: "'''",
        name: "markup.bold.mediawiki",
        patterns: [{include: "#style_in_link"}]},
       {begin: /''/,
        end: "''",
        name: "markup.italic.mediawiki",
        patterns: [{include: "#style_in_link"}]},
       {begin: /(?<_1><(?<_2>b|strong)>)/,
        captures: {1 => {name: "meta.tag.inline.bold.html.mediawiki"}},
        contentName: "markup.bold.html.mediawiki",
        end: "(</\\2>)",
        patterns: [{include: "#style_in_link"}]},
       {begin: /(?<_1><(?<_2>i|em)>)/,
        captures: {1 => {name: "meta.tag.inline.italic.html.mediawiki"}},
        contentName: "markup.italic.html.mediawiki",
        end: "(</\\2>)",
        patterns: [{include: "#style_in_link"}]},
       {begin: /(?<_1><(?<_2>s|strike)>)/,
        captures: 
         {1 => {name: "meta.tag.inline.strikethrough.html.mediawiki"}},
        contentName: "markup.other.strikethrough.html.mediawiki",
        end: "(</\\2>)",
        patterns: [{include: "#style_in_link"}]},
       {begin: /(?<_1><(?<_2>u)>)/,
        captures: {1 => {name: "meta.tag.inline.underline.html.mediawiki"}},
        contentName: "markup.underline.html.mediawiki",
        end: "(</\\2>)",
        patterns: [{include: "#style_in_link"}]},
       {begin: /(?<_1><(?<_2>tt|code)>)/,
        captures: {1 => {name: "meta.tag.inline.raw.html.mediawiki"}},
        contentName: "markup.raw.html.mediawiki",
        end: "(</\\2>)",
        patterns: [{include: "#style_in_link"}]},
       {begin: /(?<_1><(?<_2>big|small|sub|sup)>)/,
        captures: {1 => {name: "meta.tag.inline.any.html.mediawiki"}},
        contentName: "markup.other.inline-styles.html.mediawiki",
        end: "(</\\2>)",
        patterns: [{include: "#style_in_link"}]},
       {include: "#comments"}]},
   table: 
    {patterns: 
      [{begin: /^{\|/,
        comment: 
         "\n\t\t\t\t\t\twe are going to have to add the styling capabilities\n\t\t\t\t\t\tto this section eventually.  It is complicated,\n\t\t\t\t\t\tthough, so I am putting it off.\n\t\t\t\t\t",
        end: "^\\|}",
        name: "markup.other.table.mediawiki",
        patterns: 
         [{begin: /^\|-/,
           comment: 
            "\n\t\t\t\t\t\t\t\thopefully we can allow selection of a whole\n\t\t\t\t\t\t\t\ttable row, and possibly later allow things\n\t\t\t\t\t\t\t\tlike moving a whole row up/down, etc.\n\t\t\t\t\t\t\t",
           end: "^(?=\\|-|\\|})",
           name: "markup.other.table.row.mediawiki",
           patterns: [{include: "#inline"}]},
          {include: "#inline"}]}]},
   template: 
    {comment: 
      "\n\t\t\t\tThis repository item covers templates and parser functions.\n\t\t\t",
     patterns: 
      [{captures: 
         {1 => {name: "variable.parameter.template.numeric.mediawiki"}},
        match: /{{{[ ]*(?<_1>[0-9]+)[ ]*}}}/,
        name: "meta.template-parameter.mediawiki"},
       {captures: {1 => {name: "variable.parameter.template.named.mediawiki"}},
        match: /{{{[ ]*(?<_1>.*?)[ ]*}}}/,
        name: "meta.template-parameter.mediawiki"},
       {begin: /(?<_1>{{)(?=[ ]*#)/,
        beginCaptures: 
         {1 => {name: "punctuation.fix_this_later.template.mediawiki"},
          2 => {name: "meta.function-call.template.mediawiki"}},
        comment: 
         "\n\t\t\t\t\t\tWhy oh why did mediawiki have to add these??\n\t\t\t\t\t",
        end: "(}})",
        endCaptures: 
         {1 => {name: "punctuation.fix_this_later.template.mediawiki"}},
        name: "meta.template.parser-function.mediawiki",
        patterns: [{include: "#inline"}]},
       {begin: /(?<_1>{{)(?<_2>[^{}\|]+)?/,
        beginCaptures: 
         {1 => {name: "punctuation.fix_this_later.template.mediawiki"},
          2 => {name: "meta.function-call.template.mediawiki"}},
        comment: 
         "\n\t\t\t\t\t\tI am not sure I really like the scope of\n\t\t\t\t\t\tmeta.function-call for templates, but it seems like\n\t\t\t\t\t\tthe closest thing to what a template is really doing,\n\t\t\t\t\t\twith parameters, etc.\n\t\t\t\t\t",
        end: "(}})",
        endCaptures: 
         {1 => {name: "punctuation.fix_this_later.template.mediawiki"}},
        name: "meta.template.mediawiki",
        patterns: 
         [{include: "#comments"},
          {begin: /(?<_1>\|)\s*(?<_2>=)/,
           beginCaptures: 
            {1 => {name: "punctuation.fix_this_later.pipe.mediawiki"},
             2 => {name: "punctuation.fix_this_later.equals-sign.mediawiki"}},
           contentName: "comment.block.template-hack.mediawiki",
           end: "(?=[|}])"},
          {begin: /(?<_1>\|)(?<_2>(?<_3>[^{}\|=]+)(?<_4>=))?/,
           beginCaptures: 
            {1 => {name: "punctuation.fix_this_later.pipe.mediawiki"},
             2 => {name: "variable.parameter.template.mediawiki"},
             3 => {name: "punctuation.fix_this_later.equals-sign.mediawiki"}},
           contentName: "meta.value.template.mediawiki",
           end: "(?=[|}])",
           patterns: [{include: "#inline"}]},
          {match: /\|/,
           name: "punctuation.fix_this_later.pipe.mediawiki"}]}]}},
 scopeName: "text.html.mediawiki",
 uuid: "6AF21ADF-316A-47D1-A8B6-1BB38637DE9A"}
