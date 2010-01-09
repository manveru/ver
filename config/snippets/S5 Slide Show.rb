# Encoding: UTF-8

{"controls" => 
  {scope: "source.s5",
   name: "Controls",
   content: "Controls: ${1:visible|hidden}"},
 "cut" => 
  {scope: "source.s5",
   name: "Slide Divider",
   content: 
    "✂------✂------✂------✂------✂------✂------✂------✂------✂------✂------\n"},
 "view" => 
  {scope: "source.s5", name: "View", content: "View: ${1:slideshow|outline}"},
 "hand" => 
  {scope: "source.s5",
   name: "Handout",
   content: "__________\n\n${1:Notes for printout}\n"},
 "slide" => 
  {scope: "source.s5",
   name: "New Slide",
   content: 
    "✂------✂------✂------✂------✂------✂------✂------✂------✂------✂------\n\n${1:Heading}\n${1/(.)|(?m:\\n.*)/(?1:=)/g}\n${2:Subheading}\n${2/(.)|(?m:\\n.*)/(?1:-)/g}\n\n${3:* Point One\n* Point Two\n  * Subpoint\n* Point Three}\n"},
 "note" => 
  {scope: "source.s5",
   name: "Notes",
   content: "##########\n\n${1:Notes for presenting}\n"}}
