# Encoding: UTF-8

{"al" => 
  {scope: "source.fortran",
   name: "Allocate Array",
   content: 
    "allocate(${1:array}, stat=${2:err})\nif ($2 /= 0) print *, \"${1/(\\w+).*/$1/}: Allocation request denied\"\n"},
 "alloc" => 
  {scope: "source.fortran",
   name: "Allocate and Deallocate array",
   content: 
    "allocate(${1:array}, stat=${2:err})\nif ($2 /= 0) print *, \"${1/(\\w+).*/$1/}: Allocation request denied\"\n\n$0if (allocated(${1/(\\w+).*/$1/})) deallocate(${1/(\\w+).*/$1/}, stat=$2)\nif ($2 /= 0) print *, \"${1/(\\w+).*/$1/}: Deallocation request denied$0\""},
 "and" => {scope: "source.fortran", name: "And", content: ".and."},
 "char" => 
  {scope: "source.fortran",
   name: "Character",
   content: 
    "character(len=$1${2:, kind=$3})${4:, ${5:attributes}} :: ${6:name}"},
 "close" => 
  {scope: "source.fortran",
   name: "Close File",
   content: 
    "close(unit=${1:iounit}, iostat=${2:ios}${3:, status=\"delete\"})\nif ( $2 /= 0 ) stop \"Error closing file unit $1\"\n"},
 "typ" => 
  {scope: "source.fortran",
   name: "Custom Type",
   content: "type(${1:type name})${2:, ${3:attributes}} :: ${4:name}"},
 "deal" => 
  {scope: "source.fortran",
   name: "Deallocate Array",
   content: 
    "if (allocated($1)) deallocate(${1:array}, stat=${2:err})\nif ($2 /= 0) print *, \"$1: Deallocation request denied$0\""},
 "dot" => 
  {scope: "source.fortran",
   name: "Dot Product of Vectors",
   content: "dot_product($1,$2)"},
 "eq" => {scope: "source.fortran", name: "Equal", content: ".eq."},
 "eqv" => {scope: "source.fortran", name: "Equality", content: ".eqv."},
 "gt" => {scope: "source.fortran", name: "Greater Than", content: ".gt."},
 "ge" => {scope: "source.fortran", name: "Greater or Equal", content: ".ge."},
 "ido" => 
  {scope: "source.fortran",
   name: "Implied do",
   content: "(${1:i}, $1 = ${2:1}, ${3:100}, ${4:1})$0"},
 "maxloc" => 
  {scope: "source.fortran",
   name: "Index of Maximum",
   content: "maxloc(${1:source}${2:, mask=${3:($1>0)}})"},
 "minloc" => 
  {scope: "source.fortran",
   name: "Index of Minimum",
   content: "minloc(${1:source}${2:, mask=${3:$1>0}})"},
 "open" => 
  {scope: "source.fortran",
   name: "Scratch File",
   content: 
    "open(unit=${1:iounit}, iostat=${3:ios}, status=\"${4:scratch}\", action=\"${5:readwrite}\")\nif ( $3 /= 0 ) stop \"Error opening scratch file on unit $1\"\n"},
 "inq" => 
  {scope: "source.fortran",
   name: "Inquire (by Unit)",
   content: 
    "inquire(unit=${1:iounit}, opened=${2:ioopen}, name=${3:filename}, action=${4:ioaction})"},
 "int" => 
  {scope: "source.fortran",
   name: "Integer",
   content: "integer${1:(${2:kind})}${3:, ${4:attributes}} :: ${5:name}"},
 "lt" => {scope: "source.fortran", name: "Less Than", content: ".lt."},
 "le" => {scope: "source.fortran", name: "Less or Equal", content: ".le."},
 nil => 
  {scope: "source.fortran",
   name: "Wrap Selection in Array Brackets",
   content: "(/ $TM_SELECTED_TEXT$0 /)"},
 "log" => 
  {scope: "source.fortran",
   name: "Logical",
   content: "logical${1:(${2:kind})}${3:, ${4:attributes}} :: ${5:name}"},
 "lbound" => 
  {scope: "source.fortran",
   name: "Lower Bound",
   content: "lbound(${1:source}${2:, dim=${3:1}})"},
 "mat" => 
  {scope: "source.fortran",
   name: "Matrix Multiplication",
   content: "matmul($1,$2)"},
 "maxval" => 
  {scope: "source.fortran",
   name: "Maximum Value",
   content: "maxval(${1:source}${2:, dim=${3:1}}${4:, mask=${5:($1>0)}})"},
 "minval" => 
  {scope: "source.fortran",
   name: "Minimum Value",
   content: "minval(${1:source}${2:, dim=${3:1}}${4:, mask=${5:($1>0)}})"},
 "neqv" => {scope: "source.fortran", name: "Non-Equality", content: ".neqv."},
 "not" => {scope: "source.fortran", name: "Not", content: ".not."},
 "or" => {scope: "source.fortran", name: "Or", content: ".or."},
 "prod" => 
  {scope: "source.fortran",
   name: "Product of Elements",
   content: "product(${1:source}${2:, dim=${3:1}}${4:, mask=${5:($1>0)}})"},
 "c" => 
  {scope: "source.fortran",
   name: "Quick Character",
   content: "character(len=*) :: "},
 "t" => 
  {scope: "source.fortran",
   name: "Quick Custom Type",
   content: "type(${1:type name}) :: "},
 "i" => 
  {scope: "source.fortran", name: "Quick Integer", content: "integer :: "},
 "l" => 
  {scope: "source.fortran", name: "Quick Logical", content: "logical :: "},
 "op" => 
  {scope: "source.fortran",
   name: "Quick Open",
   content: 
    "open(unit=${1:iounit}, file=${2:name}, iostat=${3:ios})\nif ( $3 /= 0 ) stop \"Error opening file ${2/[\\\"\\'](.*)[\\\"\\']/$1/}\""},
 "re" => {scope: "source.fortran", name: "Quick Read", content: "read*, "},
 "r" => {scope: "source.fortran", name: "Quick Real", content: "real :: "},
 "wr" => 
  {scope: "source.fortran",
   name: "Quick Write",
   content: "write(unit=${1:iounit}, fmt=*) ${0:variables}\n"},
 "rn" => 
  {scope: "source.fortran",
   name: "Random Number",
   content: "call random_number($0)"},
 "rs" => 
  {scope: "source.fortran",
   name: "Random Seed",
   content: "call random_seed(${1:size=${2:<int>}}${3:put=(/$4/)})"},
 "rea" => 
  {scope: "source.fortran",
   name: "Real",
   content: "real${1:(${2:kind})}${3:, ${4:attributes}} :: ${5:name}"},
 "size" => 
  {scope: "source.fortran",
   name: "Size",
   content: "size(${1:source}${2:, dim=${3:1}})"},
 "sum" => 
  {scope: "source.fortran",
   name: "Sum of Elements",
   content: "sum(${1:source}${2:, dim=${3:1}}${4:, mask=${5:($1>0)}})"},
 "type" => 
  {scope: "source.fortran",
   name: "Type Definition",
   content: "type ${1:type name}\n\t$0\nend type $1"},
 "ubound" => 
  {scope: "source.fortran",
   name: "Upper Bound",
   content: "ubound(${1:source}${2:, dim=${3:1}})"},
 "F" => {scope: "source.fortran", name: ".FALSE.", content: ".FALSE."},
 "T" => {scope: "source.fortran", name: ".TRUE.", content: ".TRUE."},
 "all" => 
  {scope: "source.fortran",
   name: "all",
   content: "all(${1:mask}${2:, dim=${3:1}})"},
 "any" => 
  {scope: "source.fortran",
   name: "any",
   content: "any(${1:mask}${2:, dim=${3:1}})"},
 "case" => 
  {scope: "source.fortran", name: "case", content: "case ${1:default}\n\t$0"},
 "count" => 
  {scope: "source.fortran",
   name: "count",
   content: "count(${1:mask}${2:, dim=${3:1}})"},
 "cy" => {scope: "source.fortran", name: "cycle", content: "cycle"},
 "data" => 
  {scope: "source.fortran",
   name: "data",
   content: "data ${1:variable} / ${2:data} /"},
 "dow" => 
  {scope: "source.fortran",
   name: "do while",
   content: "do while ( ${1:condition} )\n\t$0\nend do"},
 "do" => 
  {scope: "source.fortran",
   name: "do",
   content: "do${1: ${2:i} = ${3:1}, ${4:100}, ${5:1}}\n\t$0\nend do"},
 "elif" => 
  {scope: "source.fortran",
   name: "elseif",
   content: "elseif ( ${1:condition} ) then\n\t"},
 "for" => 
  {scope: "source.fortran.modern",
   name: "forall",
   content: "forall (${1:i=1:100}${2:, mask})\n\t$0\nend forall"},
 "fun" => 
  {scope: "source.fortran",
   name: "function",
   content: 
    "function ${1:name}\n\t${2:argument type}, intent(${3:inout}) :: ${1/\\w+\\((.*)\\)|.*/$1/}\n\t${4:function type} :: ${1/(\\w+).*/$1/}\n\t$0\nend function ${1/(\\w+).*/$1/}"},
 "if" => 
  {scope: "source.fortran",
   name: "if",
   content: "if ( ${1:condition} ) then\n\t$0\nend if"},
 "imp" => 
  {scope: "source.fortran", name: "implicit none", content: "implicit none\n"},
 "interf" => 
  {scope: "source.fortran",
   name: "interface",
   content: "interface ${1:name}\n\t$0\nend interface ! $1"},
 "max" => 
  {scope: "source.fortran", name: "max", content: "max($1, $2${, $3:...})$0"},
 "merge" => 
  {scope: "source.fortran",
   name: "merge",
   content: "merge(${1:source}, ${2:alternative}, mask=(${2:$1>0}))"},
 "min" => 
  {scope: "source.fortran", name: "min", content: "min($1, $2${, $3:...})$0"},
 "mp" => 
  {scope: "source.fortran",
   name: "module procedure",
   content: "module procedure ${0:name}"},
 "mod" => 
  {scope: "source.fortran",
   name: "module",
   content: "module ${1:name}\n\n\timplicit none\n\t$0\n\nend module $1\n"},
 "ndo" => 
  {scope: "source.fortran",
   name: "named: do",
   content: 
    "${1:name}: do${2: ${3:i} = ${4:1}, ${5:100}, ${6:1}}\n\t$0\nend do $1"},
 "nsel" => 
  {scope: "source.fortran",
   name: "named: select case",
   content: 
    "${1:name}: select case ($2:variable)\n\tcase ($3:values) $1\n\t\t$0\nend select $1"},
 "pack" => 
  {scope: "source.fortran",
   name: "pack",
   content: 
    "pack(${1:array}, mask=(${2:$1>0})${3:, vector=${4:destination vector}})"},
 "pr" => {scope: "source.fortran", name: "Quick Print", content: "print*, "},
 "prog" => 
  {scope: "source.fortran",
   name: "program",
   content: "program ${1:name}\n\n\timplicit none\n\t$0\n\nend program $1\n"},
 "read" => 
  {scope: "source.fortran",
   name: "Read",
   content: 
    "read(unit=${1:iounit}, fmt=\"(${2:format string})\", iostat=${3:istat}) ${4:variables}\nif ( $3 /= 0 ) stop \"Read error in file unit $1\"\n"},
 "resh" => 
  {scope: "source.fortran",
   name: "reshape",
   content: 
    "reshape(${1:source}${2:, shape=(/$3/)}${4:, pad=(/$5/)}${6:, order=(/${7:2,1}/)})"},
 "sel" => 
  {scope: "source.fortran",
   name: "select case",
   content: 
    "select case ($1:variable)\n\tcase ($2:values)\n\t\t$0\nend select"},
 "spread" => 
  {scope: "source.fortran",
   name: "spread",
   content: "spread(${1:source}, dim=${2:1}, ncopies=$3)"},
 "stop" => 
  {scope: "source.fortran", name: "stop", content: "stop \"${1:message}\""},
 "sub" => 
  {scope: "source.fortran",
   name: "subroutine",
   content: 
    "subroutine ${1:name}\n\t${2:argument type}, intent(${3:inout}) :: ${1/\\w+\\((.*)\\)|.*/$1/}\n\t$0\nend subroutine ${1/(\\w+).*/$1/}"},
 "unpack" => 
  {scope: "source.fortran",
   name: "unpack",
   content: 
    "unpack(${1:vector}, mask=(${2:$1>0}), field=${3:destination array})"},
 "wh" => 
  {scope: "source.fortran",
   name: "where (single line)",
   content: "where ( $1 ${2:==} $3 ) "},
 "whe" => 
  {scope: "source.fortran",
   name: "where",
   content: "where ( $1 ${2:==} $3 )\n\t$0\nend where"},
 "write" => 
  {scope: "source.fortran",
   name: "Write",
   content: 
    "write(unit=${1:iounit}, fmt=\"(${2:format string})\", iostat=${3:ios}${4:, advance='NO'}) ${5:variables}\nif ( $3 /= 0 ) stop \"Write error in file unit $1\"\n"}}
