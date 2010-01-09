# Encoding: UTF-8

{"ab" => {scope: "source.java", name: "abstract", content: "abstract "},
 "as" => 
  {scope: "source.java",
   name: "assert",
   content: 
    "assert ${1:test}${2/(.+)/(?1: \\: \")/}${2:Failure message}${2/(.+)/(?1:\")/};$0"},
 "br" => {scope: "source.java", name: "break", content: "break;\n"},
 "cs" => {scope: "source.java", name: "case", content: "case $1:\n\t$2\n$0"},
 "ca" => 
  {scope: "source.java",
   name: "catch",
   content: "catch (${1:Exception} ${2:e}) {\n\t$0\n}"},
 "cl" => 
  {scope: "source.java",
   name: "class",
   content: 
    "class ${1:${TM_FILENAME/(.*?)(\\..+)/$1/}} ${2:extends ${3:Parent} }${4:implements ${5:Interface} }{\n\t$0\n}"},
 "cos" => 
  {scope: "source.java",
   name: "constant string",
   content: "static public final String ${1:var} = \"$2\";$0"},
 "co" => 
  {scope: "source.java",
   name: "constant",
   content: "static public final ${1:String} ${2:var} = $3;$0"},
 "de" => {scope: "source.java", name: "default", content: "default:\n\t$0"},
 "elif" => 
  {scope: "source.java", name: "else if", content: "else if ($1) {\n\t$0\n}"},
 "el" => {scope: "source.java", name: "else", content: "else {\n\t$0\n}"},
 "fi" => {scope: "source.java", name: "final", content: "final "},
 "fore" => 
  {scope: "source.java",
   name: "for (each)",
   content: "for ($1 : $2) {\n\t$0\n}"},
 "for" => 
  {scope: "source.java", name: "for", content: "for ($1; $2; $3) {\n\t$0\n}"},
 "if" => {scope: "source.java", name: "if", content: "if ($1) {\n\t$0\n}"},
 "imt" => 
  {scope: "source.java",
   name: "import junit.framework.TestCase;",
   content: "import junit.framework.TestCase;\n$0"},
 "im" => {scope: "source.java", name: "import", content: "import "},
 "in" => 
  {scope: "source.java",
   name: "interface",
   content: 
    "interface ${1:${TM_FILENAME/(.*?)(\\..+)/$1/}} ${2:extends ${3:Parent} }{\n\t$0\n}"},
 "j.b" => {scope: "source.java", name: "java.beans.", content: "java.beans."},
 "j.i" => {scope: "source.java", name: "java.io.", content: "java.io."},
 "j.m" => {scope: "source.java", name: "java.math.", content: "java.math."},
 "j.n" => {scope: "source.java", name: "java.net.", content: "java.net."},
 "j.u" => {scope: "source.java", name: "java.util.", content: "java.util."},
 "main" => 
  {scope: "source.java",
   name: "method (main)",
   content: "public static void main(String[] args) {\n\t$0\n}"},
 "m" => 
  {scope: "source.java",
   name: "method",
   content: "${1:void} ${2:method}($3) ${4:throws $5 }{\n\t$0\n}\n"},
 "pa" => {scope: "source.java", name: "package", content: "package "},
 "p" => 
  {scope: "source.java", name: "print", content: "System.out.print($1);$0"},
 "pl" => 
  {scope: "source.java",
   name: "println",
   content: "System.out.println($1);$0"},
 "pr" => {scope: "source.java", name: "private", content: "private "},
 "po" => {scope: "source.java", name: "protected", content: "protected "},
 "pu" => {scope: "source.java", name: "public", content: "public "},
 "re" => {scope: "source.java", name: "return", content: "return "},
 "st" => {scope: "source.java", name: "static", content: "static "},
 "sw" => 
  {scope: "source.java", name: "switch", content: "switch ($1) {\n\t$0\n}"},
 "sy" => 
  {scope: "source.java", name: "synchronized", content: "synchronized "},
 "tc" => 
  {scope: "source.java",
   name: "test case",
   content: 
    "public class ${1:${TM_FILENAME/(.*?)(\\..+)/$1/}} extends ${2:TestCase} {\n\t$0\n}"},
 "t" => 
  {scope: "source.java",
   name: "test",
   content: "public void test${1:Name}() throws Exception {\n\t$0\n}"},
 "th" => {scope: "source.java", name: "throw", content: "throw $0"},
 "v" => 
  {scope: "source.java",
   name: "variable",
   content: "${1:String} ${2:var}${3: = ${0:null}};"},
 "wh" => 
  {scope: "source.java", name: "while", content: "while ($1) {\n\t$0\n}"}}
