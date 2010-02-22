# Encoding: UTF-8

{fileTypes: ["a4l"],
 foldingStartMarker: 
  /(?x)
	(?<_1>^\s*(?i:if|while|for\ each|for|case\ of|repeat|method)\b
	|^\s*<fusedoc\ fuse
	)/,
 foldingStopMarker: 
  /(?x)
	(?<_1>^\s*(?i:end\ (?<_2>if|while|for\ each|for|case|method)|until)\b
	|^\s*<\/fusedoc>
	)/,
 keyEquivalent: "^~A",
 name: "Active4D Library",
 patterns: 
  [{match: /(?i:end library|library)/, name: "keyword.other.active4d"},
   {include: "source.active4d"}],
 scopeName: "source.active4d.library",
 uuid: "A595B09A-3829-48CB-958B-7D6C4646409D"}
