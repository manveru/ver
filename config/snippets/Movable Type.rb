# Encoding: UTF-8

{"archive" => 
  {scope: "text.html.mt",
   name: "ArchiveList",
   content: 
    "<mt:ArchiveList archive_type=\"${1:Individual;Monthly;Weekly;Daily;Category}\">\n<mt:ArchiveListHeader><ul></mt:ArchiveListHeader>\n\t<li><a href=\"<\\$mt:ArchiveLink\\$>\"><\\$mt:ArchiveTitle\\$></li>\n<mt:ArchiveListFooter></ul></mt:ArchiveListFooter>\n</mt:ArchiveList>"},
 "blog" => 
  {scope: "text.html.mt",
   name: "Blogs",
   content: "<mt:Blogs>\n\t$1\n</mt:Blogs>"},
 "cal" => 
  {scope: "text.html.mt",
   name: "CalendarIfWeekHeader",
   content: "<mt:CalendarWeekHeader>\n\t$1\n</mt:CalendarWeekHeader>"},
 "cat" => 
  {scope: "text.html.mt",
   name: "CategoryTrackbackLink",
   content: "<\\$mt:CategoryTrackbackLink\\$>"},
 "entries" => 
  {scope: "text.html.mt",
   name: "EntriesHeader",
   content: "<mt:EntriesHeader>\n\t$1\n</mt:EntriesHeader>"},
 "entry" => 
  {scope: "text.html.mt",
   name: "EntryTitle",
   content: "<\\$mt:EntryTitle\\$>"},
 "mttag" => 
  {scope: "source.perl",
   name: "MT Variable Tag",
   content: 
    "MT::Template::Context->add_tag(${1:TagName} => \\&${2:_hdlr_${1/(?:([a-z])([A-Z]))|([A-Za-z0-9_]+?)|( )|(.)/(?4:_:(?3:\\L$3:(?1:$1_\\L$2:)))/g}});\n\nsub $2 {\n\tmy (\\$ctx, \\$args, \\$cond) = @_;\n\t$3\n}\n"},
 "mt" => {scope: "text.html.mt", name: "Function", content: "<\\$mt:$1\\$>"},
 "else" => {scope: "text.html.mt", name: "Else", content: "<mt:Else>"},
 "if" => 
  {scope: "text.html.mt",
   name: "If",
   content: "<mt:If ${1:name}=\"$2\"${3: ${4:eq}=\"$5\"}>$6</mt:If>"},
 "ignore" => 
  {scope: "text.html.mt",
   name: "Ignore",
   content: "<mt:Ignore>${1:$TM_SELECTED_TEXT}</mt:Ignore>"},
 "include" => 
  {scope: "text.html.mt",
   name: "Include",
   content: "<\\$mt:Include ${1:module}=\"$2\"\\$>"},
 "var" => 
  {scope: "text.html.mt",
   name: "Var",
   content: 
    "<\\$mt:Var name=\"$1\"${2: value=\"$3\"}${4: escape=\"${5:html/js/url}\"}\\$>"},
 "unless" => 
  {scope: "text.html.mt",
   name: "Unless",
   content: "<mt:Unless ${1:name}=\"$2\"${3: ${4:eq}=\"$5\"}>$6</mt:Unless>"}}
