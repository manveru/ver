# Encoding: UTF-8

[{name: "Spell Checking: Disable for Raw",
  scope: "text.html.textile markup.raw",
  settings: {spellChecking: "0"},
  uuid: "399D65CB-7CA9-4F91-B454-11EA9F6D1501"},
 {name: "Typing Pairs: Defaults",
  scope: "text.html.textile",
  settings: 
   {smartTypingPairs: 
     [["_", "_"],
      ["*", "*"],
      ["\"", "\""],
      ["(", ")"],
      ["{", "}"],
      ["[", "]"],
      ["“", "”"],
      ["`", "`"],
      ["@", "@"],
      ["%", "%"],
      ["^", "^"],
      ["~", "~"]]},
  uuid: "18DE9523-B3B2-42EE-A099-210635E7FFEB"},
 {name: "Symbol List: Heading",
  scope: "text.html.textile markup.heading.textile",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: 
     "\n\t\ts/\\s*$//;\t\t\t\t# strip spaces\n\t\ts/^\\s*//;\n\t\ts/(^(h[1-6])([<>=()]+)?)(\\([^)]*\\)|{[^}]*})*(\\.)/$2/;\n\t\ts/^h1//;\t\t\t\t# indent headers\n\t\ts/^h2/  /;\n\t\ts/^h3/   /;\n\t\ts/^h4/    /;\n\t\ts/^h5/     /;\n\t\ts/^h6/      /;\n\t"},
  uuid: "1D499ACC-5612-4D30-A405-2B0488AC6F74"}]
