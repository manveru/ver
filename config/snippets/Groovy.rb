# Encoding: UTF-8

{"as" => {scope: "source.groovy", name: "as String", content: "as String"},
 "ea" => 
  {scope: "source.groovy",
   name: "each { … }",
   content: "each {${1/(.+)/(?1: )/}${1:obj}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "to" => {scope: "source.groovy", name: "to URL", content: "toURL()"},
 ":" => 
  {scope: "source.groovy",
   name: "key: \"value\" (Hash Pair)",
   content: "${1:key}: ${2:\"${3:value}\"}"},
 "copy" => 
  {scope: "source.groovy",
   name: "copy(todir: …) { fileset(dir: …) { include … exclude }",
   content: 
    "copy(todir:\"${1:targetDir}\") {\n\tfileset(dir:\"${2:sourceDir}\") {\n\t\tinclude(name:\"${3:includeName}\")\n\t\texclude(name:\"${4:excludeName}\")\n\t}\n}"},
 "psv" => 
  {scope: "source.groovy",
   name: "private static var",
   content: 
    "private static ${1:String}${1/(.+)/(?1: )/}${2:var}${3: = ${4:null}}$0"},
 "cl" => 
  {scope: "source.groovy",
   name: "class { … }",
   content: 
    "$1${1/(.+)/(?1: )/}class ${2:${TM_FILENAME/(.*?)(\\..+)/$1/}} ${3:extends ${4:Parent} }${5:implements ${6:Interface} }{\n\n\t$0\n\n}"},
 "ast" => 
  {scope: "source.groovy",
   name: "assertTrue",
   content: 
    "assertTrue(${1/(.+)/(?1:\")/}${1:message}${1/(.+)/(?1:\", )/}${2:test})$0"},
 nil => {scope: "source.groovy", name: "same line {", content: "{\n\t$0\n}"},
 "case" => 
  {scope: "source.groovy",
   name: "case … break",
   content: "case ${1:CASE_NAME}:\n\t$2\nbreak$0"},
 "with" => 
  {scope: "source.groovy",
   name: "withStreams { … }",
   content: 
    "withStreams {${1/(.+)/(?1: )/}${1:socket}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 ".as" => 
  {scope: "source.groovy", name: "asImmutable()", content: ".asImmutable()"},
 "p" => {scope: "source.groovy", name: "print", content: "print $0"},
 "sleep" => 
  {scope: "source.groovy", name: "sleep(secs)", content: "sleep(${1:secs})"},
 "sf" => 
  {scope: "source.groovy",
   name: "shouldFail { … }",
   content: 
    "shouldFail${1/(.+)/(?1:\\()/}${1:Exception}${1/(.+)/(?1:\\))/} {\n\t$0\n}"},
 "con" => 
  {scope: "source.groovy",
   name: "constructor() { … }",
   content: 
    "${1:private}${1/(.+)/(?1: )/}${2:${TM_FILENAME/(.*?)(\\..+)/$1/}}(${3:args}) {\n\t$0\n}"},
 "replace" => 
  {scope: "source.groovy",
   name: "replaceAll(regex) { … }",
   content: 
    "replaceAll(/${1:regex}/) {${2/(.+)/(?1: )/}${2:match}${2/(.+)/(?1: ->)/}\n\t$0\n}"},
 "cv" => 
  {scope: "source.groovy",
   name: "closure = { … } ",
   content: "def ${1:closureName} = { ${2:args} ->\n\t$0\n}"},
 "fm" => 
  {scope: "source.groovy",
   name: "final method() { … }",
   content: "final ${1:void} ${2:methodName}(${3:args}) {\n\t$0\n}"},
 "eadm" => 
  {scope: "source.groovy",
   name: "eachDirMatch { … }",
   content: 
    "eachDirMatch(${1:filter}) {${2/(.+)/(?1: )/}${2:dir}${2/(.+)/(?1: ->)/}\n\t$0\n}"},
 "doc" => 
  {scope: "source.groovy", name: "Doc Block", content: "/**\n * $0\n */"},
 "asn" => 
  {scope: "source.groovy",
   name: "assertNull",
   content: 
    "assertNull(${1/(.+)/(?1:\")/}${1:message}${1/(.+)/(?1:\", )/}${2:instance})$0"},
 "eafr" => 
  {scope: "source.groovy",
   name: "eachFileRecurse { … }",
   content: 
    "eachFileRecurse {${1/(.+)/(?1: )/}${1:file}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "pv" => 
  {scope: "source.groovy",
   name: "private var",
   content: "private ${1:String}${1/(.+)/(?1: )/}${2:var}${3: = ${0:null}}"},
 "instance" => 
  {scope: "source.groovy",
   name: "instance … (Singleton)",
   content: 
    "private static ${1:${TM_FILENAME/(.*?)(\\..+)/$1/}} instance\n\nstatic $1 getInstance(${2:args}) { \n\tif (!instance) instance = new $1(${2:args})\n\treturn instance\n}"},
 "eadr" => 
  {scope: "source.groovy",
   name: "eachDirRecurse { … }",
   content: 
    "eachDirRecurse {${1/(.+)/(?1: )/}${1:dir}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "im" => {scope: "source.groovy", name: "import", content: "import "},
 "elif" => 
  {scope: "source.groovy",
   name: "elseif",
   content: "else if (${1:condition}) {\n\t$0\n}"},
 "find" => 
  {scope: "source.groovy",
   name: "find { … }",
   content: "find {${1/(.+)/(?1: )/}${1:obj}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "col" => 
  {scope: "source.groovy",
   name: "collect { … }",
   content: "collect {${1/(.+)/(?1: )/}${1:obj}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "sel" => 
  {scope: "source.groovy",
   name: "splitEachLine(separator) { … }",
   content: 
    "splitEachLine(${1:separator}) {${2/(.+)/(?1: )/}${2:obj}${2/(.+)/(?1: ->)/}\n\t$0\n}"},
 "sm" => 
  {scope: "source.groovy",
   name: "static method() { … }",
   content: 
    "static ${1:void}${1/(.+)/(?1: )/}${2:methodName}(${3:args}) {\n\t$0\n}"},
 "tc" => 
  {scope: "source.groovy",
   name: "class … extends GroovyTestCase { … }",
   content: 
    "class ${2:${TM_FILENAME/(.*?)(\\..+)/$1/}} extends GroovyTestCase {\n\n\t$0\n}"},
 "eav" => 
  {scope: "source.groovy",
   name: "eachValue { … }",
   content: 
    "eachValue {${1/(.+)/(?1: )/}${1:value}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "el" => {scope: "source.groovy", name: "else", content: "else {\n\t$0\n}"},
 "try" => 
  {scope: "source.groovy",
   name: "try … catch … finally",
   content: 
    "try {\n\t$0\n}\ncatch(${1:Exception} e) {\n\t$2\n}\nfinally {\n\t$3\n}\n\n"},
 "sfv" => 
  {scope: "source.groovy",
   name: "static final var",
   content: 
    "static final ${1:String}${1/(.+)/(?1: )/}${2:var}${3: = ${4:null}}$0"},
 "eal" => 
  {scope: "source.groovy",
   name: "eachLine { … }",
   content: 
    "eachLine {${1/(.+)/(?1: )/}${1:line}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "pa" => {scope: "source.groovy", name: "package", content: "package "},
 "fv" => 
  {scope: "source.groovy",
   name: "final var",
   content: "final ${1:String}${1/(.+)/(?1: )/}${2:var}${3: = ${4:null}}$0"},
 "ifel" => 
  {scope: "source.groovy",
   name: "if … else",
   content: "if(${1:condition}) {\n\t$2\n} else {\n\t$3\n}"},
 "sv" => 
  {scope: "source.groovy",
   name: "static var",
   content: "static ${1:String}${1/(.+)/(?1: )/}${2:var}${3: = ${0:null}}"},
 "!" => 
  {scope: "source.groovy",
   name: "assert",
   content: 
    "assert ${1:test}${2/(.+)/(?1: \\: \")/}${2:Failure message}${2/(.+)/(?1:\")/}$0"},
 "psfm" => 
  {scope: "source.groovy",
   name: "private static final method() { … }",
   content: 
    "private static final ${1:void}${1/(.+)/(?1: )/}${2:methodName}(${3:args}) {\n\t$0\n}"},
 "times" => 
  {scope: "source.groovy",
   name: "times { … }",
   content: "times {${1/(.+)/(?1: )/}${1:i}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "m" => 
  {scope: "source.groovy",
   name: "method() { … }",
   content: "${1:def} ${2:methodName}(${3:args}) {\n\t$0\n}"},
 "pfv" => 
  {scope: "source.groovy",
   name: "private final var",
   content: 
    "private final ${1:String}${1/(.+)/(?1: )/}${2:var}${3: = ${4:null}}$0"},
 "psfv" => 
  {scope: "source.groovy",
   name: "private static final var",
   content: 
    "private static final ${1:String}${1/(.+)/(?1: )/}${2:var}${3: = ${4:null}}$0"},
 "while" => 
  {scope: "source.groovy",
   name: "while() { … }",
   content: "while(${1:condition}) {\n\t$0\n}"},
 "all" => 
  {scope: "source.groovy",
   name: "all { … }",
   content: "all {${1/(.+)/(?1: )/}${1:obj}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "ase" => 
  {scope: "source.groovy",
   name: "assertEquals",
   content: 
    "assertEquals(${1/(.+)/(?1:\")/}${1:message}${1/(.+)/(?1:\", )/}${2:expected}, ${3:actual})$0"},
 "step" => 
  {scope: "source.groovy",
   name: "step(to,amount) { … }",
   content: 
    "step(${1:to}, ${2:amount}) {${3/(.+)/(?1: )/}${3:i}${3/(.+)/(?1: ->)/}\n\t$0\n}"},
 "rea" => 
  {scope: "source.groovy",
   name: "reverseEach { … } ",
   content: 
    "reverseEach {${1/(.+)/(?1: )/}${1:obj}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "asnn" => 
  {scope: "source.groovy",
   name: "assertNotNull",
   content: 
    "assertNotNull(${1/(.+)/(?1:\")/}${1:message}${1/(.+)/(?1:\", )/}${2:instance})$0"},
 "if" => 
  {scope: "source.groovy",
   name: "if",
   content: "if (${1:condition}) {\n\t$0\n}"},
 "switch" => 
  {scope: "source.groovy",
   name: "switch … case … default",
   content: 
    "switch(${1:value}) {\n\tcase ${3:CASE}:\n\t\t$4\n\tbreak$0\n\tdefault:\n\t\t$2\n\tbreak\n}"},
 "any" => 
  {scope: "source.groovy",
   name: "any { … }",
   content: "any {${1/(.+)/(?1: )/}${1:obj}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "asne" => 
  {scope: "source.groovy",
   name: "assertNotEquals",
   content: 
    "assertNotEquals(${1/(.+)/(?1:\")/}${1:message}${1/(.+)/(?1:\", )/}${2:unexpected}, ${3:actual})$0"},
 "mkdir" => 
  {scope: "source.groovy",
   name: "mkdir(dir: …)",
   content: "mkdir(dir:\"${1:dirName}\")"},
 "eam" => 
  {scope: "source.groovy",
   name: "eachMatch(regex) { … } ",
   content: 
    "eachMatch(/${1:regex}/) {${2/(.+)/(?1: )/}${2:match}${2/(.+)/(?1: ->)/}\n\t$0\n}"},
 "asf" => 
  {scope: "source.groovy",
   name: "assertFalse",
   content: 
    "assertFalse(${1/(.+)/(?1:\")/}${1:message}${1/(.+)/(?1:\", )/}${2:test})$0"},
 "grep" => 
  {scope: "source.groovy",
   name: "grep(filter) { … }",
   content: 
    "grep(${1:filter}) {${2/(.+)/(?1: )/}${2:obj}${2/(.+)/(?1: ->)/}\n\t$0\n}"},
 "pl" => {scope: "source.groovy", name: "println ", content: "println $0"},
 "eak" => 
  {scope: "source.groovy",
   name: "eachKey { … }",
   content: "eachKey {${1/(.+)/(?1: )/}${1:key}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "tear" => 
  {scope: "source.groovy",
   name: "tearDown() { … }",
   content: "void tearDown() {\n\t$0\n}"},
 "setup" => 
  {scope: "source.groovy",
   name: "setUp() { … }",
   content: "void setUp() {\n\t$0\n}"},
 "pfm" => 
  {scope: "source.groovy",
   name: "private final method() { … }",
   content: "final ${1:def} ${2:methodName}(${3:args}) {\n\t$0\n}"},
 "eawi" => 
  {scope: "source.groovy",
   name: "eachWithIndex { … }",
   content: "eachWithIndex { ${1:obj}, ${2:i} ->\n\t$0 \n}"},
 "File" => 
  {scope: "source.groovy",
   name: "new File(…).eachLine { … }",
   content: 
    "new File(${1:\"${2:path/to/file}\"}).eachLine {${3/(.+)/(?1: )/}${3:line}${3/(.+)/(?1: ->)/}\n\t$0\n}"},
 "thread" => 
  {scope: "source.groovy",
   name: "Thread.start { … }",
   content: "Thread.start {\n\t$0\n}"},
 "dt" => 
  {scope: "source.groovy",
   name: "downto() { … }",
   content: 
    "downto(${1:0}) {${2/(.+)/(?1: )/}${2:i}${2/(.+)/(?1: ->)/}\n\t$0\n}"},
 "finda" => 
  {scope: "source.groovy",
   name: "findAll { … }",
   content: "findAll {${1/(.+)/(?1: )/}${1:obj}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "sort" => 
  {scope: "source.groovy", name: "sort { … }", content: "sort { \n\t$0\n}"},
 "sfm" => 
  {scope: "source.groovy",
   name: "static final method() { … }",
   content: 
    "static final ${1:void}${1/(.+)/(?1: )/}${2:methodName}(${3:args}) {\n\t$0\n}"},
 "ut" => 
  {scope: "source.groovy",
   name: "upto() { … }",
   content: 
    "upto(${1:0}) {${2/(.+)/(?1: )/}${2:i}${2/(.+)/(?1: ->)/}\n\t$0\n}"},
 "psm" => 
  {scope: "source.groovy",
   name: "private static method() { … }",
   content: 
    "private static ${1:void}${1/(.+)/(?1: )/}${2:methodName}(${3:args}) {\n\t$0\n}"},
 "ead" => 
  {scope: "source.groovy",
   name: "eachDir { … } ",
   content: "eachDir {${1/(.+)/(?1: )/}${1:dir}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "eab" => 
  {scope: "source.groovy",
   name: "eachByte { … }",
   content: 
    "eachByte {${1/(.+)/(?1: )/}${1:byte}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "forin" => 
  {scope: "source.groovy",
   name: "for(… in …) { … }",
   content: "for(${1:element} in ${2:collection}) {\n\t$0\n}"},
 "main" => 
  {scope: "source.groovy",
   name: "static main() { … }",
   content: "static main(args) {\n\t$0\n}"},
 "ass" => 
  {scope: "source.groovy",
   name: "assertSame",
   content: 
    "assertSame(${1/(.+)/(?1:\")/}${1:message}${1/(.+)/(?1:\", )/}${2:expected}, ${3:actual})$0"},
 "#!" => 
  {scope: "source.groovy",
   name: "#!/usr/bin/env groovy -w",
   content: "#!/usr/bin/env groovy -w\n\n"},
 "pm" => 
  {scope: "source.groovy",
   name: "private method() { … }",
   content: 
    "private ${1:void}${1/(.+)/(?1: )/}${2:methodName}(${3:args}) {\n\t$0\n}"},
 "eao" => 
  {scope: "source.groovy",
   name: "eachObject { … }",
   content: 
    "eachObject {${1/(.+)/(?1: )/}${1:obj}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "every" => 
  {scope: "source.groovy",
   name: "every { … }",
   content: "every {${1/(.+)/(?1: )/}${1:obj}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "eafm" => 
  {scope: "source.groovy",
   name: "eachFileMatch { … } ",
   content: 
    "eachFileMatch(${1:filter}) {${2/(.+)/(?1: )/}${2:file}${2/(.+)/(?1: ->)/}\n\t$0\n}"},
 "eaf" => 
  {scope: "source.groovy",
   name: "eachFile { … }",
   content: 
    "eachFile {${1/(.+)/(?1: )/}${1:file}${1/(.+)/(?1: ->)/}\n\t$0\n}"},
 "t" => 
  {scope: "source.groovy",
   name: "test()",
   content: "void test$1() {\n\t$0\n}"},
 "runa" => 
  {scope: "source.groovy",
   name: "runAfter() { … }",
   content: "runAfter(${1:delay}) {\n\t$0\n}"},
 "v" => 
  {scope: "source.groovy",
   name: "var",
   content: "${1:def} ${2:var}${3: = ${0:null}}"}}
