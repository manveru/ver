# Encoding: UTF-8

{"hist" => 
  {scope: "source.js.yui",
   name: "History.getBookmarkedState",
   content: 
    "${YUI_HISTORY:YAHOO.util.History}.getBookmarkedState(${1:'moduleName'});"},
 "sel" => 
  {scope: "source.js.yui",
   name: "Selector.filter",
   content: 
    "${YUI_SELECTOR:YAHOO.util.Selector}.filter(${1:nodes}, '${2:selector}');$0"},
 "dom" => 
  {scope: "source.js.yui",
   name: "Dom.getElementsBy",
   content: 
    "${YUI_DOM:YAHOO.util.Dom}.getElementsBy(${1:method}, '${2:tag}', ${3:rootElement})\n"},
 "lang" => 
  {scope: "source.js.yui",
   name: "YAHOO.lang.isFunction",
   content: "${YUI_LANG:YAHOO.lang}.isFunction(${1:variable})"},
 "cal" => 
  {scope: "source.js.yui",
   name: "CalendarGroup",
   content: 
    "new ${YUI_CALGROUP:YAHOO.widget.CalendarGroup}(\"${1:calId}\", \"${2:calContainerId}\"${3:, ${4:configs}});$0"},
 "but" => 
  {scope: "source.js.yui",
   name: "Button.on",
   content: 
    "on('${1:event}', ${2:function}${3:, ${4:scopeObject}, ${5:true}});"},
 "auto" => 
  {scope: "source.js.yui",
   name: "DS_XHR",
   content: "new YAHOO.widget.DS_XHR(${1:server}, ${2:schema});$0"},
 "tree" => 
  {scope: "source.js.yui",
   name: "TreeView.removeNode",
   content: "removeNode(${1:node});$0"},
 "tab" => 
  {scope: "source.js.yui",
   name: "TabView.addTab",
   content: 
    "addTab(new YAHOO.widget.Tab({ label: \"${1:tagLabel}\",  content: \"${2:contentText}\"${3:, active: true} }));$0"},
 "el" => 
  {scope: "source.js.yui",
   name: "Element.getStyle",
   content: "getStyle(${1:element}, '${2:property}');$0"},
 "event" => 
  {scope: "source.js.yui",
   name: "Event.stopPropagation",
   content: "${YUI_EVENT:YAHOO.util.Event}.stopPropagation(${1:e});"},
 "context" => 
  {scope: "source.js.yui",
   name: "ContextMenu",
   content: 
    "new ${YUI_CONTEXTMENU:YAHOO.widget.ContextMenu}(${1:element}${2:, ${3:configs}});$0"},
 "get" => 
  {scope: "source.js.yui",
   name: "Dom.get",
   content: "${YUI_DOM:YAHOO.util.Dom}.get(${1:'elementId'})$0"},
 "newcon" => 
  {scope: "source.js.yui",
   name: "Tooltip",
   content: 
    "new ${YUI_TOOLTIP:YAHOO.widget.Tooltip}(${1:element}${2:, ${3:{ ${4:context: \"${5:myContextEl}\", }${6:text: \"${7:Tooltip text}\", }${8:showDelay: ${9:500} }\\}}});$0"},
 "newlog" => 
  {scope: "source.js.yui",
   name: "LogReader",
   content: "new ${YUI_LOGREADER:YAHOO.widget.LogReader}(${1:element});$0"},
 "con" => 
  {scope: "source.js.yui", name: "Dialog.submit", content: "submit();"},
 "hasown" => 
  {scope: "source.js.yui",
   name: "YAHOO.lang.hasOwnProperty",
   content: 
    "${YUI_LANG:YAHOO.lang}.hasOwnProperty(${1:object}, ${2:property})"},
 "cookie" => 
  {scope: "source.js.yui",
   name: "Cookie.get",
   content: "${YUI_COOKIE:YAHOO.util.Cookie}.get('${1:name}');$0"},
 "ds" => 
  {scope: "source.js.yui",
   name: "DataSource",
   content: "new ${YUI_DATASOURCE:YAHOO.util.DataSource}(${1:source});$0"},
 "anim" => 
  {scope: "source.js.yui",
   name: "Anim",
   content: 
    "new ${YUI_ANIM:YAHOO.util.Anim}(${1:element}${2:, ${3:attributes}, ${4:duration}, ${5:YAHOO.util.Easing.easeOut}}$0);"},
 "json" => 
  {scope: "source.js.yui",
   name: "JSON.isSafe",
   content: "${YUI_JSON:YAHOO.lang.JSON}.isSafe(${1:jsonString});$0"},
 "logr" => 
  {scope: "source.js.yui", name: "LogReader.show", content: "show();"},
 "menu" => {scope: "source.js.yui", name: "Menu.render", content: "render();"},
 "ease" => 
  {scope: "source.js.yui",
   name: "Ease.easeBothStrong",
   content: "${YUI_EASING:YAHOO.util.Easing}.easeBothStrong"},
 "logger" => 
  {scope: "source.js.yui",
   name: "Logger.disableBrowserConsole",
   content: "${YUI_LOGGER:YAHOO.widget.Logger}.disableBrowserConsole():"},
 "on" => 
  {scope: "source.js.yui",
   name: "Event.on",
   content: 
    "${YUI_EVENT:YAHOO.util.Event}.on(${1:element}, '${2:event}', ${3:function}${4:, ${5:scopeObject}, ${6:true}});"},
 "style" => 
  {scope: "source.js.yui",
   name: "StyleSheet",
   content: "var ${1:sheet} = ${YUI_STYLESHEET:YAHOO.util.StyleSheet}($0);"},
 "conn" => 
  {scope: "source.js.yui",
   name: "Connect.abort",
   content: "${YUI_CONNECT:YAHOO.util.Connect}.abort(${1:connectionObject});"},
 "dt" => 
  {scope: "source.js.yui",
   name: "DataTable.getSelectedRows",
   content: "getSelectedRows();$0"},
 "stor" => 
  {scope: "source.js.yui",
   name: "Storage.getItem",
   content: "${1:storageEngine}.getItem(${2:'key'});$0"},
 "dd" => 
  {scope: "source.js.yui",
   name: "DDProxy",
   content: "new ${YUI_DDPROXY:YAHOO.util.DDProxy}(${1:element});"},
 "config" => 
  {scope: "source.js.yui",
   name: "YAHOO_config",
   content: "${YUI_CONFIG:YAHOO_config} = { listener: ${1:callbackFunc} };"},
 "slider" => 
  {scope: "source.js.yui",
   name: "Slider.getSliderRegion",
   content: 
    "${YUI_SLIDER:YAHOO.widget.Slider}.getSliderRegion(\"${1:backgroundId}\", \"${2:thumbId}\", ${3:left}, ${4:right}, ${5:up}, ${6:down}${7:, ${8:tickSize}});$0"},
 "col" => 
  {scope: "source.js.yui",
   name: "ColumnSet",
   content: 
    "new ${YUI_COLUMNSET:YAHOO.widget.ColumnSet}(${1:columnHeaders});$0"},
 "add" => 
  {scope: "source.js.yui",
   name: "Event.addListener",
   content: 
    "${YUI_EVENT:YAHOO.util.Event}.addListener(${1:element}, '${2:event}', ${3:function}${4:, ${5:scopeObject}, ${6:true}});"},
 "log" => 
  {scope: "source.js.yui",
   name: "YAHOO.log",
   content: "${YUI_YAHOO:YAHOO}.log(${1:message});"},
 "stop" => 
  {scope: "source.js.yui",
   name: "Event.stopEvent",
   content: "${YUI_EVENT:YAHOO.util.Event}.stopEvent(${1:e});"},
 "async" => 
  {scope: "source.js.yui",
   name: "Connect.asyncRequest",
   content: 
    "${YUI_CONNECT:YAHOO.util.Connect}.asyncRequest('${1:POST}', '${2:URI}', ${3:{ success: ${4:successFunc}, failure: ${5:failureFunc} \\}}${6:, ${7:postData}});"},
 "env" => 
  {scope: "source.js.yui",
   name: "YAHOO.env.getVersion",
   content: "${YUI_ENV:YAHOO.env}.getVersion(${1:componentName})"},
 "menubar" => 
  {scope: "source.js.yui",
   name: "MenuBarItem",
   content: 
    "new ${YUI_MENUBARITEM:YAHOO.widget.MenuBarItem}(${1:element}${2:, ${3:configs}});$0"},
 "Y" => 
  {scope: "source.js.yui",
   name: "YAHOO.namespace",
   content: "${YUI_YAHOO:YAHOO}.namespace('${1:namespace}');"},
 "name" => 
  {scope: "source.js.yui",
   name: "Namespace Variables",
   content: 
    "// Add any variable that you changed in Namespace Preferences here:\n\nvar ${YUI_LANG} = YAHOO.lang;\nvar ${YUI_DOM} = YAHOO.util.Dom;\nvar ${YUI_EVENT} = YAHOO.util.Event;\nvar ${YUI_CONNECT} = YAHOO.util.Connect;\nvar ${YUI_ANIM} = YAHOO.util.Anim;"},
 "swf" => 
  {scope: "source.js.yui",
   name: "SWF",
   content: 
    "var ${1:swf} = new ${YUI_SWF:YAHOO.widget.SWF}('${2:containerId}', '${3:file.swf}', ${4:params});$0"},
 "loader" => 
  {scope: "source.js.yui",
   name: "YUILoader",
   content: 
    "var ${1:sheet} = ${YUI_STYLESHEET:YAHOO.util.StyleSheet}($0);\n\nvar ${1:loader} = new ${YUI_LOADER:YAHOO.util.YUILoader}({\n\trequire: [\"colorpicker\", \"treeview\"],\n\tloadOptional: true,\n\ttimeout: 10000,\n\tcombine: true,\n\n\tonSuccess: function() {\n\n\t}\n});\n\n"}}
