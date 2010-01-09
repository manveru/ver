# Encoding: UTF-8

{"se" => 
  {scope: "source.processing",
   name: "setup",
   content: "void setup() {\n\t$1\n}"},
 "float" => 
  {scope: "source.processing", name: "float", content: "float $1 = $2;"},
 "float[]" => 
  {scope: "source.processing",
   name: "float[]",
   content: "float[] $1 = new float[$2];"},
 "int" => {scope: "source.processing", name: "int", content: "int $1 = $2;"},
 "int[]" => 
  {scope: "source.processing",
   name: "int[]",
   content: "int[] $1 = new int[$2];"},
 "gl" => 
  {scope: "source.processing",
   name: "opengl",
   content: "import processing.opengl.*;"},
 "size" => 
  {scope: "source.processing",
   name: "size",
   content: "size($1, $2, ${3:P3D});"},
 "str" => 
  {scope: "source.processing", name: "string", content: "string $1 = $2;"},
 "string[]" => 
  {scope: "source.processing",
   name: "string[]",
   content: "string[] $1 = new string[$2];"},
 "void" => 
  {scope: "source.processing",
   name: "void method",
   content: "void $1($2 $3) {\n\t$4\n}"}}
