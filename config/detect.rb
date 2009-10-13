# Encoding: UTF-8

module VER::Syntax::Detector
  exts "ANTLR", ["g"]
  exts "ASP vb.NET", ["vb"]
  exts "ASP", ["asa"]
  exts "ActionScript", ["as"]
  exts "Ada", ["adb", "ads"]
  exts "Apache", ["conf", "htaccess"]
  exts "AppleScript", ["applescript", "script editor"]
  head "AppleScript", /^#!.*(osascript)/
  exts "BibTeX", ["bib"]
  exts "Blog — HTML", ["blog.html"]
  head "Blog — HTML", /^Type: Blog Post \(HTML\)/
  exts "Blog — Markdown", ["blog.markdown", "blog.mdown", "blog.mkdn", "blog.md"]
  head "Blog — Markdown", /^Type: Blog Post \(Markdown\)/
  exts "Blog — Text", ["blog.txt"]
  head "Blog — Text", /^Type: Blog Post \(Text\)/
  exts "Blog — Textile", ["blog.textile"]
  head "Blog — Textile", /^Type: Blog Post \(Textile\)/
  exts "Bulletin Board", ["bbcode"]
  exts "C++", ["cc", "cpp", "cp", "cxx", "c++", "C", "h", "hh", "hpp", "h++"]
  head "C++", /-\*- C\+\+ -\*-/
  exts "C", ["c", "h"]
  head "C", /-[*]-( Mode:)? C -[*]-/
  exts "CSS", ["css", "css.erb"]
  exts "Graphviz (DOT)", ["dot", "DOT"]
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
  exts "Dylan", ["dylan"]
  exts "Eiffel", ["e"]
  exts "Erlang", ["erl", "hrl"]
  exts "F-Script", ["fscript"]
  exts "FXScript", ["fxscript"]
  exts "Gri", ["gri"]
  head "Gri", /-[*]-( Mode:)? Gri -[*]-/
  exts "HTML (Mason)", ["mhtml", "autohandler", "dhandler", "md", "mc"]
  exts "HTML (Rails)", ["rhtml", "erb", "html.erb"]
  exts "HTML (Tcl)", ["tcl", "adp", "inc"]
  exts "HTML (ASP.net)", ["aspx", "ascx"]
  exts "HTML (ASP)", ["asp"]
  exts "HTML", ["html", "htm", "shtml", "xhtml", "phtml", "php", "inc", "tmpl", "tpl", "ctp"]
  head "HTML", /<!DOCTYPE|<(?i:html)|<\?(?i:php)/
  exts "Haskell", ["hs"]
  exts "Inform", ["inf"]
  exts "Ini", ["ini", "conf"]
  exts "Io", ["io"]
  exts "Java", ["java", "bsh"]
  exts "Java Properties", ["properties"]
  exts "JavaScript", ["js", "htc", "jsx"]
  head "LaTeX Beamer", /^\\documentclass(\[.*\])?\{beamer\}/
  head "LaTeX Log", /This is (pdf|pdfe)?TeXk?, Version/
  exts "LaTeX", ["tex"]
  head "LaTeX", /^\\documentclass(?!.*\{beamer\})/
  exts "Lisp", ["lisp", "cl", "l", "mud", "el"]
  exts "Literate Haskell", ["lhs"]
  exts "Logtalk", ["lgt", "config"]
  exts "Lua", ["lua"]
  exts "MEL", ["as"]
  exts "MIPS Assembler", ["s", "mips", "spim", "asm"]
  exts "Mail", ["mail"]
  head "Mail", /^From: .*(?=\w+@[\w-]+\.\w+)/
  exts "Makefile", ["GNUmakefile", "makefile", "Makefile", "OCamlMakefile"]
  exts "Markdown", ["mdown", "markdown", "markdn", "md"]
  exts "Modula-3", ["m3", "cm3"]
  exts "Movable Type", ["mtml"]
  head "Movable Type", /<\$?[Mm][Tt]/
  exts "OCaml", ["ml", "mli"]
  exts "Objective-C++", ["mm", "M", "h"]
  head "PHP", /^#!.*(?<!-)php[0-9]{0,1}\b/
  exts "Pascal", ["pas", "p"]
  exts "Perl", ["pl", "pm", "pod", "t", "PL"]
  head "Perl", /^#!.*\bperl\b/
  exts "Plain Text", ["txt"]
  exts "Processing", ["pde"]
  exts "Quake Style .cfg", ["cfg"]
  exts "R", ["R", "r", "s", "S", "Rprofile"]
  exts "Rez", ["r"]
  exts "Ruby on Rails", ["rxml", "builder"]
  exts "Ruby", ["rb", "rbx", "rjs", "Rakefile", "rake", "cgi", "fcgi", "gemspec", "irbrc", "capfile"]
  head "Ruby", /^#!\/.*\bruby\b/
  exts "SQL (Rails)", ["erbsql", "sql.erb"]
  exts "SQL", ["sql", "ddl", "dml"]
  exts "SWIG", ["i", "swg"]
  exts "Scheme", ["scm", "sch"]
  exts "Shell Script (Bash)", ["sh", "ss", "bashrc", "bash_profile", "bash_login", "profile", "bash_logout", ".textmate_init"]
  head "Shell Script (Bash)", /^#!.*(bash|zsh|sh|tcsh)/
  exts "Slate", ["slate"]
  exts "Standard ML", ["sml", "sig"]
  exts "svn-commit.tmp", ["svn-commit.tmp", "svn-commit.2.tmp"]
  exts "Tcl", ["tcl"]
  exts "TeX", ["sty", "cls"]
  exts "Textile", ["textile"]
  head "Textile", /textile/
  exts "Vectorscript", ["vss"]
  exts "XML", ["xml", "tld", "jsp", "pt", "cpt", "dtml", "rss", "opml"]
  exts "XSL", ["xsl", "xslt"]
  exts "YAML", ["yaml", "yml"]
  exts "iCalendar", ["ics", "ifb"]
  exts "reStructuredText", ["rst", "rest"]
end
