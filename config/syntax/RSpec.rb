# Encoding: UTF-8

{fileTypes: ["spec.rb"],
 foldingStartMarker: 
  /(?x)^
	    (\s*+
	        (module|class|def
	        |unless|if
	        |case
	        |begin
	        |for|while|until
	 |^=begin
	        |(  "(\\.|[^"])*+"          # eat a double quoted string
	         | '(\\.|[^'])*+'        # eat a single quoted string
	         |   [^#"']                # eat all but comments and strings
	         )*
	         (                        \s   (do|begin|case)
	         | (?<!\$)[-+=&|*\/~%^<>~] \s*+ (if|unless)
	         )
	        )\b
	        (?! [^;]*+ ; .*? \bend\b )
	    |(  "(\\.|[^"])*+"              # eat a double quoted string
	     | '(\\.|[^'])*+'            # eat a single quoted string
	     |   [^#"']                    # eat all but comments and strings
	     )*
	     ( \{ (?!  [^}]*+ \} )
	     | \[ (?! [^\]]*+ \] )
	     )
	    ).*$
	|   [#] .*? \(fold\) \s*+ $         # Sune’s special marker
	/,
 foldingStopMarker: 
  /(?x)
	(   (^|;) \s*+ end   \s*+ ([#].*)? $
	|   (^|;) \s*+ end \. .* $
	|   ^     \s*+ [}\]] \s*+ ([#].*)? $
	|   [#] .*? \(end\) \s*+ $    # Sune’s special marker
	|   ^=end
	)/,
 keyEquivalent: "^~R",
 name: "RSpec",
 patterns: 
  [{match: /(?<!\.)\b(before|after)\b(?![?!])/,
    name: "keyword.other.special-method.ruby.rspec"},
   {include: "#behaviour"},
   {include: "#example"},
   {include: "source.ruby"}],
 repository: 
  {behaviour: 
    {begin: /^\s*(describe)\b/,
     beginCaptures: {1 => {name: "keyword.other.behaviour.ruby.rspec"}},
     end: "\\b(do)\\s*$",
     endCaptures: {1 => {name: "keyword.control.start-block.ruby.rspec"}},
     name: "meta.behaviour.ruby.rspec",
     patterns: [{include: "source.ruby"}]},
   example: 
    {begin: /^\s*(it)\b/,
     beginCaptures: {1 => {name: "keyword.other.example.ruby.rspec"}},
     end: "\\b(do)\\s*$",
     endCaptures: {1 => {name: "keyword.control.start-block.ruby.rspec"}},
     name: "meta.example.ruby.rspec",
     patterns: [{include: "source.ruby"}]}},
 scopeName: "source.ruby.rspec",
 uuid: "923F0A10-96B9-4792-99A4-94FEF66E0B8C"}
