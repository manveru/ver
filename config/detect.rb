# Encoding: UTF-8

module VER::Syntax::Detector
  exts "ANTLR", ["g"]
  exts "ASP vb.NET", ["vb"]
  exts "ASP", ["asa"]
  exts "ActionScript", ["as"]
  exts "Active4D Config", ["ini"]
  exts "Active4D Library", ["a4l"]
  exts "Ada", ["adb", "ads"]
  exts "Ant", ["ant.xml", "build.xml"]
  head "Ant", /<\!--\s*ant\s*-->/
  exts "Apache", ["conf", "htaccess"]
  exts "AppleScript", ["applescript", "script editor"]
  head "AppleScript", /^#!.*(osascript)/
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
  exts "C++", ["cc", "cpp", "cp", "cxx", "c++", "C", "h", "hh", "hpp", "h++"]
  head "C++", /-\*- C\+\+ -\*-/
  exts "C", ["c", "h"]
  head "C", /-[*]-( Mode:)? C -[*]-/
  exts "CMake Listfile", ["CMakeLists.txt", "cmake"]
  exts "CSS", ["css", "css.erb"]
  exts "CSV", ["csv"]
  exts "ColdFusion", ["cfm", "cfml", "cfc"]
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
  exts "FXScript", ["fxscript"]
  exts "Fortran - Modern", ["f90", "F90", "f95", "F95", "f03", "F03", "f08", "F08"]
  head "Fortran - Modern", /(?i)-[*]- mode: f90 -[*]-/
  exts "Fortran - Punchcard", ["f", "F", "f77", "F77", "for", "FOR", "fpp", "FPP"]
  exts "GTD", ["gtd"]
  exts "GTDalt", ["gtd", "gtdlog"]
  exts "Gettext", ["po", "potx"]
  exts "Go", ["go"]
  exts "Graphviz (DOT)", ["dot", "DOT"]
  exts "Greasemonkey", ["user.js"]
  head "Greasemonkey", /\/\/ ==UserScript==/
  exts "Gri", ["gri"]
  head "Gri", /-[*]-( Mode:)? Gri -[*]-/
  exts "HTML (ASP)", ["asp"]
  exts "HTML (ASP.net)", ["aspx", "ascx"]
  exts "HTML (Active4D)", ["a4d", "a4p"]
  exts "HTML (Erlang)", ["yaws"]
  exts "HTML (Tcl)", ["tcl", "adp", "inc"]
  exts "HTML", ["html", "htm", "shtml", "xhtml", "phtml", "php", "inc", "tmpl", "tpl", "ctp"]
  head "HTML", /<!DOCTYPE|<(?i:html)|<\?(?i:php)/
  exts "Haskell", ["hs"]
  exts "Inform", ["inf"]
  exts "Ini", ["ini", "conf"]
  exts "Installer Distribution Script", ["dist"]
  exts "Io", ["io"]
  exts "JSON", ["json"]
  exts "Java Properties", ["properties"]
  exts "Java Server Page (JSP)", ["jsp"]
  exts "Java", ["java", "bsh"]
  exts "JavaScript", ["js", "htc", "jsx"]
  head "LaTeX Beamer", /^\\documentclass(\[.*\])?\{beamer\}/
  head "LaTeX Log", /This is (pdf|pdfe)?TeXk?, Version/
  head "LaTeX Memoir", /^\\documentclass(\[.*\])?\{memoir\}/
  exts "LaTeX", ["tex"]
  head "LaTeX", /^\\documentclass(?!.*\{beamer\})/
  exts "Lex-Flex", ["l"]
  exts "LilyPond", ["ly", "lily", "ily"]
  exts "Lisp", ["lisp", "cl", "l", "mud", "el"]
  exts "Literate Haskell", ["lhs"]
  exts "Logtalk", ["lgt", "config"]
  exts "Lua", ["lua"]
  exts "MEL", ["as"]
  exts "MIPS Assembler", ["s", "mips", "spim", "asm"]
  exts "MacPorts Portfile", ["Portfile"]
  exts "Mail", ["mail"]
  head "Mail", /^From: .*(?=\w+@[\w-]+\.\w+)/
  exts "Makefile", ["GNUmakefile", "makefile", "Makefile", "OCamlMakefile"]
  exts "Markdown", ["mdown", "markdown", "markdn", "md"]
  exts "Maven POM", ["pom.xml"]
  exts "Mediawiki", ["mediawiki", "wikipedia", "wiki"]
  exts "Modula-3", ["m3", "cm3"]
  exts "MoinMoin", ["moinmoin"]
  head "MultiMarkdown", /^Format:\s*(?i:complete)\s*$/
  exts "Nemerle", ["n"]
  exts "OCaml", ["ml", "mli"]
  exts "OCamllex", ["mll"]
  exts "OCamlyacc", ["mly"]
  exts "Objective-C++", ["mm", "M", "h"]
  exts "Objective-C", ["m", "h"]
  head "PHP", /^#!.*(?<!-)php[0-9]{0,1}\b/
  exts "Pascal", ["pas", "p"]
  exts "Perl", ["pl", "pm", "pod", "t", "PL"]
  head "Perl", /^#!.*\bperl\b/
  exts "Plain Text", ["txt"]
  exts "PmWiki", ["pmwiki"]
  exts "Postscript", ["ps", "eps"]
  head "Postscript", /^%!PS/
  exts "Processing", ["pde"]
  exts "Python", ["py", "rpy", "pyw", "cpy", "SConstruct", "Sconstruct", "sconstruct", "SConscript"]
  head "Python", /^#!\/.*\bpython\b/
  exts "Quake Style .cfg", ["cfg"]
  exts "R", ["R", "r", "s", "S", "Rprofile"]
  exts "Ragel", ["rl", "ragel"]
  exts "Rd (R Documentation)", ["rd", "Rd"]
  exts "Regular Expressions (Oniguruma)", ["re"]
  exts "Regular Expressions (Python)", ["re"]
  exts "Release Notes", ["tmReleaseNotes"]
  exts "Remind", ["defs.rem", "REM*.txt", ".reminders"]
  head "Remind", /^REM*/
  exts "Rez", ["r"]
  exts "Ruby", ["rb", "rbx", "rjs", "Rakefile", "rake", "cgi", "fcgi", "gemspec", "irbrc", "capfile"]
  head "Ruby", /^#!\/.*\bruby\b/
  exts "S5 Slide Show", ["s5"]
  exts "SQL", ["sql", "ddl", "dml"]
  exts "SSH Config", ["ssh_config", ".ssh/config", "sshd_config"]
  exts "SWIG", ["i", "swg"]
  exts "SWeave", ["Snw", "Rnw", "snw", "rnw"]
  exts "Scheme", ["scm", "sch"]
  exts "Scilab", ["sce", "sci", "tst", "dem"]
  exts "Setext", ["etx", "etx.txt"]
  head "Setext", /setext/
  exts "Shell Script (Bash)", ["sh", "ss", "bashrc", "bash_profile", "bash_login", "profile", "bash_logout", ".textmate_init"]
  head "Shell Script (Bash)", /^#!.*(bash|zsh|sh|tcsh)/
  exts "Slate", ["slate"]
  exts "Strings File", ["strings"]
  exts "TSV", ["tsv"]
  exts "Tcl", ["tcl"]
  exts "TeX", ["sty", "cls"]
  exts "Textile", ["textile"]
  head "Textile", /textile/
  exts "Thrift", ["thrift"]
  exts "Txt2tags", ["t2t"]
  exts "Vectorscript", ["vss"]
  exts "XML", ["xml", "tld", "jsp", "pt", "cpt", "dtml", "rss", "opml"]
  exts "XSL", ["xsl", "xslt"]
  exts "YAML", ["yaml", "yml"]
  exts "iCalendar", ["ics", "ifb"]
  exts "reStructuredText", ["rst", "rest"]
  exts "svn-commit.tmp", ["svn-commit.tmp", "svn-commit.2.tmp"]
end
