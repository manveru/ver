# Encoding: UTF-8

{comment: 
  "\nMooTools Framework by Valerio Proietti. \nhttp://mootools.net\nThis syntax document is largely based on the documentation at http://docs.mootools.net\nInitial bundle by Joe Maller. \n",
 foldingStartMarker: /(?<_1>^.*{[^}]*$|^.*\([^\)]*$|^.*\/\*(?!.*\*\/).*$)/,
 foldingStopMarker: /(?<_1>^\s*\}|^\s*\)|^(?!.*\/\*).*\*\/)/,
 keyEquivalent: "^~J",
 name: "MooTools",
 patterns: 
  [{comment: 
     "\nClass\nThe base class object of the http://mootools.net framework. \nhttp://docs.mootools.net/files/Core/Moo-js.html",
    match: /\b(?<_1>Class|Array|Element|Event|Function|String)\b/,
    name: "support.class.js.mootools"},
   {match: /\b(?<_1>empty|extend|implement)\b/,
    name: "support.class.class.js.mootools"},
   {match: /\b(?<_1>extend|Native)\b/,
    name: "support.function.class.js.mootools"},
   {comment: 
     "\nUtility\nContains Utility functions\nhttp://docs.mootools.net/files/Core/Utility-js.html\n",
    match: /\$(?<_1>type|chk|pick|random|clear)\b/,
    name: "support.function.utility.js.mootools"},
   {captures: {1 => {name: "support.class.window.browser.js.mootools"}},
    match: /window\.(?<_1>ie|ie6|ie7|khtml|gecko)\b/},
   {comment: 
     "\nArray\nA collection of The Array Object prototype methods.\nhttp://docs.mootools.net/files/Native/Array-js.html",
    include: "#array-functions"},
   {match: 
     /\b(?<_1>forEach|filter|map|every|some|indexOf|each|copy|remove|test|extend|associate)\b/,
    name: "support.class.array.js.mootools"},
   {comment: 
     "\nElement\nCustom class to allow all of its methods to be used with any DOM element via the dollar function $.\nhttp://docs.mootools.net/files/Native/Element-js.html",
    include: "#element-functions"},
   {match: 
     /\b(?<_1>injectBefore|injectAfter|injectInside|adopt|remove|clone|replaceWith|appendText|hasClass|addClass|removeClass|toggleClass|setStyle|setStyles|setOpacity|getStyle|addEvent|removeEvent|removeEvents|fireEvent|getPrevious|getNext|getFirst|getLast|getParent|getChildren|setProperty|setProperties|setHTML|getProperty|getTag|scrollTo|getValue|getSize|getPosition|getTop|getLeft|getCoordinates)\b/,
    name: "support.class.element.js.mootools"},
   {comment: 
     "\nEvent\nCross browser methods to manage events.\nhttp://docs.mootools.net/files/Native/Event-js.html",
    match: /\b(?<_1>stop|stopPropagation|preventDefault|bindWithEvent)\b/,
    name: "support.class.event.js.mootools"},
   {comment: 
     "\nFunction\nA collection of The Function Object prototype methods.\nhttp://docs.mootools.net/files/Native/Function-js.html",
    match: 
     /\b(?<_1>create|pass|attempt|bind|bindAsEventListener|delay|periodical)\b/,
    name: "support.class.function.js.mootools"},
   {comment: 
     "\nString\nA collection of The String Object prototype methods.\nhttp://docs.mootools.net/files/Native/String-js.html",
    match: 
     /\b(?<_1>test|toInt|camelCase|hyphenate|capitalize|trim|clean|rgbToHex|hexToRgb)\b/,
    name: "support.class.string.js.mootools"},
   {match: /\btoInt\b/, name: "support.class.number.js.mootools"},
   {comment: 
     "\nDOM\nCss Query related function and Element extensions.\nhttp://docs.mootools.net/files/Addons/Dom-js.html",
    include: "#dom-functions"},
   {comment: "document. getElementsByClassName\tmight belong somewhere else",
    match: 
     /\b(?<_1>getElements|getElementById|getElement|getElementsBySelector|getElementsByClassName)\b/,
    name: "support.class.dom.js.mootools"},
   {comment: 
     "\nHash\nIt wraps an object that it uses internally as a map.\nhttp://docs.mootools.net/files/Addons/Hash-js.html\n -- note: several overlaps in here with named properties from array.js.mootools",
    include: "#hash-functions"},
   {match: /\b(?<_1>get|hasKey|set|remove|each|extend|empty|keys|values)\b/,
    name: "support.class.hash.js.mootools"},
   {comment: 
     "\nColor\nCreates a new Color Object, which is an array with some color specific methods.\nhttp://docs.mootools.net/files/Addons/Color-js.html",
    match: /\b(?<_1>mix|invert|setHue|setSaturation|setBrightness)\b/,
    name: "support.class.color.js.mootools"},
   {captures: {1 => {name: "variable.parameter.function.js"}},
    match: /\$(?:RGB|HSB)\((?<_1>[^)]*)\)\b/,
    name: "support.function.color.js.mootools"},
   {comment: 
     "\nCommon\nContains common implementations for custom classes.\nhttp://docs.mootools.net/files/Addons/Common-js.html",
    match: /\b(?<_1>chain|(?<_2>call|clear)Chain)\b/,
    name: "support.function.chain.js.mootools"},
   {match: /\b(?<_1>add|fire|remove)Event\b/,
    name: "support.function.events.js.mootools"},
   {match: /\bsetOptions\b/, name: "support.function.options.js.mootools"},
   {comment: 
     "\nWindow Base\nCross browser methods to get the window size, onDomReady method.\nhttp://docs.mootools.net/files/Window/Window-Base-js.html\n -- note: addEvent is already listed under Element",
    match: /\bonDomReady\b/,
    name: "support.class.base.window.js.mootools"},
   {comment: 
     "\nWindow Size\nCross browser methods to get various window dimensions.\nhttp://docs.mootools.net/files/Window/Window-Size-js.html\n -- note: getSize is already listed under Element",
    match: 
     /\b(?<_1>get(?<_2>Width|Height|Scroll(?<_3>Width|Height|Left|Top)))\b/,
    name: "support.class.size.window.js.mootools"},
   {comment: 
     "\nAjax\nAn Ajax class, For all your asynchronous needs.\nhttp://docs.mootools.net/files/Remote/Ajax-js.html",
    match: /\b(?<_1>request|evalScripts)\b/,
    name: "support.class.ajax.js.mootools"},
   {comment: 
     "note: both Object and Element have a toQueryString function/property",
    match: /\btoQueryString\b/,
    name: "support.function.js.mootools"},
   {match: /\bsend\b/, name: "support.class.element.js"},
   {comment: 
     "\nAssets\nprovides dynamic loading for images, css and javascript files.\nhttp://docs.mootools.net/files/Remote/Assets-js.html",
    match: /\b(?<_1>javascript|css|images?)\b/,
    name: "support.function.asset.js.mootools"},
   {comment: 
     "\nCookie\nClass for creating, getting, and removing cookies.\nhttp://docs.mootools.net/files/Remote/Assets-js.html",
    match: /\b(?<_1>set|get|remove)\b/,
    name: "support.class.cookie.js.mootools"},
   {comment: 
     "\nJson\nSimple Json parser and Stringyfier, See: http://www.json.org/\nhttp://docs.mootools.net/files/Remote/Json-js.html",
    match: /\b(?<_1>toString|evaluate)\b/,
    name: "support.class.json.js.mootools"},
   {comment: 
     "\nJson Remote\nWrapped XHR with automated sending and receiving of Javascript Objects in Json Format.\nhttp://docs.mootools.net/files/Remote/Json-Remote-js.html",
    match: /\bJson\.Remote\b/,
    name: "support.class.json.js.mootools"},
   {comment: 
     "\nXHR\nContains the basic XMLHttpRequest Class Wrapper.\nhttp://docs.mootools.net/files/Remote/XHR-js.html",
    match: /\bXHR\b/,
    name: "support.class.xhr.js.mootools"},
   {comment: 
     "\nFx.Base\t\t\t\nBase class for the Mootools Effects (Moo.Fx) library.\t\t\t\nhttp://docs.mootools.net/files/Effects/Fx-Base-js.html",
    match: /\b(?<_1>set|start|stop)\b/,
    name: "support.class.base.fx.js.mootools"},
   {match: /\b(?<_1>linear|sineInOut)\b/,
    name: "support.class.transitions.fx.js.mootools"},
   {match: /\b(?<_1>onStart|onComplete|transition|duration|unit|wait|fps)\b/,
    name: "support.class.keys.options.transitions.fx"},
   {comment: 
     "\nFx.Elements\nFx.Elements allows you to apply any number of styles transitions to a selection of elements.\nhttp://docs.mootools.net/files/Effects/Fx-Elements-js.html",
    match: /\b(?<_1>start)\b/,
    name: "support.class.elements.fx.js.mootools"},
   {begin: /(?<_1>new)\s+(?<_2>Fx\.Elements)(?<_3>\()/,
    beginCaptures: 
     {1 => {name: "keyword.operator.new.js"},
      2 => {name: "entity.name.type.instance.js.mootools"},
      3 => {name: "punctuation.definition.parameters.begin.js"}},
    contentName: "variable.parameter.fx.elements.js.mootools",
    end: "(\\)(;|$))",
    endCaptures: {1 => {name: "punctuation.definition.parameters.end.js"}},
    patterns: 
     [{include: "#element-functions"},
      {include: "#array-functions"},
      {include: "#dom-functions"},
      {include: "#hash-functions"},
      {begin: /(?<_1>\{)/,
       beginCaptures: 
        {1 => {name: "punctuation.definition.parameters.begin.js"}},
       contentName: "variable.parameter.fx.elements.options.js.mootools",
       end: "(\\})(?=\\))",
       endCaptures: {1 => {name: "punctuation.definition.parameters.end.js"}},
       patterns: 
        [{match: /(?<_1>:)/,
          name: "punctuation.separator.key-value.js.mootools"},
         {include: "#fx-options"},
         {include: "source.js"}]}]},
   {comment: 
     "\nFx.Scroll\nScroll any element with an overflow, including the window element.\nhttp://docs.mootools.net/files/Effects/Fx-Scroll-js.html",
    match: /\b(?<_1>scrollTo|to(?<_2>Top|Bottom|Left|Right|Element))/,
    name: "support.class.scroll.fx.js.mootools"},
   {begin: /(?<_1>new)\s+(?<_2>Fx\.Scroll)(?<_3>\()/,
    beginCaptures: 
     {1 => {name: "keyword.operator.new.js"},
      2 => {name: "entity.name.type.instance.js.mootools"},
      3 => {name: "punctuation.definition.parameters.begin.js"}},
    contentName: "variable.parameter.fx.scroll.js.mootools",
    end: "(\\)(;|$))",
    endCaptures: {1 => {name: "punctuation.definition.parameters.end.js"}},
    patterns: 
     [{include: "#element-functions"},
      {include: "#array-functions"},
      {include: "#dom-functions"},
      {include: "#hash-functions"},
      {begin: /(?<_1>\{)/,
       beginCaptures: 
        {1 => {name: "punctuation.definition.parameters.begin.js"}},
       contentName: "variable.parameter.fx.scroll.options.js.mootools",
       end: "(\\})(?=\\))",
       endCaptures: {1 => {name: "punctuation.definition.parameters.end.js"}},
       patterns: 
        [{match: /(?<_1>:)/,
          name: "punctuation.separator.key-value.js.mootools"},
         {include: "#fx-options"},
         {include: "source.js"}]}]},
   {comment: 
     "\nFx.Slide\nThe slide effect; slides an element in horizontally or vertically, the contents will fold inside.\nhttp://docs.mootools.net/files/Effects/Fx-Slide-js.html",
    match: /\b(?<_1>slide(?<_2>In|Out)|hide|show|toggle)\b/,
    name: "support.class.slide.fx.js.mootools"},
   {begin: /(?<_1>new)\s+(?<_2>Fx\.Slide)(?<_3>\()/,
    beginCaptures: 
     {1 => {name: "keyword.operator.new.js"},
      2 => {name: "entity.name.type.instance.js.mootools"},
      3 => {name: "punctuation.definition.parameters.begin.js"}},
    contentName: "variable.parameter.fx.slide.js.mootools",
    end: "(\\)(;|$))",
    endCaptures: {1 => {name: "punctuation.definition.parameters.end.js"}},
    patterns: 
     [{include: "#element-functions"},
      {include: "#array-functions"},
      {include: "#dom-functions"},
      {include: "#hash-functions"},
      {begin: /(?<_1>\{)/,
       beginCaptures: 
        {1 => {name: "punctuation.definition.parameters.begin.js"}},
       contentName: "variable.parameter.fx.slide.options.js.mootools",
       end: "(\\})(?=\\))",
       endCaptures: {1 => {name: "punctuation.definition.parameters.end.js"}},
       patterns: 
        [{match: /(?<_1>:)/,
          name: "punctuation.separator.key-value.js.mootools"},
         {include: "#fx-options"},
         {include: "source.js"}]}]},
   {comment: 
     "\nFx.Style\nThe Style effect; Extends Fx.Base, inherits all its properties.\nhttp://docs.mootools.net/files/Effects/Fx-Style-js.html",
    match: /\b(?<_1>hide|start)\b/,
    name: "support.class.slide.fx.js.mootools"},
   {begin: /(?<_1>new)\s+(?<_2>Fx\.Style)(?<_3>\()/,
    beginCaptures: 
     {1 => {name: "keyword.operator.new.js"},
      2 => {name: "entity.name.type.instance.fx.style.js.mootools"},
      3 => {name: "punctuation.definition.parameters.begin.js"}},
    contentName: "variable.parameter.fx.style.js.mootools",
    end: "(\\)(;|$))",
    endCaptures: {1 => {name: "punctuation.definition.parameters.end.js"}},
    patterns: 
     [{include: "#element-functions"},
      {include: "#array-functions"},
      {include: "#dom-functions"},
      {include: "#hash-functions"},
      {begin: /,\s*(?<_1>\{)/,
       beginCaptures: 
        {1 => {name: "punctuation.definition.parameters.begin.js"}},
       contentName: "variable.parameter.fx.style.options.js.mootools",
       end: "(\\})(?=\\))",
       endCaptures: {1 => {name: "punctuation.definition.parameters.end.js"}},
       patterns: 
        [{match: /(?<_1>:)/,
          name: "punctuation.separator.key-value.js.mootools"},
         {include: "#fx-options"},
         {include: "source.js"}]}]},
   {match: /\b(?<_1>effect)\b/, name: "support.class.element.js.mootools"},
   {comment: 
     "\nFx.Styles\nAllows you to animate multiple css properties at once; Extends Fx.Base, inherits all its properties. \nhttp://docs.mootools.net/files/Effects/Fx-Styles-js.html",
    match: /\b(?<_1>start)\b/,
    name: "support.class.styles.fx.js.mootools"},
   {begin: /(?<_1>new)\s+(?<_2>Fx\.Styles)(?<_3>\()/,
    beginCaptures: 
     {1 => {name: "keyword.operator.new.js"},
      2 => {name: "entity.name.type.instance.js.mootools"},
      3 => {name: "punctuation.definition.parameters.begin.js"}},
    contentName: "variable.parameter.fx.styles.js.mootools",
    end: "(\\)(;|$))",
    endCaptures: {1 => {name: "punctuation.definition.parameters.end.js"}},
    patterns: 
     [{include: "#element-functions"},
      {include: "#array-functions"},
      {include: "#dom-functions"},
      {include: "#hash-functions"},
      {begin: /(?<_1>\{)/,
       beginCaptures: 
        {1 => {name: "punctuation.definition.parameters.begin.js"}},
       contentName: "variable.parameter.fx.styles.options.js.mootools",
       end: "(\\})(?=\\))",
       endCaptures: {1 => {name: "punctuation.definition.parameters.end.js"}},
       patterns: 
        [{match: /(?<_1>:)/,
          name: "punctuation.separator.key-value.js.mootools"},
         {include: "#fx-options"},
         {include: "source.js"}]}]},
   {match: /\b(?<_1>effects)\b/, name: "support.class.element.js.mootools"},
   {comment: 
     "\nFx.Transitions\nA collection of tweaning transitions for use with the Fx.Base classes.\nhttp://docs.mootools.net/files/Effects/Fx-Transitions-js.html",
    match: 
     /\b(?<_1>linear|quadIn|quadOut|quadInOut|cubicIn|cubicOut|cubicInOut|quartIn|quartOut|quartInOut|quintIn|quintOut|quintInOut|sineIn|sineOut|sineInOut|expoIn|expoOut|expoInOut|circIn|circOut|circInOut|elasticIn|elasticOut|elasticInOut|backIn|backOut|backInOut|bounceIn|bounceOut|bounceInOut)\b/,
    name: "support.class.transitions.fx.js.mootools"},
   {comment: 
     "\nFx.Utils\nContains Fx.Height, Fx.Width, Fx.Opacity.\nhttp://docs.mootools.net/files/Effects/Fx-Styles-js.html",
    match: /\b(?<_1>toggle|show)\b/,
    name: "support.class.fx.utils.js.mootools"},
   {begin: /(?<_1>new)\s+(?<_2>Fx\.(?:Height|Width|Opacity))(?<_3>\()/,
    beginCaptures: 
     {1 => {name: "keyword.operator.new.js"},
      2 => {name: "entity.name.type.instance.js.mootools"},
      3 => {name: "punctuation.definition.parameters.begin.js"}},
    contentName: "variable.parameter.fx.utils.js.mootools",
    end: "(\\));?$",
    endCaptures: {1 => {name: "punctuation.definition.parameters.end.js"}},
    patterns: 
     [{include: "#element-functions"},
      {include: "#array-functions"},
      {include: "#dom-functions"},
      {include: "#hash-functions"},
      {begin: /(?<_1>\{)/,
       beginCaptures: 
        {1 => {name: "punctuation.definition.parameters.begin.js"}},
       contentName: "variable.parameter.fx.utils.options.js.mootools",
       end: "(\\})\\)",
       endCaptures: {1 => {name: "punctuation.definition.parameters.end.js"}},
       patterns: 
        [{match: /(?<_1>:)/,
          name: "punctuation.separator.key-value.js.mootools"},
         {include: "#fx-options"},
         {include: "source.js"}]}]},
   {comment: 
     "\nDrag.Base\nModify two css properties of an element based on the position of the mouse.\nhttp://docs.mootools.net/files/Drag/Drag-Base-js.html",
    match: /\b(?<_1>makeResizable)\b/,
    name: "support.class.element.js.mootools"},
   {comment: 
     "\nDrag.Move\nModify two css properties of an element based on the position of the mouse.\nhttp://docs.mootools.net/files/Drag/Drag-Base-js.html",
    match: /\b(?<_1>makeDraggable)\b/,
    name: "support.class.element.js.mootools"},
   {include: "#leading-space"},
   {include: "source.js"}],
 repository: 
  {:"array-functions" => 
    {begin: /(?<_1>\$(?:each|A)\()/,
     beginCaptures: {1 => {name: "support.function.array.js.mootools"}},
     contentName: "variable.parameter.function.array.js.mootools",
     end: "(\\))",
     endCaptures: {1 => {name: "support.function.array.js.mootools"}},
     name: "meta.function.array.js.mootools",
     patterns: [{include: "source.js"}]},
   :"dom-functions" => 
    {begin: /(?<_1>\$ES?\()/,
     beginCaptures: {1 => {name: "support.function.dom.js.mootools"}},
     contentName: "variable.parameter.function.dom.js.mootools",
     end: "(\\))",
     endCaptures: {1 => {name: "support.function.dom.js.mootools"}},
     name: "meta.function.dom.js.mootools",
     patterns: [{include: "source.js"}]},
   :"element-functions" => 
    {begin: /(?<_1>\$?\$\()/,
     beginCaptures: {1 => {name: "support.function.element.js.mootools"}},
     contentName: "variable.parameter.function.element.js.mootools",
     end: "(\\))",
     endCaptures: {1 => {name: "support.function.element.js.mootools"}},
     name: "meta.function.element.js.mootools",
     patterns: [{include: "source.js"}]},
   :"fx-options" => 
    {patterns: 
      [{match: 
         /\b(?<_1>onStart|onComplete|transition|duration|unit|wait|fps)\b/,
        name: "support.class.keys.fx.options.js.mootools"},
       {match: /\b(?<_1>mode)\b/,
        name: "support.class.keys.fx.slide.options.js.mootools"}]},
   :"hash-functions" => 
    {begin: /(?<_1>\$H\()/,
     beginCaptures: {1 => {name: "support.function.hash.js.mootools"}},
     contentName: "variable.parameter.function.hash.js.mootools",
     end: "(\\))",
     endCaptures: {1 => {name: "support.function.hash.js.mootools"}},
     name: "meta.function.hash.js.mootools",
     patterns: [{include: "source.js"}]},
   :"leading-space" => 
    {comment: 
      "\nThe leading-space code is the ribbon highlighing thomas Aylott contributed to source.js.prototype.\nMore info in this thread:\nhttp://comox.textdrive.com/pipermail/textmate/2006-August/012373.html\n",
     patterns: 
      [{begin: /^(?=(?<_1>\t|  ))/,
        end: "(?=[^\\t\\s])",
        name: "meta.leading-tabs",
        patterns: 
         [{captures: 
            {1 => {name: "meta.odd-tab.group1.spaces"},
             10 => {name: "meta.even-tab.group10.spaces"},
             11 => {name: "meta.odd-tab.group11.spaces"},
             2 => {name: "meta.even-tab.group2.spaces"},
             3 => {name: "meta.odd-tab.group3.spaces"},
             4 => {name: "meta.even-tab.group4.spaces"},
             5 => {name: "meta.odd-tab.group5.spaces"},
             6 => {name: "meta.even-tab.group6.spaces"},
             7 => {name: "meta.odd-tab.group7.spaces"},
             8 => {name: "meta.even-tab.group8.spaces"},
             9 => {name: "meta.odd-tab.group9.spaces"}},
           match: 
            /(?<_1>  )(?<_2>  )?(?<_3>  )?(?<_4>  )?(?<_5>  )?(?<_6>  )?(?<_7>  )?(?<_8>  )?(?<_9>  )?(?<_10>  )?(?<_11>  )?/},
          {captures: 
            {1 => {name: "meta.odd-tab.group1.tab"},
             10 => {name: "meta.even-tab.group10.tab"},
             11 => {name: "meta.odd-tab.group11.tab"},
             2 => {name: "meta.even-tab.group2.tab"},
             3 => {name: "meta.odd-tab.group3.tab"},
             4 => {name: "meta.even-tab.group4.tab"},
             5 => {name: "meta.odd-tab.group5.tab"},
             6 => {name: "meta.even-tab.group6.tab"},
             7 => {name: "meta.odd-tab.group7.tab"},
             8 => {name: "meta.even-tab.group8.tab"},
             9 => {name: "meta.odd-tab.group9.tab"}},
           match: 
            /(?<_1>\t)(?<_2>\t)?(?<_3>\t)?(?<_4>\t)?(?<_5>\t)?(?<_6>\t)?(?<_7>\t)?(?<_8>\t)?(?<_9>\t)?(?<_10>\t)?(?<_11>\t)?/}]}]}},
 scopeName: "source.js.mootools",
 uuid: "7E4B5859-2FB4-4D2A-9105-276BDE28B94E"}
