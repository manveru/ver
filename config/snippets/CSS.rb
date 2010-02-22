# Encoding: UTF-8

{"text" => 
  {scope: "source.css",
   name: "text-indent: length",
   content: "text-indent: ${1:10}px;$0"},
 "background" => 
  {scope: "source.css",
   name: "filter: AlphaImageLoader [for IE PNGs]",
   content: 
    "${3:background-image: none;\n}filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${1:${TM_SELECTED_TEXT:/images/transparent.png}}', sizingMethod='${2:image/scale/crop}');"},
 "letter" => 
  {scope: "source.css",
   name: "letter-spacing: em",
   content: "letter-spacing: $1em;$0"},
 "color" => 
  {scope: "source.css", name: "color: hex", content: "color: \#${1:DDD};$0"},
 "border" => 
  {scope: "source.css",
   name: "border-top-width: size",
   content: "border-top-width: ${1:1}px"},
 "padding" => 
  {scope: "source.css",
   name: "padding-left: length",
   content: "padding-left: ${1:20px};$0"},
 "overflow" => 
  {scope: "source.css",
   name: "overflow: type",
   content: "overflow: ${1:visible/hidden/scroll/auto};$0"},
 "font" => 
  {scope: "source.css",
   name: "font-variant: normal/small-caps",
   content: "font-variant: ${1:normal/small-caps};$0"},
 "list" => 
  {scope: "source.css",
   name: "list-style: type position image",
   content: 
    "list-style: ${1:none/disc/circle/square/decimal/zero} ${2:inside/outside} url($3);$0"},
 "clear" => 
  {scope: "source.css",
   name: "clear: value",
   content: "clear: ${1:left/right/both/none};$0"},
 "marker" => 
  {scope: "source.css",
   name: "marker-offset: length",
   content: "marker-offset: ${1:10px};$0"},
 "cursor" => 
  {scope: "source.css",
   name: "cursor: type",
   content: 
    "cursor: ${1:default/auto/crosshair/pointer/move/*-resize/text/wait/help};$0"},
 "direction" => 
  {scope: "source.css",
   name: "direction: ltr/rtl",
   content: "direction: ${1:ltr|rtl};$0"},
 "z" => 
  {scope: "source.css", name: "z-index: index", content: "z-index: $1;$0"},
 "word" => 
  {scope: "source.css",
   name: "word-spacing: length",
   content: "word-spacing: ${1:10px};$0"},
 "!" => 
  {scope: "source.css", name: "!important CSS", content: "${1:!important}"},
 "display" => 
  {scope: "source.css", name: "display: block", content: "display: block;$0"},
 "position" => 
  {scope: "source.css",
   name: "position: type",
   content: "position: ${1:static/relative/absolute/fixed};$0"},
 "margin" => 
  {scope: "source.css",
   name: "margin-right: length",
   content: "margin-right: ${1:20px};$0"},
 "float" => 
  {scope: "source.css",
   name: "float: left/right/none",
   content: "float: ${1:left/right/none};$0"},
 "white" => 
  {scope: "source.css",
   name: "white-space: normal/pre/nowrap",
   content: "white-space: ${1:normal/pre/nowrap};$0"},
 "{" => 
  {scope: "source.css",
   name: "properties { } ( } )",
   content: "{\n\t/* $1 */\n\t$0\n"},
 "vertical" => 
  {scope: "source.css",
   name: "vertical-align: type",
   content: 
    "vertical-align: ${1:baseline/sub/super/top/text-top/middle/bottom/text-bottom/length/%};$0"},
 "opacity" => 
  {scope: "source.css",
   name: "opacity: [for Safari, FF & IE]",
   content: 
    "opacity: ${1:0.5};${100:\n}-moz-opacity: ${1:0.5};${100:\n}filter:alpha(opacity=${2:${1/(1?)0?\\.(.*)/$1$2/}${1/^\\d*\\.\\d\\d+$|^\\d*$|(^\\d\\.\\d$)/(?1:0)/}});$0"},
 "visibility" => 
  {scope: "source.css",
   name: "visibility: type",
   content: "visibility: ${1:visible/hidden/collapse};$0"},
 "scrollbar" => 
  {scope: "source.css meta.property-list",
   name: "scrollbar",
   content: 
    "scrollbar-base-color:       ${1:#CCCCCC};${2:\nscrollbar-arrow-color:      ${3:#000000};\nscrollbar-track-color:      ${4:#999999};\nscrollbar-3dlight-color:    ${5:#EEEEEE};\nscrollbar-highlight-color:  ${6:#FFFFFF};\nscrollbar-face-color:       ${7:#CCCCCC};\nscrollbar-shadow-color:     ${9:#999999};\nscrollbar-darkshadow-color: ${8:#666666};}"},
 "fixed" => 
  {scope: "source.css meta.property-list",
   name: "Fixed Position Bottom 100% wide IE6",
   content: 
    "${2:bottom: auto;}top: expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-${1:THE HEIGHT OF THIS THING IN PIXELS}));\n${3:left: expression(eval(document.documentElement.scrollLeft));\n}${4:width: expression(eval(document.documentElement.clientWidth));}$0"},
 "selection" => 
  {scope: "source.css -meta.property-list",
   name: "selection",
   content: 
    "$1::-moz-selection,\n$1::selection {\n\tcolor: ${2:inherit};\n\tbackground: ${3:inherit};\n}"}}
