# Encoding: UTF-8

{"blog" => 
  {scope: "text.html.mt",
   name: "BlogSitePath",
   content: "<\\$mt:BlogSitePath\\$>"},
 "cat" => 
  {scope: "text.html.mt",
   name: "CategoryTrackbackLink",
   content: "<\\$mt:CategoryTrackbackLink\\$>"},
 "entries" => 
  {scope: "text.html.mt",
   name: "EntriesHeader",
   content: "<mt:EntriesHeader>\n\t$1\n</mt:EntriesHeader>"},
 "archive" => 
  {scope: "text.html.mt",
   name: "ArchiveDateEnd",
   content: "<\\$mt:ArchiveDateEnd\\$>"},
 "entry" => 
  {scope: "text.html.mt", name: "EntryBody", content: "<\\$mt:EntryBody\\$>"},
 "cal" => 
  {scope: "text.html.mt",
   name: "CalendarIfToday",
   content: "<mt:CalendarIfToday>\n\t$1\n</mt:CalendarIfToday>"},
 "mttag" => 
  {scope: "source.perl",
   name: "MT Variable Tag",
   content: 
    "MT::Template::Context->add_tag(${1:TagName} => \\&${2:_hdlr_${1/(?:([a-z])([A-Z]))|([A-Za-z0-9_]+?)|( )|(.)/(?4:_:(?3:\\L$3:(?1:$1_\\L$2:)))/g}});\n\nsub $2 {\n\tmy (\\$ctx, \\$args, \\$cond) = @_;\n\t$3\n}\n"},
 "else" => {scope: "text.html.mt", name: "Else", content: "<mt:Else>"},
 "if" => 
  {scope: "text.html.mt",
   name: "If",
   content: "<mt:If ${1:name}=\"$2\"${3: ${4:eq}=\"$5\"}>$6</mt:If>"},
 "mt" => {scope: "text.html.mt", name: "Function", content: "<\\$mt:$1\\$>"},
 "unless" => 
  {scope: "text.html.mt",
   name: "Unless",
   content: "<mt:Unless ${1:name}=\"$2\"${3: ${4:eq}=\"$5\"}>$6</mt:Unless>"},
 "var" => 
  {scope: "text.html.mt",
   name: "SetVarBlock",
   content: "<mt:SetVarBlock name=\"$1\">$2</mt:SetVarBlock>"},
 "ignore" => 
  {scope: "text.html.mt",
   name: "Ignore",
   content: "<mt:Ignore>${1:$TM_SELECTED_TEXT}</mt:Ignore>"},
 "include" => 
  {scope: "text.html.mt",
   name: "Include",
   content: "<\\$mt:Include ${1:module}=\"$2\"\\$>"}}
