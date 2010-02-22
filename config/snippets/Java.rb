# Encoding: UTF-8

{"th" => {scope: "source.java", name: "throw", content: "throw $0"},
 "cs" => {scope: "source.java", name: "case", content: "case $1:\n\t$2\n$0"},
 "p" => 
  {scope: "source.java", name: "print", content: "System.out.print($1);$0"},
 "br" => {scope: "source.java", name: "break", content: "break;\n"},
 "pu" => {scope: "source.java", name: "public", content: "public "},
 "in" => 
  {scope: "source.java",
   name: "interface",
   content: 
    "interface ${1:${TM_FILENAME/(.*?)(\\..+)/$1/}} ${2:extends ${3:Parent} }{\n\t$0\n}"},
 "j.i" => {scope: "source.java", name: "java.io.", content: "java.io."},
 "de" => {scope: "source.java", name: "default", content: "default:\n\t$0"},
 "j.m" => {scope: "source.java", name: "java.math.", content: "java.math."},
 "re" => {scope: "source.java", name: "return", content: "return "},
 "im" => {scope: "source.java", name: "import", content: "import "},
 "fi" => {scope: "source.java", name: "final", content: "final "},
 "cl" => 
  {scope: "source.java",
   name: "class",
   content: 
    "class ${1:${TM_FILENAME/(.*?)(\\..+)/$1/}} ${2:extends ${3:Parent} }${4:implements ${5:Interface} }{\n\t$0\n}"},
 "el" => {scope: "source.java", name: "else", content: "else {\n\t$0\n}"},
 "pa" => {scope: "source.java", name: "package", content: "package "},
 "elif" => 
  {scope: "source.java", name: "else if", content: "else if ($1) {\n\t$0\n}"},
 "st" => {scope: "source.java", name: "static", content: "static "},
 "j.n" => {scope: "source.java", name: "java.net.", content: "java.net."},
 "t" => 
  {scope: "source.java",
   name: "test",
   content: "public void test${1:Name}() throws Exception {\n\t$0\n}"},
 "pr" => {scope: "source.java", name: "private", content: "private "},
 "imt" => 
  {scope: "source.java",
   name: "import junit.framework.TestCase;",
   content: "import junit.framework.TestCase;\n$0"},
 "cos" => 
  {scope: "source.java",
   name: "constant string",
   content: "static public final String ${1:var} = \"$2\";$0"},
 "if" => {scope: "source.java", name: "if", content: "if ($1) {\n\t$0\n}"},
 "ab" => {scope: "source.java", name: "abstract", content: "abstract "},
 "ca" => 
  {scope: "source.java",
   name: "catch",
   content: "catch (${1:Exception} ${2:e}) {\n\t$0\n}"},
 "po" => {scope: "source.java", name: "protected", content: "protected "},
 "pl" => 
  {scope: "source.java",
   name: "println",
   content: "System.out.println($1);$0"},
 "j.u" => {scope: "source.java", name: "java.util.", content: "java.util."},
 "as" => 
  {scope: "source.java",
   name: "assert",
   content: 
    "assert ${1:test}${2/(.+)/(?1: \\: \")/}${2:Failure message}${2/(.+)/(?1:\")/};$0"},
 "for" => 
  {scope: "source.java", name: "for", content: "for ($1; $2; $3) {\n\t$0\n}"},
 "j.b" => {scope: "source.java", name: "java.beans.", content: "java.beans."},
 "main" => 
  {scope: "source.java",
   name: "method (main)",
   content: "public static void main(String[] args) {\n\t$0\n}"},
 "m" => 
  {scope: "source.java",
   name: "method",
   content: "${1:void} ${2:method}($3) ${4:throws $5 }{\n\t$0\n}\n"},
 "co" => 
  {scope: "source.java",
   name: "constant",
   content: "static public final ${1:String} ${2:var} = $3;$0"},
 "sw" => 
  {scope: "source.java", name: "switch", content: "switch ($1) {\n\t$0\n}"},
 "fore" => 
  {scope: "source.java",
   name: "for (each)",
   content: "for ($1 : $2) {\n\t$0\n}"},
 "wh" => 
  {scope: "source.java", name: "while", content: "while ($1) {\n\t$0\n}"},
 "sy" => 
  {scope: "source.java", name: "synchronized", content: "synchronized "},
 "v" => 
  {scope: "source.java",
   name: "variable",
   content: "${1:String} ${2:var}${3: = ${0:null}};"},
 "tc" => 
  {scope: "source.java",
   name: "test case",
   content: 
    "public class ${1:${TM_FILENAME/(.*?)(\\..+)/$1/}} extends ${2:TestCase} {\n\t$0\n}"}}
