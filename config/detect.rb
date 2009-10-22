# Encoding: UTF-8

module VER::Syntax::Detector
  exts "Blog (Textile)", ["blog.textile"]
  head "Blog (Textile)", /^Type: Blog Post \(Textile\)/
  exts "SQL (Rails)", ["erbsql", "sql.erb"]
  exts "ANTLR", ["g"]
  exts "AppleScript", ["applescript", "script editor"]
  head "AppleScript", /^#!.*(osascript)/
  exts "Makefile", ["GNUmakefile", "makefile", "Makefile", "OCamlMakefile"]
  exts "Blog (Text)", ["blog.txt"]
  head "Blog (Text)", /^Type: Blog Post \(Text\)/
  exts "iCalendar", ["ics", "ifb"]
  exts "Ada", ["adb", "ads"]
  exts "R", ["R", "r", "s", "S", "Rprofile"]
  exts "Erlang", ["erl", "hrl"]
  exts "Lisp", ["lisp", "cl", "l", "mud", "el"]
  exts "Io", ["io"]
  exts "JavaProperties", ["properties"]
  exts "Eiffel", ["e"]
  exts "Lua", ["lua"]
  exts "JavaScript", ["js", "htc", "jsx"]
  exts "Processing", ["pde"]
  exts "XSL", ["xsl", "xslt"]
  exts "HTML", ["html", "htm", "shtml", "xhtml", "phtml", "php", "inc", "tmpl", "tpl", "ctp"]
  head "HTML", /<!DOCTYPE|<(?i:html)|<\?(?i:php)/
  exts "Bulletin Board", ["bbcode"]
  exts "Shell-Unix-Generic", ["sh", "ss", "bashrc", "bash_profile", "bash_login", "profile", "bash_logout", ".textmate_init"]
  head "Shell-Unix-Generic", /^#!.*(bash|zsh|sh|tcsh)/
  exts "Pascal", ["pas", "p"]
  exts "ASP VB.net", ["vb"]
  exts "F-Script", ["fscript"]
  exts "C++", ["cc", "cpp", "cp", "cxx", "c++", "C", "h", "hh", "hpp", "h++"]
  head "C++", /-\*- C\+\+ -\*-/
  exts "Blog (Markdown)", ["blog.markdown", "blog.mdown", "blog.mkdn", "blog.md"]
  head "Blog (Markdown)", /^Type: Blog Post \(Markdown\)/
  exts "Bibtex", ["bib"]
  exts "OCaml", ["ml", "mli"]
  exts "Haskell", ["hs"]
  exts "XML", ["xml", "tld", "jsp", "pt", "cpt", "dtml", "rss", "opml"]
  exts "Modula-3", ["m3", "cm3"]
  exts "Quake3 Config", ["cfg"]
  exts "Dylan", ["dylan"]
  exts "ASP", ["asa"]
  exts "Mail", ["mail"]
  head "Mail", /^From: .*(?=\w+@[\w-]+\.\w+)/
  exts "Standard ML", ["sml", "sig"]
  exts "Blog (HTML)", ["blog.html"]
  head "Blog (HTML)", /^Type: Blog Post \(HTML\)/
  exts "Ini", ["ini", "conf"]
  exts "Scheme", ["scm", "sch"]
  exts "Java", ["java", "bsh"]
  exts "MEL", ["as"]
  exts "FXScript", ["fxscript"]
  exts "LaTeX", ["tex"]
  head "LaTeX", /^\\documentclass(?!.*\{beamer\})/
  exts "Vectorscript", ["vss"]
  exts "HTML (Rails)", ["rhtml", "erb", "html.erb"]
  head "LaTeX Log", /This is (pdf|pdfe)?TeXk?, Version/
  exts "YAML", ["yaml", "yml"]
  exts "Plain text", ["txt"]
  exts "Tcl", ["tcl"]
  exts "Ruby", ["rb", "rbx", "rjs", "Rakefile", "rake", "cgi", "fcgi", "gemspec", "irbrc", "capfile"]
  head "Ruby", /^#!\/.*\bruby\b/
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
  exts "Ruby on Rails", ["rxml", "builder"]
  exts "TeX", ["sty", "cls"]
  exts "HTML for ASP.net", ["aspx", "ascx"]
  exts "Inform", ["inf"]
  exts "CSS", ["css", "css.erb"]
  exts "HTML (Tcl)", ["tcl", "adp", "inc"]
  exts "DOT", ["dot", "DOT"]
  exts "Literate Haskell", ["lhs"]
  exts "reStructuredText", ["rst", "rest"]
  exts "SWIG", ["i", "swg"]
  exts "Apache", ["conf", "htaccess"]
  exts "Markdown", ["mdown", "markdown", "markdn", "md"]
  exts "Slate", ["slate"]
  exts "HTML (Mason)", ["mhtml", "autohandler", "dhandler", "md", "mc"]
  exts "Textile", ["textile"]
  head "Textile", /textile/
  exts "Objective-C++", ["mm", "M", "h"]
  exts "Logtalk", ["lgt", "config"]
  exts "ActionScript", ["as"]
  exts "Rez", ["r"]
  exts "Subversion commit message", ["svn-commit.tmp", "svn-commit.2.tmp"]
  exts "Gri", ["gri"]
  head "Gri", /-[*]-( Mode:)? Gri -[*]-/
  head "PHP", /^#!.*(?<!-)php[0-9]{0,1}\b/
  exts "Movable Type", ["mtml"]
  head "Movable Type", /<\$?[Mm][Tt]/
  exts "HTML-ASP", ["asp"]
  exts "SQL", ["sql", "ddl", "dml"]
  exts "MIPS", ["s", "mips", "spim", "asm"]
  exts "C", ["c", "h"]
  head "C", /-[*]-( Mode:)? C -[*]-/
  exts "Perl", ["pl", "pm", "pod", "t", "PL"]
  head "Perl", /^#!.*\bperl\b/
  head "LaTeX Beamer", /^\\documentclass(\[.*\])?\{beamer\}/
end
