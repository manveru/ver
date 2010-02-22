# Encoding: UTF-8

{"=" => 
  {scope: "text.moinmoin",
   name: "Heading Level 2",
   content: "== $1 ==\n\n$0\n"},
 nil => 
  {scope: "text.moinmoin", name: "Italic", content: "''$TM_SELECTED_TEXT''"},
 "Date" => 
  {scope: "text.moinmoin",
   name: "Date",
   content: "`TZ=UTC date '+[[Date(%Y-%m-%dT%H:%m:%SZ)]]'`"}}
