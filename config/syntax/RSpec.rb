# Encoding: UTF-8

{fileTypes: ["spec.rb"],
 foldingStartMarker: 
  /(?x)^
	    (?<_1>\s*+
	        (?<_2>module|class|def
	        |unless|if
	        |case
	        |begin
	        |for|while|until
	 |^=begin
	        |(?<_3>  "(?<_4>\\.|[^"])*+"          # eat a double quoted string
	         | '(?<_5>\\.|[^'])*+'        # eat a single quoted string
	         |   [^#"']                # eat all but comments and strings
	         )*
	         (?<_6>                        \s   (?<_7>do|begin|case)
	         | (?<!\$)[-+=&|*\/~%^<>~] \s*+ (?<_8>if|unless)
	         )
	        )\b
	        (?! [^;]*+ ; .*? \bend\b )
	    |(?<_9>  "(?<_10>\\.|[^"])*+"              # eat a double quoted string
	     | '(?<_11>\\.|[^'])*+'            # eat a single quoted string
	     |   [^#"']                    # eat all but comments and strings
	     )*
	     (?<_12> \{ (?!  [^}]*+ \} )
	     | \[ (?! [^\]]*+ \] )
	     )
	    ).*$
	|   [#] .*? \(fold\) \s*+ $         # Sune’s special marker
	/,
 foldingStopMarker: 
  /(?x)
	(?<_1>   (?<_2>^|;) \s*+ end   \s*+ (?<_3>[#].*)? $
	|   (?<_4>^|;) \s*+ end \. .* $
	|   ^     \s*+ [}\]] \s*+ (?<_5>[#].*)? $
	|   [#] .*? \(end\) \s*+ $    # Sune’s special marker
	|   ^=end
	)/,
 keyEquivalent: "^~R",
 name: "RSpec",
 patterns: 
  [{match: /(?<!\.)\b(?<_1>before|after)\b(?![?!])/,
    name: "keyword.other.special-method.ruby.rspec"},
   {include: "#behaviour"},
   {include: "#example"},
   {include: "source.ruby"}],
 repository: 
  {behaviour: 
    {begin: /^\s*(?<_1>describe)\b/,
     beginCaptures: {1 => {name: "keyword.other.behaviour.ruby.rspec"}},
     end: "\\b(do)\\s*$",
     endCaptures: {1 => {name: "keyword.control.start-block.ruby.rspec"}},
     name: "meta.behaviour.ruby.rspec",
     patterns: [{include: "source.ruby"}]},
   example: 
    {begin: /^\s*(?<_1>it)\b/,
     beginCaptures: {1 => {name: "keyword.other.example.ruby.rspec"}},
     end: "\\b(do)\\s*$",
     endCaptures: {1 => {name: "keyword.control.start-block.ruby.rspec"}},
     name: "meta.example.ruby.rspec",
     patterns: [{include: "source.ruby"}]}},
 scopeName: "source.ruby.rspec",
 uuid: "923F0A10-96B9-4792-99A4-94FEF66E0B8C"}
