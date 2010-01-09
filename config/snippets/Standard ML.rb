# Encoding: UTF-8

{"functor" => 
  {scope: "source.ml",
   name: "Base Functor",
   content: "functor $1($2) : $3 =\nstruct\n\t$4\nend"},
 "fs" => 
  {scope: "source.ml",
   name: "Base Funsig",
   content: "funsig $1 ($2) =\nsig\n\t$3\nend"},
 "sig" => 
  {scope: "source.ml, source.sig",
   name: "Base Signature",
   content: "signature $1 =\nsig\n\t$2\nend"},
 "struct" => 
  {scope: "source.ml",
   name: "Base Structure",
   content: "structure $1 =\nstruct\n\t$2\nend"},
 "rbm" => 
  {scope: "source.ml",
   name: "RedBlackMap",
   content: 
    "structure ${1:Map} = RedBlackMapFn(struct\n                                          type ord_key = $2\n                                          val compare = $3\n                                    end)"},
 "rbs" => 
  {scope: "source.ml",
   name: "RedBlackSet",
   content: 
    "structure ${1:Set} = RedBlackSetFn (struct\n                                           type ord_key = $2\n\t\t\t\t\t\t\t\t\t val compare = $3\n                                    end)\n"},
 "itos" => {scope: "source.ml", name: "itos", content: "Int.toString $1"}}
