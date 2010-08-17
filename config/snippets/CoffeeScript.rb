# Encoding: UTF-8

[{content: "for ${1:name} in ${2:array}\n  ${0:# body...}",
  name: "Array Comprehension",
  scope: "source.coffee",
  tabTrigger: "fora",
  uuid: "2D4AC0B4-47AA-4E38-9A11-09A48C2A9439"},
 {content: 
   "class ${1:ClassName}${2: extends ${3:Ancestor}}\n\n  ${4:constructor: (${5:args}) ->\n    ${6:# body...}}\n  $7",
  name: "Class",
  scope: "source.coffee",
  tabTrigger: "cla",
  uuid: "765ACBD3-380A-4CF8-9111-345A36A0DAE7"},
 {content: "else if ${1:condition}\n  ${0:# body...}",
  name: "Else if",
  scope: "source.coffee",
  tabTrigger: "elif",
  uuid: "EA8F5EDB-6E1E-4C36-9CA5-12B108F1A7C9"},
 {content: "${1:name}: (${2:args}) ->\n  ${0:# body...}\n\n",
  name: "Function",
  scope: "source.coffee",
  tabTrigger: "fun",
  uuid: "F2E2E79A-A85D-471D-9847-72AE40205942"},
 {content: "${1:(${2:args}) }=>\n  ${0:# body...}",
  name: "Function (bound)",
  scope: "source.coffee",
  tabTrigger: "bfun",
  uuid: "20BDC055-ED67-4D0E-A47F-ADAA828EFF2B"},
 {content: "if ${1:condition}\n  ${0:# body...}",
  name: "If",
  scope: "source.coffee",
  tabTrigger: "if",
  uuid: "F4FDFB3A-71EF-48A4-93F4-178B949546B1"},
 {content: "if ${1:condition}\n  ${2:# body...}\nelse\n  ${3:# body...}",
  name: "If .. Else",
  scope: "source.coffee",
  tabTrigger: "ife",
  uuid: "2AD19F12-E499-4715-9A47-FC8D594BC550"},
 {content: "for ${1:key}, ${2:value} of ${3:Object}\n  ${0:# body...}",
  name: "Object comprehension",
  scope: "source.coffee",
  tabTrigger: "foro",
  uuid: "9D126CC5-EA14-4A40-B6D3-6A5FC1AC1420"},
 {content: 
   "for ${1:name} in [${2:start}...${3:finish}]${4: by ${5:step}}\n  ${0:# body...}",
  name: "Range comprehension (exclusive)",
  scope: "source.coffee",
  tabTrigger: "forrex",
  uuid: "FA6AB9BF-3444-4A8C-B010-C95C2CF5BAB3"},
 {content: 
   "for ${1:name} in [${2:start}..${3:finish}]${4: by ${5:step}}\n  ${0:# body...}",
  name: "Range comprehension (inclusive)",
  scope: "source.coffee",
  tabTrigger: "forr",
  uuid: "E0F8E45A-9262-4DD6-ADFF-B5B9D6CE99C2"},
 {content: "\\`${1:`pbpaste`}\\`",
  keyEquivalent: "^j",
  name: "Raw javascript",
  scope: "source.coffee",
  uuid: "422A59E7-FC36-4E99-B01C-6353515BB544"},
 {content: "switch ${1:object}\n  when ${2:value}\n    ${0:# body...}",
  name: "Switch",
  scope: "source.coffee",
  tabTrigger: "swi",
  uuid: "3931A7C6-F1FB-484F-82D1-26F5A8F779D0"},
 {content: "if ${1:condition} then ${2:value} else ${3:other}",
  name: "Ternary If",
  scope: "source.coffee",
  tabTrigger: "ifte",
  uuid: "CF0B4684-E4CB-4E10-8C25-4D15400C3385"},
 {content: "try\n  $1\ncatch ${2:error}\n  $3",
  name: "Try .. Catch",
  scope: "source.coffee",
  tabTrigger: "try",
  uuid: "CAFB0DED-5E23-4A84-AC20-87FBAF22DBAC"},
 {content: "${1:action} unless ${2:condition}",
  name: "Unless",
  scope: "source.coffee",
  tabTrigger: "unl",
  uuid: "E561AECD-5933-4F59-A6F7-FA96E1203606"},
 {content: "${2/^.*?([\\w_]+).*$/\\L$1/}: require(${2:'${1:sys}'})",
  name: "require",
  scope: "source.coffee",
  tabTrigger: "req",
  uuid: "8A65E175-18F2-428F-A695-73E01139E41A"}]