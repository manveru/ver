# Encoding: UTF-8

[{name: "Bulletin Board",
  scope: "text.bbcode",
  settings: 
   {shellVariables: 
     [{name: "TM_LINK_FORMAT",
       value: "[URL=<%= e_sn url %>]<%= e_sn input %>[/URL]"}]},
  uuid: "8CCCD8B6-9583-4B5D-8CBF-0867B14E86D7"},
 {name: "DokuWiki",
  scope: "text.html.dokuwiki",
  settings: 
   {shellVariables: 
     [{name: "TM_LINK_FORMAT",
       value: "[[<%= e_sn url %>|<%= e_sn input %>]]"}]},
  uuid: "9793A1A9-F6B5-421E-A147-123CCAE3D58E"},
 {name: "Fallback (not supported)",
  settings: 
   {shellVariables: 
     [{name: "TM_LINK_FORMAT",
       value: "(this language is not supported, see … for more info)"}]},
  uuid: "CA3F1BC7-8F8A-464F-BC3A-322B437F9E8E"},
 {name: "HTML",
  scope: "text.html",
  settings: 
   {shellVariables: 
     [{name: "TM_LINK_FORMAT",
       value: 
        "<a href=\"<%= e_sn url %>\"<%= \" title=\\\"\\${1:\#{e_sn title}}\\\"\" if defined? title %>><%= e_sn input %></a>"}]},
  uuid: "7D88D7CF-AC5B-491E-801F-FD5AC1F525CB"},
 {name: "LaTeX",
  scope: "text.tex.latex",
  settings: 
   {shellVariables: 
     [{name: "TM_LINK_FORMAT",
       value: "\\href{<%= e_sn url %>}{<%= e_sn input %>}"}]},
  uuid: "22EC4A8D-69B4-44D5-A029-EE67B144B53E"},
 {name: "Markdown",
  scope: "text.html.markdown -meta.disable-markdown",
  settings: 
   {shellVariables: 
     [{name: "TM_LINK_FORMAT",
       value: 
        "[<%= e_sn input %>](<%= e_sn url %><%= \" \\\"\\${1:\#{e_sn title}}\\\"\" if defined? title %>)"}]},
  uuid: "86084226-4371-4593-BC83-FF2023817BCD"},
 {name: "Mediawiki",
  scope: "text.html.mediawiki",
  settings: 
   {shellVariables: 
     [{name: "TM_LINK_FORMAT", value: "[<%= e_sn url %> <%= e_sn input %>]"}]},
  uuid: "8B0130E3-6091-445A-BBDA-B1BFC01AADF7"},
 {name: "MoinMoin",
  scope: "text.moinmoin",
  settings: 
   {shellVariables: 
     [{name: "TM_LINK_FORMAT", value: "[<%= e_sn url %> <%= e_sn input %>]"}]},
  uuid: "1EA4CA8E-1A38-4383-A288-BEE6359A6966"},
 {name: "TWiki",
  scope: "text.html.twiki",
  settings: 
   {shellVariables: 
     [{name: "TM_LINK_FORMAT",
       value: "[[<%= e_sn url %>][<%= e_sn input %>]]"}]},
  uuid: "3A357346-EC7D-4F9F-AE65-D61AD62080CA"},
 {name: "Textile",
  scope: "text.html.textile",
  settings: 
   {shellVariables: 
     [{name: "TM_LINK_FORMAT",
       value: "\"<%= e_sn input %>\":<%= e_sn url %>"}]},
  uuid: "F514F82B-9C65-46BA-B264-D2F374372C54"},
 {name: "reStructuredText",
  scope: "text.restructuredtext",
  settings: 
   {shellVariables: 
     [{name: "TM_LINK_FORMAT",
       value: "\\`<%= e_sn input %><<%= e_sn url %>>\\`_"}]},
  uuid: "F609EFEF-BFD8-4088-815D-1C17BB90FEAD"}]
