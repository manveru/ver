# Encoding: UTF-8

{comment: 
  "Prototype and Scriptaculous Javascript Frameworks. By Justin Palmer, Thomas Aylott & Martin Ström",
 foldingStartMarker: /(?<_1>^.*{[^}]*$|^.*\([^\)]*$|^.*\/\*(?!.*\*\/).*$)/,
 foldingStopMarker: /(?<_1>^\s*\}|^\s*\)|^(?!.*\/\*).*\*\/)/,
 keyEquivalent: "^~J",
 name: "Prototype & Script.aculo.us (JavaScript)",
 patterns: 
  [{match: 
     /\b(?<_1>Prototype|Class|Abstract|Try|PeriodicalExecuter|Enumerable|Hash|ObjectRange|Element|Ajax|Responders|Base|Request|Updater|PeriodicalUpdater|Toggle|Insertion|Before|Top|Bottom|After|ClassNames|Form|Serializers|TimedObserver|Observer|EventObserver|Event|Position|Effect|Effect2|Transitions|ScopedQueue|Queues|DefaultOptions|Parallel|Opacity|Move|MoveBy|Scale|Highlight|ScrollTo|Fade|Appear|Puff|BlindUp|BlindDown|SwitchOff|DropOut|Shake|SlideDown|SlideUp|Squish|Grow|Shrink|Pulsate|Fold|console)\b/,
    name: "support.class.prototype.js"},
   {match: 
     /\b(?<_1>Version|ScriptFragment|emptyFunction|K|create|toColorPart|succ|times|these|initialize|registerCallback|onTimerEvent|stripTags|stripScripts|extractScripts|evalScripts|escapeHTML|unescapeHTML|toQueryParams|toArray|camelize|inspect|each|inGroupsOf|eachSlice|all|any|collect|detect|findAll|grep|include|inject|invoke|max|min|partition|pluck|reject|sortBy|toArray|zip|inspect|map|find|select|member|entries|_each|_reverse|reverse|clear|first|last|compact|flatten|without|indexOf|reverse|shift|inspect|keys|values|merge|toQueryString|inspect|include|getTransport|activeRequestCount|responders|register|unregister|dispatch|onComplete|setOptions|responseIsSuccess|responseIsFailure|request|setRequestHeaders|onStateChange|header|evalJSON|evalResponse|respondToReadyState|dispatchException|updateContent|start|stop|updateComplete|toggle|hide|show|remove|update|getHeight|classNames|hasClassName|addClassName|removeClassName|cleanWhitespace|empty|scrollTo|getStyle|setStyle|getDimensions|makePositioned|undoPositioned|makeClipping|undoClipping|recursivelyCollect|ancestors|descendants|previousSiblings|nextSiblings|siblings|match|up|down|previous|next|getElementsBySelector|getElementsByClassName|contentFromAnonymousTable|initializeRange|insertContent|set|add|toString|focus|present|activate|serialize|getElements|getInputs|disable|enable|findFirstElement|focusFirstElement|reset|getValue|input|inputSelector|textarea|selectOne|selectMany|onElementEvent|registerFormCallbacks|element|isLeftClick|pointerX|pointerY|findElement|observers|unloadCache|observe|stopObserving|includeScrollOffsets|prepare|realOffset|cumulativeOffset|positionedOffset|offsetParent|within|withinIncludingScrolloffsets|overlap|clone|page|clone|absolutize|relativize)\b/,
    name: "support.function.js.prototype"},
   {include: "source.js"},
   {match: 
     /(?<_1>(?<=var\s)\b[a-zA-Z]\w*\b|\b[a-zA-Z]\w*\b(?=(?<_2>\[|\s*(?<_3>&|\*|\-\-|\-|\+\+|\+|~|===|==|=|!=|!==|<=|>=|<<=|>>=|>>>=|<>|<|>|!|&&|\|\||\?\:|\*=|\/=|%=|\+=|\-=|&=|\^=))))/,
    name: "variable.other.js.prototype"},
   {include: "#leading-space"}],
 repository: 
  {:"leading-space" => 
    {patterns: 
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
 scopeName: "source.js.prototype",
 uuid: "0BD60463-DDF6-436F-9295-89DEF577FF30"}
