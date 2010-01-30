# Encoding: UTF-8

{comment: 
  "\n\t\tThis bundle is, as can easily be seen, far from complete,\n\t\tbut it should still be as useful as the Lilypond.app pyobjc\n\t\tapplication, which has no syntax coloring, no way to do\n\t\tsnippets, and pretty much no interesting functionality at\n\t\tall, other than a \"Run\" menu option. :)\n\t",
 fileTypes: ["ly", "lily", "ily"],
 foldingStartMarker: /(\{|<<)\s*$/,
 foldingStopMarker: /(\}|>>)/,
 keyEquivalent: "^~L",
 name: "LilyPond",
 patterns: 
  [{include: "#comments"},
   {include: "#g_header"},
   {include: "#groupings"},
   {include: "#strings"},
   {include: "#scheme"},
   {include: "#functions"}],
 repository: 
  {comments: 
    {patterns: 
      [{begin: /%{/,
        captures: {0 => {name: "punctuation.definition.comment.lilypond"}},
        end: "%}",
        name: "comment.block.lilypond"},
       {begin: /%/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.comment.lilypond"}},
        end: "$\\n?",
        name: "comment.line.lilypond"}]},
   f_clef: 
    {captures: 
      {1 => {name: "support.function.element.lilypond"},
       2 => {name: "punctuation.definition.function.lilypond"},
       3 => {name: "punctuation.definition.string.lilypond"},
       4 => {name: "constant.language.clef-name.lilypond"},
       5 => {name: "constant.other.modifier.clef.lilypond"},
       6 => {name: "meta.fixme.unknown-clef-name.lilypond"},
       7 => {name: "constant.other.modifier.clef.lilypond"},
       8 => {name: "punctuation.definition.string.lilypond"}},
     comment: 
      "\n\t\t\t\tThis looks something like:   \\clef mezzosoprano_8\n\t\t\t\tOr maybe:                    \\clef neomensural-c3^15\n\t\t\t",
     match: 
      /(?x)
	((\\) clef) \s+  # backslash + "clef" + spaces (groups 1-2)
	(?:
	  ("?)	# beginning quotes (group 3)
	  (?:
	  ( (?: # group 4
	  treble | violin | G | french |                    # G clefs
	      alto | C | tenor | (?:mezzo)?soprano | baritone | # C clefs
	      (?:sub)?bass | F | varbaritone |                  # F clefs
	      percussion | tab | # percussion \/ tablature clefs
                      
	          (?:neo)?mensural-c[1-4] | mensural-[fg] | 		# Ancient clefs
	      petrucci-(?: [fg] | c[1-5] ) |
	      (?: vaticana | medicaea | hufnagel ) - (?: do[1-3] | fa[12] ) |
	      hufnagel-do-fa
	    )
	    ([_^](?:8|15)?)? # optionally shift 1-2 octaves ↑\/↓ (group 5)
	  ) |
	  ( (?:\w+) ([_^](?:8|15))? ) # unknown clef name (groups 6-7)
	  )
	  (\3) # closing quotes (group 8)
	)?
	/,
     name: "meta.element.clef.lilypond"},
   f_generic: 
    {captures: {1 => {name: "punctuation.definition.function.lilypond"}},
     match: /(\\)[a-zA-Z-]+\b/,
     name: "support.function.general.lilypond"},
   :"f_key-signature" => 
    {comment: "FIXME", name: "meta.element.key-signature.lilypond"},
   f_keywords: 
    {captures: {1 => {name: "punctuation.definition.function.lilypond"}},
     match: /(?x)
	(?: (\\)
	    (?: set | new | override | revert)\b
	)
	/,
     name: "keyword.control.lilypond"},
   :"f_time-signature" => 
    {captures: 
      {1 => {name: "support.function.element.lilypond"},
       2 => {name: "punctuation.definition.function.lilypond"},
       3 => {name: "constant.numeric.time-signature.lilypond"}},
     match: 
      /(?x)
	((\\) time) \s+ # backslash + "time" + spaces (groups 1-2)
	([1-9][0-9]*\/[1-9][0-9]*)?
	/,
     name: "meta.element.time-signature.lilypond"},
   functions: 
    {patterns: 
      [{include: "#f_clef"},
       {include: "#f_time-signature"},
       {include: "#f_key-signature"},
       {include: "#f_keywords"},
       {include: "#f_generic"}]},
   g_header: 
    {begin: /((\\)header)\s*({)/,
     beginCaptures: 
      {1 => {name: "support.function.section.header.lilypond"},
       2 => {name: "punctuation.definition.function.lilypond"},
       3 => {name: "punctuation.section.group.begin.lilypond"}},
     end: "}",
     endCaptures: {0 => {name: "punctuation.section.group.end.lilypond"}},
     name: "meta.header.lilypond",
     patterns: 
      [{include: "#comments"},
       {include: "#strings"},
       {include: "#scheme"},
       {include: "#g_markup"},
       {match: /=/, name: "punctuation.separator.key-value.lilypond"},
       {match: 
         /(?x)
	dedication | title | subtitle | subsubtitle | poet |
	composer | meter | opus | arranger | instrument |
	piece | breakbefore | copyright | tagline | enteredby
	/,
        name: "support.constant.header.lilypond"},
       {match: 
         /(?x)
	mutopiatitle | mutopiacomposer | mutopiapoet |
	mutopiaopus | mutopiainstrument | date | source |
	style | maintainer | maintainerEmail |
	maintainerWeb | lastupdated
	/,
        name: "support.constant.header.mutopia.lilypond"}]},
   g_m_group: 
    {begin: /{/,
     beginCaptures: {0 => {name: "punctuation.section.group.begin.lilypond"}},
     end: "}",
     endCaptures: {0 => {name: "punctuation.section.group.end.lilypond"}},
     name: "meta.group.lilypond",
     patterns: 
      [{include: "#f_generic"},
       {include: "#strings"},
       {include: "#comments"},
       {include: "#scheme"},
       {include: "#g_m_group"}]},
   g_markup: 
    {begin: /(?x)
	((\\) markup) \s+ # backslash + "markup" + spaces
	(?={)
	/,
     beginCaptures: 
      {1 => {name: "support.function.element.markup.lilypond"},
       2 => {name: "punctuation.definition.function.markup"}},
     end: "(?<=})",
     name: "meta.element.markup.lilypond",
     patterns: [{include: "#g_m_group"}]},
   g_relative: 
    {begin: /((\\)relative)\s*(?:([a-h][',]*)\s*)?(?={)/,
     beginCaptures: 
      {1 => {name: "support.function.section.lilypond"},
       2 => {name: "punctuation.definition.function.lilypond"},
       3 => {name: "storage.type.pitch.lilypond"}},
     end: "(?<=})",
     patterns: [{include: "#group"}]},
   g_system: 
    {begin: /<</,
     beginCaptures: {0 => {name: "punctuation.section.system.begin.lilypond"}},
     end: ">>",
     endCaptures: {0 => {name: "punctuation.section.system.end.lilypond"}},
     name: "meta.system.lilypond",
     patterns: [{include: "$self"}]},
   g_times: 
    {begin: /((\\)times)\s*(?:([1-9][0-9]*\/[1-9][0-9])\s*)(?={)/,
     beginCaptures: 
      {1 => {name: "support.function.section.lilypond"},
       2 => {name: "punctuation.definition.function.lilypond"},
       3 => {name: "constant.numeric.fraction.lilypond"}},
     end: "(?<=})",
     patterns: [{include: "#group"}]},
   group: 
    {begin: /{/,
     beginCaptures: {0 => {name: "punctuation.section.group.begin.lilypond"}},
     end: "}",
     endCaptures: {0 => {name: "punctuation.section.group.end.lilypond"}},
     name: "meta.music-expression.lilypond",
     patterns: [{include: "#music-expr"}]},
   groupings: 
    {patterns: 
      [{include: "#g_system"},
       {include: "#g_relative"},
       {include: "#g_times"},
       {include: "#group"}]},
   :"music-expr" => 
    {patterns: 
      [{include: "#comments"},
       {include: "#groupings"},
       {include: "#strings"},
       {include: "#functions"},
       {include: "#scheme"},
       {include: "#notes"}]},
   n_articulations: 
    {patterns: 
      [{match: /(?x)
	([_^-])
	(?:[.>^+|_-])
	/,
        name: "storage.modifier.articulation.accent.lilypond"},
       {captures: {1 => {name: "punctuation.definition.function.lilypond"}},
        match: 
         /(?x)
	(\\)
	(?: accent | markato | staccatissimo |		       # basic accents
	espressivo | staccato | tenuto | portato | 
	(?:up|down)bow | flageolet | thumb |
	[lr](?:heel|toe) | open | stopped |
	(?:reverse)?turn | trill |
	prall(?: prall | mordent | down | up)? |       # pralls
	(?: up | down | line ) prall |                 # and
	(?: up | down )? mordent |                     # mordents
	signumcongruentiae |
	(?: (?:very)? long | short)?fermata(Markup)? | # fermatas
	segno | (?:var)?coda 
	)
	/,
        name: "storage.modifier.articulation.named.lilypond"},
       {match: 
         /(?x)
	(\\) # backslash
	(?:
	    p{1,5} | m[pf] | f{1,4} | fp | # forte, piano, etc.
    						[sr]fz | sff? | spp? | 
    						< | > | ! | espressivo         # (de)crescendo
	)
	/,
        name: "storage.modifier.articulation.dynamics.lilypond"},
       {match: /\[|\]/, name: "storage.modifier.beam.lilypond"},
       {match: /\(|\)/, name: "storage.modifier.slur.lilypond"},
       {match: /\\\(|\\\)/, name: "storage.modifier.slur.phrasing.lilypond"}]},
   notes: 
    {comment: 
      "\n\t\t\t\tThis section includes the rules for notes, rests, and chords\n\t\t\t",
     patterns: 
      [{begin: 
         /(?x)\b
	    (						  # (group 1)
	  ( [a-h]                 # Pitch (group 2)
	    ( (?:i[sh]){1,2} |    #   - sharp (group 3)
	      (?:e[sh]|s){1,2}    #   - flat
	    )?
	        (?:(\!)|(\?))?               # Cautionary accidental (groups 4-5)
	        ('+|,+)?             # Octave (group 6)
	  )
	  ( ( ((\\)breve)|        # Duration (groups 7-10)
	      64|32|16|8|4|2|1
	    )
	    (\.+)?                 # Augmentation dot (group 11)
	((?:(\*)(\d+(?:\/\d+)?))*) # Scaling duration (groups 12-14)
	  )?
	)(?![a-z])	# do not follow a note with a letter
	/,
        beginCaptures: 
         {10 => {name: "punctuation.definition.function.lilypond"},
          13 => {name: "keyword.operator.duration-scale.lilypond"},
          14 => {name: "constant.numeric.fraction.lilypond"},
          2 => {name: "storage.type.pitch.lilypond"},
          4 => {name: "meta.note-modifier.accidental.reminder.lilypond"},
          5 => {name: "meta.note-modifier.accidental.cautionary.lilypond"},
          6 => {name: "meta.note-modifier.octave.lilypond"},
          7 => {name: "storage.type.duration.lilypond"}},
        comment: 
         "\n\t\t\t\t\t\tThis rule handles notes, including the pitch, the\n\t\t\t\t\t\tduration, and any articulations drawn along with\n\t\t\t\t\t\tthe note.\n\t\t\t\t\t\t\n\t\t\t\t\t\tThis rule gets a whole lot uglier if we want to\n\t\t\t\t\t\tsupport multilingual note names.  If so, the rule\n\t\t\t\t\t\tgoes something like:\n\t\t\t\t\t\t\n\t\t\t\t\t\t(?x)\n\t\t\t\t\t\t\t\\b( # Basic Pitches\n\t\t\t\t\t\t\t  [a-h]  # Dutch/English/etc.                         \n\t\t\t\t\t\t\t  (?: (iss?|s|sharp|x)(iss?|s|sharp|x|ih) | # sharp / flat\n\t\t\t\t\t\t\t\t  (ess?|s|flat|f)(ess?|s|flat|f|eh)\n\t\t\t\t\t\t\t  )? |\n\t\t\t\t\t\t\t  (?: do|re|mi|fa|sol|la|si) # Italian/Spanish\n\t\t\t\t\t\t\t  (?: ss?|dd?bb?) # sharp/flat\n\t\t\t\t\t\t\t)\n\t\t\t\t\t\t...\n\t\t\t\t\t",
        end: 
         "(?x)\n\t\t\t\t\t\t(?= [\\s}~a-z] |$) # End when we encounter a space or } or end of line\n\t\t\t\t\t",
        name: "meta.element.note.lilypond",
        patterns: [{include: "#n_articulations"}]},
       {begin: 
         /(?x)\b
	(?:(r)|(R)) # (groups 1-2)
	( ( (\\)breve|       # Duration (groups 3-5)
	    64|32|16|8|4|2|1
	  )
	  (\.+)?                 # Augmentation dot (group 6)
	  ((?:(\*)(\d+(?:\/\d+)?))*) # Scaling duration (groups 7-9)
	
	)?
	(?![a-z])	# do not follow a note with a letter
	/,
        beginCaptures: 
         {1 => {name: "storage.type.pause.rest.lilypond"},
          2 => {name: "storage.type.pause.rest.multi-measure.lilypond"},
          3 => {name: "storage.type.duration.lilypond"},
          5 => {name: "punctuation.definition.function.lilypond"},
          7 => {name: "keyword.operator.duration-scale.lilypond"},
          9 => {name: "constant.numeric.fraction.lilypond"}},
        end: "(?=[\\s}~a-z])",
        name: "meta.element.pause.rest.lilypond",
        patterns: [{include: "#n_articulations"}]},
       {begin: 
         /(?x)\b
	(s) # (group 1)
	( ( (\\)breve|       # Duration (groups 2-4)
	    64|32|16|8|4|2|1
	  )
	  (\.+)?                 # Augmentation dot (group 5)
	  ((?:(\*)(\d+(?:\/\d+)?))*) # Scaling duration (groups 6-8)
	
	)?
	(?![a-z])	# do not follow a note with a letter
	/,
        beginCaptures: 
         {1 => {name: "storage.type.pause.skip.lilypond"},
          2 => {name: "storage.type.duration.lilypond"},
          4 => {name: "punctuation.definition.function.lilypond"},
          6 => {name: "keyword.operator.duration-scale.lilypond"},
          8 => {name: "constant.numeric.fraction.lilypond"}},
        end: "(?=[\\s}~a-z]|$)",
        name: "meta.element.pause.skip.lilypond",
        patterns: [{include: "#n_articulations"}]},
       {captures: 
         {1 => {name: "storage.type.pause.skip.lilypond"},
          2 => {name: "punctuation.definition.function.lilypond"},
          3 => {name: "storage.type.duration.lilypond"}},
        match: /((\\)skip)\s+(64|32|16|8|4|2|1)/,
        name: "meta.element.pause.skip.lilypond"},
       {begin: /</,
        beginCaptures: {0 => {name: "punctuation.definition.chord.lilypond"}},
        comment: 
         "\n\t\t\t\t\t\tLilypond chords look like:    < a b c >\n\t\t\t\t\t",
        end: ">",
        endCaptures: {0 => {name: "punctuation.definition.chord.lilypond"}},
        name: "meta.element.chord.lilypond",
        patterns: 
         [{captures: 
            {1 => {name: "storage.type.pitch.lilypond"},
             3 => {name: "meta.note-modifier.accidental.reminder.lilypond"},
             4 => {name: "meta.note-modifier.accidental.cautionary.lilypond"},
             5 => {name: "meta.note-modifier.octave.lilypond"}},
           match: 
            /(?x)\b
	  ( [a-h]                 # Pitch (group 1)
	    ( (?:i[sh]){1,2} |    #   - sharp (group 2)
	      (?:e[sh]|s){1,2}    #   - flat
	    )?
	        (?:(\!)|(\?))?       # Reminder\/cautionary accidental (groups 3-4)
	        ('+|,+)?             # Octave (group 5)
	  )
	/}]},
       {begin: 
         /(?x)
	    (?<!-)
	    (?<=>)
	(
	( ( ((\\)breve)|        # Duration (groups 1-4)
	    64|32|16|8|4|2|1
	  )
	  (\.+)?                  # Augmentation dot (group 5)
	) |
	(?![\s}~a-z]|$)
	)
	/,
        beginCaptures: 
         {1 => {name: "storage.type.duration.lilypond"},
          4 => {name: "punctuation.definition.function.lilypond"}},
        comment: 
         "\n\t\t\t\t\t\tThis rule attaches stuff to the end of a chord\n\t\t\t\t\t\t\n\t\t\t\t\t\tTherefore it begins after the > which ends a chord,\n\t\t\t\t\t\tand does not end after a > which ends a chord.\n\t\t\t\t\t\t(to avoid infinite loops)\n\t\t\t\t\t",
        end: "(?=[\\s}~a-z]|$)(?<![^-]>)",
        name: "meta.element.chord.lilypond",
        patterns: [{include: "#n_articulations"}]},
       {match: /~/, name: "storage.type.tie.lilypond"},
       {captures: {1 => {name: "punctuation.definition.function.lilypond"}},
        match: /(\\)breathe/,
        name: "storage.type.breath-mark.lilypond"}]},
   scheme: 
    {begin: /#/,
     beginCaptures: 
      {0 => {name: "punctuation.section.embedded.scheme.lilypond"}},
     comment: 
      "\n\t\t\t\tLilypond source can embed scheme code to do things more\n\t\t\t\tflexibly than allowed by the basic language.\n\n\t\t\t\tWe need to make sure to match after a \\n, as included\n\t\t\t\tby some s-expressions in the scheme grammar.\n\t\t\t",
     contentName: "source.scheme.embedded.lilypond",
     end: "(?=[\\s%])|(?<=\\n)",
     patterns: [{include: "source.scheme"}]},
   strings: 
    {begin: /"/,
     captures: {0 => {name: "punctuation.definition.string.lilypond"}},
     end: "\"",
     name: "string.quoted.double.lilypond",
     patterns: [{match: /\\./, name: "constant.character.escape.lilypond"}]}},
 scopeName: "source.lilypond",
 uuid: "F25B30BE-0526-4D92-806C-F0D678DDF669"}
