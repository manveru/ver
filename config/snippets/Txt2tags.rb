# Encoding: UTF-8

{nil => 
  {scope: "text.txt2tags",
   name: "Underline",
   content: "__${1:${TM_SELECTED_TEXT}}__"},
 "date" => 
  {scope: "text.txt2tags",
   name: "Current Date",
   content: 
    "%%date(year:%Y month:%m day:%d hour:%H min:%M sec:%S date:%c weekday:%A %a month-name:%B %b)"},
 "encoding" => 
  {scope: "text.txt2tags",
   name: "Encoding",
   content: 
    "%!encoding(${1:html | xhtml | sgml | tex | lout | man | mgp | wiki | gwiki | doku | moin | pm6 | txt}): ${2:utf-8}\n"},
 "[" => 
  {scope: "text.txt2tags",
   name: "Link",
   content: 
    "[${1:${TM_SELECTED_TEXT:Site Name}} ${2:`#!/usr/bin/env ruby\n\ndef entity_escape(text)\n  # no need to escape, txt2tags already does it\n  return text\nend\n\ndef make_link(text)\n  case text\n  when %r{\\A(mailto:)?(.*?@.*\\..*)\\z}:        \"mailto:\#{$2}\"\n  when %r{\\A[a-zA-Z][a-zA-Z0-9.+-]*://.*\\z}:  entity_escape(text)\n  when %r{\\A.*\\.(com|uk|net|org|info)\\z}:     \"http://\#{entity_escape text}\"\n  when %r{\\A\\S+\\z}:                           entity_escape(text)\n  else                                        \"http://example.com/\"\n  end\nend\n\ntext = %x{__CF_USER_TEXT_ENCODING=$UID:0x8000100:0x8000100 pbpaste}.strip\nprint make_link(text)\n\n`}]"},
 "include" => 
  {scope: "text.txt2tags",
   name: "Include as Verbatim",
   content: 
    "%!include(${1:html | xhtml | sgml | tex | lout | man | mgp | wiki | gwiki | doku | moin | pm6 | txt}): ``${2:file.txt}``\n"},
 "infile" => 
  {scope: "text.txt2tags",
   name: "Input File",
   content: 
    "%%infile(file:%f extension:%e dir:%d path:%p file-without-extension:%F parent-dir:%D)"},
 "mtime" => 
  {scope: "text.txt2tags",
   name: "Modification Time",
   content: 
    "%%mtime(year:%Y month:%m day:%d hour:%H min:%M sec:%S date:%c weekday:%A %a month-name:%B %b)"},
 "+" => 
  {scope: "text.txt2tags",
   name: "Numbered Title",
   content: 
    "+ ${1:${TM_SELECTED_TEXT:My Title}} +${2:[${3:optional-anchor}]}"},
 "options" => 
  {scope: "text.txt2tags",
   name: "Options",
   content: 
    "%!options(${1:html | xhtml | sgml | tex | lout | man | mgp | wiki | gwiki | doku | moin | pm6 | txt}): ${2:--no-headers | --enum-title | --toc | --toc-level n | --css-sugar | --css-inside | --mask-email | --config-file file | --outfile file}\n"},
 "outfile" => 
  {scope: "text.txt2tags",
   name: "Output File",
   content: 
    "%%outfile(file:%f extension:%e dir:%d path:%p file-without-extension:%F parent-dir:%D)"},
 "filter" => 
  {scope: "text.txt2tags",
   name: "Pre-Processing",
   content: 
    "%!preproc(${1:html | xhtml | sgml | tex | lout | man | mgp | wiki | gwiki | doku | moin | pm6 | txt}): \"${2:pattern}\" \"${3:replacement}\" \n"},
 ">" => 
  {scope: "text.txt2tags",
   name: "Quote",
   content: "\t${1:- insert quote here -}"},
 "style" => 
  {scope: "text.txt2tags",
   name: "Style",
   content: "%!style(${1:html | xhtml | tex}): ${2:style.css}\n"},
 "toc" => 
  {scope: "text.txt2tags", name: "Table Of Contents", content: "\n%%toc\n"},
 "target" => 
  {scope: "text.txt2tags",
   name: "Target",
   content: 
    "%!target: ${1:html | xhtml | sgml | tex | lout | man | mgp | wiki | gwiki | doku | moin | pm6 | txt}\n"},
 "=" => 
  {scope: "text.txt2tags",
   name: "Title",
   content: 
    "= ${1:${TM_SELECTED_TEXT:My Title}} =${2:[${3:optional-anchor}]}"},
 "`" => 
  {scope: "text.txt2tags",
   name: "Verbatim Block (Code)",
   content: 
    "\n\\`\\`\\`\n${1:${TM_SELECTED_TEXT:- insert code here -}}\n\\`\\`\\`\n"}}
