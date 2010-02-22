# Encoding: UTF-8

{"num" => 
  {scope: "source.ocaml",
   name: "decr_num",
   content: "decr_num ${1:num_ref}$0"},
 "Array3." => 
  {scope: "source.ocaml",
   name: "sub_left (C layout only)",
   content: "Array3.sub_left ${1:bigarray} ${2:offset} ${3:len}$0"},
 "Thread." => 
  {scope: "source.ocaml",
   name: "delay",
   content: "Thread.delay ${1:secs}${2:;}$0"},
 "rat" => 
  {scope: "source.ocaml",
   name: "eq_ratio",
   content: "eq_ratio ${1:ratio} ${2:ratio2}$0"},
 "BA." => 
  {scope: "source.ocaml",
   name: "genarray_of_array3",
   content: "genarray_of_array3 ${1:bigarray3}$0"},
 "Dbm.Dbm_" => 
  {scope: "source.ocaml",
   name: "Open for reading and writing",
   content: "Dbm.Dbm_rdwr"},
 "bi" => 
  {scope: "source.ocaml",
   name: "gt_big_int",
   content: "gt_big_int ${1:bi} ${2:bi2}$0"},
 "arith" => 
  {scope: "source.ocaml",
   name: "set_floating_precision",
   content: "set_floating_precision ${1:precision}${2:;}$0"},
 "Str." => 
  {scope: "source.ocaml",
   name: "string_before",
   content: "Str.string_before ${1:str} ${2:pos}$0"},
 "BA.t" => 
  {scope: "source.ocaml", name: "32-bit float", content: "float32_elt"},
 "Event." => 
  {scope: "source.ocaml", name: "poll", content: "Event.poll ${1:event}$0"},
 "Genarray." => 
  {scope: "source.ocaml",
   name: "sub_right (Fortran layout only)",
   content: "Genarray.sub_right ${1:genarray} ${2:offset} ${3:len}$0"},
 "Dynlink.err" => 
  {scope: "source.ocaml",
   name: "Cannot_open_dll",
   content: "Dynlink.Cannot_open_dll ${1:file_name}$0"},
 "Condition." => 
  {scope: "source.ocaml",
   name: "signal",
   content: "Condition.signal ${1:cond}${2:;}$0"},
 "Dynlink.lerr" => 
  {scope: "source.ocaml",
   name: "Undefined_global",
   content: "Dynlink.Undefined_global ${1:global}$0"},
 "Mutex." => 
  {scope: "source.ocaml", name: "create", content: "Mutex.create ()${1:;}$0"},
 "Array2." => 
  {scope: "source.ocaml",
   name: "map_file",
   content: 
    "Array2.map_file ${1:Unix.file_descr} BA.kind$0 ${2:fortran}_layout${3:shared} ${4:dim1} ${5:dim2}"},
 "Dynlink." => 
  {scope: "source.ocaml",
   name: "default_available_units",
   content: "Dynlink.default_available_units ()${1:;}$0"},
 "Array1." => 
  {scope: "source.ocaml", name: "dim", content: "Array1.dim ${1:bigarraay}$0"},
 "Dbm." => 
  {scope: "source.ocaml", name: "firstkey", content: "Dbm.firstkey ${1:db}$0"},
 "BA.kind" => {scope: "source.ocaml", name: "int32", content: "int32"}}
