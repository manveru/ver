# Encoding: UTF-8

{"BA.t" => 
  {scope: "source.ocaml",
   name: "Native sized signed int",
   content: "nativeint_elt"},
 "Dynlink.err" => 
  {scope: "source.ocaml", name: "Unsafe_file", content: "Dynlink.Unsafe_file"},
 "Dbm.Dbm_" => 
  {scope: "source.ocaml", name: "Open write-only", content: "Dbm.Dbm_wronly"},
 "Dynlink.lerr" => 
  {scope: "source.ocaml",
   name: "Uninitialized_global",
   content: "Dynlink.Uninitialized_global ${1:global}$0"},
 "bi" => 
  {scope: "source.ocaml", name: "zero_big_int", content: "zero_big_int"},
 "num" => 
  {scope: "source.ocaml", name: "succ_num", content: "succ_num ${1:num}$0"},
 "rat" => 
  {scope: "source.ocaml",
   name: "sub_ratio",
   content: "sub_ratio ${1:ratio} ${2:ratio2}$0"},
 "Dynlink." => 
  {scope: "source.ocaml",
   name: "prohibit",
   content: "Dynlink.prohibit ${1:[${2:unit_list;}]}${3:;}$0"},
 "Event." => 
  {scope: "source.ocaml",
   name: "wrap_abort",
   content: "Event.wrap_abort ${1:even} ${2:(fun () -> ${3:})}$0"},
 "arith" => 
  {scope: "source.ocaml",
   name: "set_normalize_ratio_when_printing",
   content: "set_normalize_ratio_when_printing ${1:true}${2:;}$0"},
 "BA." => 
  {scope: "source.ocaml",
   name: "reshape_3",
   content: 
    "reshape_3 ${1:genarray} ${2:new_dim1} ${3:new_dim2} ${4:new_dim3}$0"},
 "Array1." => 
  {scope: "source.ocaml",
   name: "sub",
   content: "Array1.sub ${1:bigarraay} ${2:offset} ${3:len}$0"},
 "Genarray." => 
  {scope: "source.ocaml",
   name: "sub_right (Fortran layout only)",
   content: "Genarray.sub_right ${1:genarray} ${2:offset} ${3:len}$0"},
 "Array3." => 
  {scope: "source.ocaml",
   name: "sub_right (Fortran layout only)",
   content: "Array3.sub_right ${1:bigarray} ${2:offset} ${3:len}$0"},
 "Array2." => 
  {scope: "source.ocaml",
   name: "sub_right (Fortran layout only)",
   content: "Array2.sub_right ${1:bigarray} ${2:offset} ${3:len}$0"},
 "Str." => 
  {scope: "source.ocaml",
   name: "substitute_first",
   content: "Str.substitute_first ${1:regexp} ${2:subst_func} ${3:str}$0"},
 "Condition." => 
  {scope: "source.ocaml",
   name: "wait",
   content: "Condition.wait ${1:cond} ${2:mtx}${3:;}$0"},
 "BA.kind" => {scope: "source.ocaml", name: "nativeint", content: "nativeint"},
 "Dbm." => 
  {scope: "source.ocaml",
   name: "replace",
   content: "Dbm.replace ${1:db} ${2:key} ${3:data}$0"},
 "Mutex." => 
  {scope: "source.ocaml",
   name: "unlock",
   content: "Mutex.unlock ${1:mtx}${2:;}$0"},
 "Thread." => 
  {scope: "source.ocaml", name: "yield", content: "Thread.yield ()${1:;}$0"}}
