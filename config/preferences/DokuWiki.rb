# Encoding: UTF-8

[{name: "Disable spell checking in raw",
  scope: "markup.raw.dokuwiki",
  settings: {spellChecking: 0},
  uuid: "B5C7FF05-8484-44B6-8343-BE44A9027261"},
 {name: "Show Heading in list",
  scope: "markup.heading.dokuwiki",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: 
     "\n\t\ts/^\\s*==\\s*([^=].*)(?<!=)={2,}\\s*$/    $1/;\n\t\ts/^\\s*===\\s*([^=].*)(?<!=)={2,}\\s*$/   $1/;\n\t\ts/^\\s*====\\s*([^=].*)(?<!=)={2,}\\s*$/  $1/;\n\t\ts/^\\s*=====\\s*([^=].*)(?<!=)={2,}\\s*$/ $1/;\n\t\ts/^\\s*======+\\s*([^=].*)(?<!=)={2,}\\s*$/$1/;\n\t"},
  uuid: "65F97C49-BBE9-447F-83EC-0A4598EF5558"}]
