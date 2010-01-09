# Encoding: UTF-8

{"!" => 
  {scope: "source.css", name: "!important CSS", content: "${1:!important}"},
 "background" => 
  {scope: "source.css",
   name: "filter: AlphaImageLoader [for IE PNGs]",
   content: 
    "${3:background-image: none;\n}filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${1:${TM_SELECTED_TEXT:/images/transparent.png}}', sizingMethod='${2:image/scale/crop}');"},
 "border" => 
  {scope: "source.css",
   name: "border: size style color",
   content: "border: ${1:1px} ${2:solid} \#${3:999};$0"},
 "clear" => 
  {scope: "source.css",
   name: "clear: value",
   content: "clear: ${1:left/right/both/none};$0"},
 "color" => 
  {scope: "source.css",
   name: "color: rgb",
   content: "color: rgb(${1:255},${2:255},${3:255});$0"},
 "cursor" => 
  {scope: "source.css", name: "cursor: url", content: "cursor: url($1);$0"},
 "direction" => 
  {scope: "source.css",
   name: "direction: ltr/rtl",
   content: "direction: ${1:ltr|rtl};$0"},
 "display" => 
  {scope: "source.css",
   name: "display: table-types",
   content: 
    "display: ${1:table/inline-table/table-row-group/table-header-group/table-footer-group/table-row/table-column-group/table-column/table-cell/table-caption};$0"},
 "float" => 
  {scope: "source.css",
   name: "float: left/right/none",
   content: "float: ${1:left/right/none};$0"},
 "font" => 
  {scope: "source.css",
   name: "font: size font",
   content: 
    "font: ${1:75%} ${2:\"Lucida Grande\", \"Trebuchet MS\", Verdana,} ${3:sans-}serif;$0"},
 "letter" => 
  {scope: "source.css",
   name: "letter-spacing: px",
   content: "letter-spacing: $1px;$0"},
 "list" => 
  {scope: "source.css",
   name: "list-style: type position image",
   content: 
    "list-style: ${1:none/disc/circle/square/decimal/zero} ${2:inside/outside} url($3);$0"},
 "margin" => 
  {scope: "source.css",
   name: "margin: V H",
   content: "margin: ${1:20px} ${2:0px};$0"},
 "marker" => 
  {scope: "source.css",
   name: "marker-offset: length",
   content: "marker-offset: ${1:10px};$0"},
 "opacity" => 
  {scope: "source.css",
   name: "opacity: [for Safari, FF & IE]",
   content: 
    "opacity: ${1:0.5};${100:\n}-moz-opacity: ${1:0.5};${100:\n}filter:alpha(opacity=${2:${1/(1?)0?\\.(.*)/$1$2/}${1/^\\d*\\.\\d\\d+$|^\\d*$|(^\\d\\.\\d$)/(?1:0)/}});$0"},
 "overflow" => 
  {scope: "source.css",
   name: "overflow: type",
   content: "overflow: ${1:visible/hidden/scroll/auto};$0"},
 "padding" => 
  {scope: "source.css",
   name: "padding: all",
   content: "padding: ${1:20px};$0"},
 "position" => 
  {scope: "source.css",
   name: "position: type",
   content: "position: ${1:static/relative/absolute/fixed};$0"},
 "{" => 
  {scope: "source.css",
   name: "properties { } ( } )",
   content: "{\n\t/* $1 */\n\t$0\n"},
 "text" => 
  {scope: "source.css",
   name: "text-transform: none",
   content: "text-transform: none;$0"},
 "vertical" => 
  {scope: "source.css",
   name: "vertical-align: type",
   content: 
    "vertical-align: ${1:baseline/sub/super/top/text-top/middle/bottom/text-bottom/length/%};$0"},
 "visibility" => 
  {scope: "source.css",
   name: "visibility: type",
   content: "visibility: ${1:visible/hidden/collapse};$0"},
 "white" => 
  {scope: "source.css",
   name: "white-space: normal/pre/nowrap",
   content: "white-space: ${1:normal/pre/nowrap};$0"},
 "word" => 
  {scope: "source.css",
   name: "word-spacing: normal",
   content: "word-spacing: normal;$0"},
 "z" => 
  {scope: "source.css", name: "z-index: index", content: "z-index: $1;$0"},
 "fixed" => 
  {scope: "source.css meta.property-list",
   name: "Fixed Position Bottom 100% wide IE6",
   content: 
    "${2:bottom: auto;}top: expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-${1:THE HEIGHT OF THIS THING IN PIXELS}));\n${3:left: expression(eval(document.documentElement.scrollLeft));\n}${4:width: expression(eval(document.documentElement.clientWidth));}$0"},
 "scrollbar" => 
  {scope: "source.css meta.property-list",
   name: "scrollbar",
   content: 
    "scrollbar-base-color:       ${1:#CCCCCC};${2:\nscrollbar-arrow-color:      ${3:#000000};\nscrollbar-track-color:      ${4:#999999};\nscrollbar-3dlight-color:    ${5:#EEEEEE};\nscrollbar-highlight-color:  ${6:#FFFFFF};\nscrollbar-face-color:       ${7:#CCCCCC};\nscrollbar-shadow-color:     ${9:#999999};\nscrollbar-darkshadow-color: ${8:#666666};}"},
 "selection" => 
  {scope: "source.css -meta.property-list",
   name: "selection",
   content: 
    "$1::-moz-selection,\n$1::selection {\n\tcolor: ${2:inherit};\n\tbackground: ${3:inherit};\n}"}}
