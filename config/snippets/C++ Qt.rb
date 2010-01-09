# Encoding: UTF-8

{nil => 
  {scope: "source.c++.qt comment.block.c",
   name: "Block Comment Newline",
   content: "\n* "},
 "/*" => 
  {scope: "source.c++.qt", name: "Block Comment", content: "/*\n * $0\n */"},
 "singleShot" => 
  {scope: "source.c++.qt",
   name: "QTimer::singleShot(...)",
   content: "QTimer::singleShot(${1:0}, ${2:this}, SLOT(${3:slotName()}))"},
 "qp" => 
  {scope: "source.c++.qt",
   name: "Q_PROPERTY",
   content: 
    "Q_PROPERTY( ${1:type} ${2:name} READ ${3:$2} ${4:WRITE ${5:${2/.*/set\\u$0/}} ${6:RESET ${7:${2/.*/reset\\u$0/}} DESIGNABLE ${8:true} SCRIPTABLE ${9:true} STORED ${10:true} }})$0"},
 "con" => 
  {scope: "source.c++.qt",
   name: "connect",
   content: 
    "connect( ${1:sender}, SIGNAL(${2:signal}(${3})), ${4:reciever}, ${5:SLOT}(${6:slot}($3)) );$0"},
 "dis" => 
  {scope: "source.c++.qt",
   name: "disconnect",
   content: 
    "disconnect( ${1:sender}, SIGNAL(${2:signal}(${3})), ${4:reciever}, ${5:SLOT}(${6:slot}($3)) );$0"},
 "fe" => 
  {scope: "source.c++.qt",
   name: "foreach",
   content: 
    "foreach( ${1:variable}, ${2:container} )\n{\n\t${3:doSomething();} \n}$0"},
 "qmain" => 
  {scope: "source.c++.qt",
   name: "main()",
   content: 
    "#include <QApplication>\n\nint main (int argc, char *argv[])\n{\n\tQApplication app(argc, argv);\n\t$0\n\treturn app.exec();\n}"},
 "qSort" => 
  {scope: "source.c++.qt",
   name: "qSort(...)",
   content: "qSort(${1:list}.begin(), ${1}.end())"},
 "warn" => 
  {scope: "source.c++.qt",
   name: "qWarning(...)",
   content: 
    "qWarning(\"$1\"${1/[^%]*(%)?.*/(?1:, :\\);)/}$2${1/[^%]*(%)?.*/(?1:\\);)/}"},
 "stub" => 
  {scope: "source.qmake",
   name: "qmake Project template stub",
   content: 
    "TEMPLATE = app\nCONFIG += qt\nQT += gui\nSOURCES += ${1:main.cpp}\n\nwindows {\n\t# otherwise we would get 'unresolved external _WinMainCRTStartup'\n\t# when compiling with MSVC\n\tMOC_DIR     = _moc\n\tOBJECTS_DIR = _obj\n\tUI_DIR      = _ui\n\tRCC_DIR     = _rcc\n}\n!windows {\n\tMOC_DIR     = .moc\n\tOBJECTS_DIR = .obj\n\tUI_DIR      = .ui\n\tRCC_DIR     = .rcc\n}\n\n$0"},
 "latin" => 
  {scope: "source.c++.qt",
   name: "toLatin1().data()",
   content: "toLatin1().data()"},
 "utf8" => 
  {scope: "source.c++.qt",
   name: "toUtf8().data()",
   content: "toUtf8().data()"}}
