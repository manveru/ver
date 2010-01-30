# Encoding: UTF-8

{fileTypes: ["yaws"],
 foldingStartMarker: 
  /(?x)
	(<(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl|erl)\b.*?>
	|<!--(?!.*-->)
	|\{\s*($|\?>\s*$|\/\/|\/\*(.*\*\/\s*$|(?!.*?\*\/)))
	)/,
 foldingStopMarker: 
  /(?x)
	(<\/(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl|erl)>
	|^\s*-->
	|(^|\s)\}
	)/,
 keyEquivalent: "^~E",
 name: "HTML (Erlang)",
 patterns: 
  [{begin: /<erl>/,
    captures: {0 => {name: "punctuation.section.embedded.erlang"}},
    end: "</erl>",
    name: "source.erlang.embedded.html",
    patterns: [{include: "source.erlang"}]},
   {include: "text.html.basic"}],
 scopeName: "text.html.erlang.yaws",
 uuid: "3FBFF015-B650-4734-848C-47B53ACD5E32"}
