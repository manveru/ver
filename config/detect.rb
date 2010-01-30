# Encoding: UTF-8

module VER::Syntax::Detector
  exts "ActionScript", ["as"]
  exts "Active4D Config", ["ini"]
  exts "Active4D Library", ["a4l"]
  exts "Ada", ["adb", "ads"]
  exts "Ant", ["ant.xml", "build.xml"]
  head "Ant", /<\!--\s*ant\s*-->/
  exts "ANTLR", ["g"]
  exts "Apache", ["conf", "htaccess"]
  exts "AppleScript", ["applescript", "script editor"]
  head "AppleScript", /^#!.*(osascript)/
  exts "ASP", ["asa"]
  exts "ASP vb.NET", ["vb"]
  exts "BibTeX", ["bib"]
  exts "Bison", ["y"]
  exts "Blog - HTML", ["blog.html"]
  head "Blog - HTML", /^Type: Blog Post \(HTML\)/
  exts "Blog - Markdown", ["blog.markdown", "blog.mdown", "blog.mkdn", "blog.md"]
  head "Blog - Markdown", /^Type: Blog Post \(Markdown\)/
  exts "Blog - Text", ["blog.txt"]
  head "Blog - Text", /^Type: Blog Post \(Text\)/
  exts "Blog - Textile", ["blog.textile"]
  head "Blog - Textile", /^Type: Blog Post \(Textile\)/
  exts "Bulletin Board", ["bbcode"]
  exts "C", ["c", "h"]
  head "C", /-[*]-( Mode:)? C -[*]-/
  exts "C++", ["cc", "cpp", "cp", "cxx", "c++", "C", "h", "hh", "hpp", "h++"]
  head "C++", /-\*- C\+\+ -\*-/
  head "C++ Qt", /-\*- C\+\+ -\*-/
  exts "CMake Listfile", ["CMakeLists.txt", "cmake"]
  exts "ColdFusion", ["cfm", "cfml", "cfc"]
  exts "Context Free", ["cfdg", "context free"]
  exts "CSS", ["css", "css.erb"]
  exts "CSV", ["csv"]
  exts "D", ["d", "di"]
  head "D", /^#!.*\bg?dmd\b./
  exts "Diff", ["diff", "patch"]
  head "Diff", /(?x)^
		(===\ modified\ file
		|==== \s* \/\/ .+ \s - \s .+ \s+ ====
		|Index:\ 
		|---\ [^%]
		|\*\*\*.*\d{4}\s*$
		|\d+(,\d+)* (a|d|c) \d+(,\d+)* $
		|diff\ --git\ 
		)/
  head "DokuWiki", /^\s*={2,}(.*)={2,}\s*$/
  exts "Doxygen", ["doxygen"]
  exts "Dylan", ["dylan"]
  exts "Eiffel", ["e"]
  exts "Erlang", ["erl", "hrl"]
  exts "F-Script", ["fscript"]
  exts "Fortran - Modern", ["f90", "F90", "f95", "F95", "f03", "F03", "f08", "F08"]
  head "Fortran - Modern", /(?i)-[*]- mode: f90 -[*]-/
  exts "Fortran - Punchcard", ["f", "F", "f77", "F77", "for", "FOR", "fpp", "FPP"]
  exts "FXScript", ["fxscript"]
  exts "Gettext", ["po", "potx"]
  exts "Graphviz (DOT)", ["dot", "DOT"]
  exts "Greasemonkey", ["user.js"]
  head "Greasemonkey", /\/\/ ==UserScript==/
  exts "Gri", ["gri"]
  head "Gri", /-[*]-( Mode:)? Gri -[*]-/
  exts "GTD", ["gtd"]
  exts "GTDalt", ["gtd", "gtdlog"]
  exts "Haskell", ["hs"]
  exts "HTML", ["html", "htm", "shtml", "xhtml", "phtml", "php", "inc", "tmpl", "tpl", "ctp"]
  head "HTML", /<!DOCTYPE|<(?i:html)|<\?(?i:php)/
  exts "HTML (Active4D)", ["a4d", "a4p"]
  exts "HTML (ASP)", ["asp"]
  exts "HTML (ASP.net)", ["aspx", "ascx"]
  exts "HTML (Erlang)", ["yaws"]
  exts "HTML (Mason)", ["mhtml", "autohandler", "dhandler", "md", "mc"]
  exts "HTML (Rails)", ["rhtml", "erb", "html.erb"]
  exts "HTML (Tcl)", ["tcl", "adp", "inc"]
  exts "HTML (Template Toolkit)", ["tt"]
  head "HTML (Template Toolkit)", /\[%.+?%\]/
  exts "iCalendar", ["ics", "ifb"]
  exts "Inform", ["inf"]
  exts "Ini", ["ini", "conf"]
  exts "Installer Distribution Script", ["dist"]
  exts "Io", ["io"]
  exts "Java", ["java", "bsh"]
  exts "Java Properties", ["properties"]
  exts "Java Server Page (JSP)", ["jsp"]
  exts "JavaScript", ["js", "htc", "jsx"]
  exts "JavaScript (Rails)", ["js.erb"]
  exts "JSFL", ["jsfl"]
  exts "JSON", ["json"]
  exts "Language Grammar", ["textmate"]
  head "Language Grammar", /^\{\s*scopeName = .*$/
  exts "LaTeX", ["tex"]
  head "LaTeX", /^\\documentclass(?!.*\{beamer\})/
  head "LaTeX Beamer", /^\\documentclass(\[.*\])?\{beamer\}/
  head "LaTeX Log", /This is (pdf|pdfe)?TeXk?, Version/
  head "LaTeX Memoir", /^\\documentclass(\[.*\])?\{memoir\}/
  head "LaTeX Rdaemon", /^\\documentclass(?!.*\{beamer\})/
  exts "Lex-Flex", ["l"]
  exts "LilyPond", ["ly", "lily", "ily"]
  exts "Lisp", ["lisp", "cl", "l", "mud", "el"]
  exts "Literate Haskell", ["lhs"]
  exts "Logtalk", ["lgt"]
  exts "Lua", ["lua"]
  exts "MacPorts Portfile", ["Portfile"]
  exts "Mail", ["mail"]
  head "Mail", /^From: .*(?=\w+@[\w-]+\.\w+)/
  exts "Makefile", ["GNUmakefile", "makefile", "Makefile", "OCamlMakefile"]
  exts "Man", ["man"]
  exts "Maven POM", ["pom.xml"]
  exts "Mediawiki", ["mediawiki", "wikipedia", "wiki"]
  exts "MEL", ["as"]
  exts "MIPS Assembler", ["s", "mips", "spim", "asm"]
  exts "Modula-3", ["m3", "cm3"]
  exts "MoinMoin", ["moinmoin"]
  exts "Movable Type", ["mtml"]
  head "Movable Type", /<\$?[Mm][Tt]/
  exts "Movable Type (MT only)", ["mtml"]
  head "Movable Type (MT only)", /<\$?[Mm][Tt]/
  exts "Nemerle", ["n"]
  exts "newLisp", ["lsp", "qwerty"]
  exts "Objective-C", ["m", "h"]
  exts "Objective-C++", ["mm", "M", "h"]
  exts "Objective-J", ["j", "J"]
  exts "OCaml", ["ml", "mli"]
  exts "OCamllex", ["mll"]
  exts "OCamlyacc", ["mly"]
  exts "Pascal", ["pas", "p"]
  exts "Perl", ["pl", "pm", "pod", "t", "PL"]
  head "Perl", /^#!.*\bperl\b/
  exts "Perl HTML-Template", ["tmpl"]
  head "Perl HTML-Template", /<(?i:TMPL)_.+?>/
  exts "Plain Text", ["txt"]
  exts "Postscript", ["ps", "eps"]
  head "Postscript", /^%!PS/
  exts "Processing", ["pde"]
  exts "Property List", ["plist", "dict", "tmCommand", "tmDelta", "tmDragCommand", "tmLanguage", "tmMacro", "tmPreferences", "tmSnippet", "tmTheme", "scriptSuite", "scriptTerminology", "savedSearch"]
  exts "Python", ["py", "rpy", "pyw", "cpy", "SConstruct", "Sconstruct", "sconstruct", "SConscript"]
  head "Python", /^#!\/.*\bpython\b/
  exts "qmake Project file", ["pro", "pri"]
  exts "Quake Style .cfg", ["cfg"]
  exts "R", ["R", "r", "s", "S", "Rprofile"]
  exts "R Console (Rdaemon)", ["Rcon"]
  exts "R Console (Rdaemon) Plain", ["Rcon"]
  exts "Ragel", ["rl", "ragel"]
  exts "Rd (R Documentation)", ["rd", "Rd"]
  exts "Regular Expressions (Oniguruma)", ["re"]
  exts "Regular Expressions (Python)", ["re"]
  exts "Release Notes", ["tmReleaseNotes"]
  exts "Remind", ["defs.rem", "REM*.txt", ".reminders"]
  head "Remind", /^REM*/
  exts "reStructuredText", ["rst", "rest"]
  exts "Rez", ["r"]
  exts "RJS", ["rjs"]
  exts "RSpec", ["spec.rb"]
  exts "Ruby", ["rb", "rbx", "rjs", "Rakefile", "rake", "cgi", "fcgi", "gemspec", "irbrc", "capfile"]
  head "Ruby", /^#!\/.*\bruby\b/
  exts "Ruby Haml", ["haml", "sass"]
  exts "Ruby on Rails", ["rxml", "builder"]
  exts "S5 Slide Show", ["s5"]
  exts "Scheme", ["scm", "sch"]
  exts "Scilab", ["sce", "sci", "tst", "dem"]
  exts "Setext", ["etx", "etx.txt"]
  head "Setext", /setext/
  exts "Shell Script (Bash)", ["sh", "ss", "bashrc", "bash_profile", "bash_login", "profile", "bash_logout", ".textmate_init"]
  head "Shell Script (Bash)", /^#!.*\b(bash|zsh|sh|tcsh)/
  exts "Slate", ["slate"]
  exts "SQL", ["sql", "ddl", "dml"]
  exts "SQL (Rails)", ["erbsql", "sql.erb"]
  exts "SSH Config", ["ssh_config", ".ssh/config", "sshd_config"]
  exts "Standard ML", ["sml", "sig"]
  exts "Standard ML - CM", ["cm"]
  exts "Strings File", ["strings"]
  exts "svn-commit.tmp", ["svn-commit.tmp", "svn-commit.2.tmp"]
  exts "SWeave", ["Snw", "Rnw", "snw", "rnw"]
  exts "SWIG", ["i", "swg"]
  exts "Tcl", ["tcl"]
  head "Tcl", /^#!\/.*\btclsh\b/
  exts "TeX", ["sty", "cls"]
  exts "Textile", ["textile"]
  head "Textile", /textile/
  exts "Thrift", ["thrift"]
  exts "TSV", ["tsv"]
  exts "Txt2tags", ["t2t"]
  exts "Vectorscript", ["vss"]
  exts "XML", ["xml", "tld", "jsp", "pt", "cpt", "dtml", "rss", "opml"]
  exts "XSL", ["xsl", "xslt"]
  exts "YAML", ["yaml", "yml"]
end
