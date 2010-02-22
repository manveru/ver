# Encoding: UTF-8

{fileTypes: ["mm", "M", "h"],
 foldingStartMarker: 
  /(?x)
	 \/\*\*(?!\*)
	|^(?![^{]*?\/\/|[^{]*?\/\*(?!.*?\*\/.*?\{)).*?\{\s*(?<_1>$|\/\/|\/\*(?!.*?\*\/.*\S))
	|^@(?<_2>interface|protocol|implementation)\b
	/,
 foldingStopMarker: /(?<!\*)\*\*\/|^\s*\}|^@end\b/,
 keyEquivalent: "^~O",
 name: "Objective-C++",
 patterns: [{include: "source.c++"}, {include: "source.objc"}],
 scopeName: "source.objc++",
 uuid: "FDAB1813-6B1C-11D9-BCAC-000D93589AF6"}
