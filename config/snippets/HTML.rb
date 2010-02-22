# Encoding: UTF-8

{"command" => {scope: "text.html", name: "⌘", content: "&#x2318;"},
 "down" => {scope: "text.html", name: "↓", content: "&#x2193;"},
 "doctype" => 
  {scope: "text.html",
   name: "XHTML — 1.0 Strict",
   content: 
    "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n\t\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n"},
 "left" => {scope: "text.html", name: "←", content: "&#x2190;"},
 nil => 
  {scope: "text.html",
   name: "Emphasize",
   content: 
    "${0:${TM_SELECTED_TEXT/\\A<em>(.*)<\\/em>\\z|.*/(?1:$1:<em>$0<\\/em>)/m}}"},
 "enter" => {scope: "text.html", name: "⌅", content: "&#x2305;"},
 "movie" => 
  {scope: "text.html",
   name: "Embed QT Movie",
   content: 
    "<object width=\"$2\" height=\"$3\" classid=\"clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B\" codebase=\"http://www.apple.com/qtactivex/qtplugin.cab\">\n\t<param name=\"src\" value=\"$1\"${TM_XHTML}>\n\t<param name=\"controller\" value=\"$4\"${TM_XHTML}>\n\t<param name=\"autoplay\" value=\"$5\"${TM_XHTML}>\n\t<embed src=\"${1:movie.mov}\"\n\t\twidth=\"${2:320}\" height=\"${3:240}\"\n\t\tcontroller=\"${4:true}\" autoplay=\"${5:true}\"\n\t\tscale=\"tofit\" cache=\"true\"\n\t\tpluginspage=\"http://www.apple.com/quicktime/download/\"\n\t${TM_XHTML}>\n</object>"},
 "option" => {scope: "text.html", name: "⌥", content: "&#x2325;"},
 "body" => 
  {scope: "text.html",
   name: "Body",
   content: 
    "<body id=\"${1:${TM_FILENAME/(.*)\\..*/\\L$1/}}\"${2: onload=\"$3\"}>\n\t$0\n</body>"},
 "textarea" => 
  {scope: "text.html",
   name: "Text Area",
   content: 
    "<textarea name=\"${1:Name}\" rows=\"${2:8}\" cols=\"${3:40}\">$0</textarea>"},
 "scriptsrc" => 
  {scope: "text.html",
   name: "Script With External Source",
   content: 
    "<script src=\"$1\" type=\"text/javascript\" charset=\"${3:utf-8}\"></script>"},
 "shift" => {scope: "text.html", name: "⇧", content: "&#x21E7;"},
 "base" => 
  {scope: "text.html",
   name: "Base",
   content: "<base href=\"$1\"${2: target=\"$3\"}${TM_XHTML}>"},
 "link" => 
  {scope: "text.html",
   name: "Link",
   content: 
    "<link rel=\"${1:stylesheet}\" href=\"${2:/css/master.css}\" type=\"text/css\" media=\"${3:screen}\" title=\"${4:no title}\" charset=\"${5:utf-8}\"${TM_XHTML}>"},
 "table" => 
  {scope: "text.html",
   name: "Table",
   content: 
    "<table border=\"${1:0}\"${2: cellspacing=\"${3:5}\" cellpadding=\"${4:5}\"}>\n\t<tr><th>${5:Header}</th></tr>\n\t<tr><td>${0:Data}</td></tr>\n</table>"},
 "right" => {scope: "text.html", name: "→", content: "&#x2192;"},
 "up" => {scope: "text.html", name: "↑", content: "&#x2191;"},
 "tab" => {scope: "text.html", name: "⇥", content: "&#x21E5;"},
 "control" => {scope: "text.html", name: "⌃", content: "&#x2303;"},
 "backspace" => {scope: "text.html", name: "⌫", content: "&#x232B;"},
 "meta" => 
  {scope: "text.html",
   name: "Meta",
   content: "<meta name=\"${1:name}\" content=\"${2:content}\"${TM_XHTML}>"},
 "arrow" => {scope: "text.html", name: "→", content: "&#x2192;"},
 "delete" => {scope: "text.html", name: "⌦", content: "&#x2326;"},
 "backtab" => {scope: "text.html", name: "⇤", content: "&#x21E4;"},
 "h1" => 
  {scope: "text.html",
   name: "Heading",
   content: 
    "<h1 id=\"${1/[[:alpha:]]+|( )/(?1:_:\\L$0)/g}\">${1:$TM_SELECTED_TEXT}</h1>"},
 "div" => 
  {scope: "text.html",
   name: "Div",
   content: "<div${1: id=\"${2:name}\"}>\n\t${0:$TM_SELECTED_TEXT}\n</div>"},
 "title" => 
  {scope: "text.html - text.blog",
   name: "Title",
   content: 
    "<title>${1:${TM_FILENAME/((.+)\\..*)?/(?2:$2:Page Title)/}}</title>"},
 "head" => 
  {scope: "text.html - text.html source",
   name: "Head",
   content: 
    "<head>\n\t<meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\"${TM_XHTML}>\n\t<title>${1:${TM_FILENAME/((.+)\\..*)?/(?2:$2:Page Title)/}}</title>\n\t$0\n</head>"},
 "script" => 
  {scope: "text.html",
   name: "Script",
   content: 
    "<script type=\"text/javascript\" charset=\"utf-8\">\n\t$0\n</script>"},
 "mailto" => 
  {scope: "text.html",
   name: "Mail Anchor",
   content: 
    "<a href=\"mailto:${1:joe@example.com}?subject=${2:feedback}\">${3:email me}</a>"},
 "style" => 
  {scope: "text.html",
   name: "Style",
   content: "<style type=\"text/css\" media=\"screen\">\n\t$0\n</style>"},
 "input" => 
  {scope: "text.html",
   name: "Input with Label",
   content: 
    "<label for=\"${2:${1/[[:alpha:]]+|( )/(?1:_:\\L$0)/g}}\">$1</label><input type=\"${3:text/submit/hidden/button}\" name=\"${4:$2}\" value=\"$5\"${6: id=\"${7:$2}\"}${TM_XHTML}>\n"},
 "form" => 
  {scope: "text.html",
   name: "Form",
   content: 
    "<form action=\"${1:${TM_FILENAME/(.*?)\\..*/$1_submit/}}\" method=\"${2:get}\" accept-charset=\"utf-8\">\n\t$0\n\n\t<p><input type=\"submit\" value=\"Continue &rarr;\"${TM_XHTML}></p>\n</form>"},
 "escape" => {scope: "text.html", name: "⎋", content: "&#x238B;"},
 "return" => {scope: "text.html", name: "↩", content: "&#x21A9;"},
 "fieldset" => 
  {scope: "text.html",
   name: "Fieldset",
   content: 
    "<fieldset id=\"${1/[[:alpha:]]+|( )/(?1:_:\\L$0)/g}\" ${2:class=\"${3:}\"}>\n\t<legend>${1:$TM_SELECTED_TEXT}</legend>\n\t\n\t$0\n</fieldset>"},
 "!" => 
  {scope: "text.html",
   name: "IE Conditional Comment: Internet Explorer 5.x",
   content: 
    "<!--[if lt IE 6]>${1:${TM_SELECTED_TEXT:  IE Conditional Comment: Internet Explorer 5.x      }}<![endif]-->$0"},
 "select" => 
  {scope: "text.html",
   name: "Select Box",
   content: 
    "<select name=\"${1:some_name}\" id=\"${2:$1}\"${3:${4: multiple}${5: onchange=\"${6:}\"}${7: size=\"${8:1}\"}}>\n\t<option${9: value=\"${10:option1}\"}>${11:$10}</option>\n\t<option${12: value=\"${13:option2}\"}>${14:$13}</option>${15:}\n\t$0\n</select>"},
 "opt" => 
  {scope: "text.html",
   name: "Option",
   content: "<option${1: value=\"${2:option}\"}>${3:$2}</option>"}}
