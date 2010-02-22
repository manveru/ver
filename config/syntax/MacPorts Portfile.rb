# Encoding: UTF-8

{fileTypes: ["Portfile"],
 foldingStartMarker: /\{\s*$/,
 foldingStopMarker: /^\s*\}/,
 name: "MacPorts Portfile",
 patterns: 
  [{begin: /^\s*(?<_1>PortGroup)\s+ruby(?!\S)/,
    beginCaptures: {1 => {name: "keyword.other.tcl.macports"}},
    comment: "special case for ruby PortGroup",
    end: "$.^",
    patterns: 
     [{include: "$base"},
      {match: /^\s*ruby\.setup(?!\S)/, name: "keyword.other.tcl.macports"}]},
   {begin: /^\s*(?<_1>PortGroup)\s+perl5(?!\S)/,
    beginCaptures: {1 => {name: "keyword.other.tcl.macports"}},
    comment: "special case for the perl5 PortGroup",
    end: "$.^",
    patterns: 
     [{include: "$base"},
      {match: /^\s*perl5\.setup(?!\S)/, name: "keyword.other.tcl.macports"}]},
   {captures: {1 => {name: "keyword.other.tcl.macports"}},
    comment: "Base commands",
    match: /^\s*(?<_1>PortSystem|PortGroup)(?!\S)/},
   {captures: {1 => {name: "keyword.other.tcl.macports"}},
    comment: 
     "Procs defined with the `commands` keyword (ignore use_option-{delete,append} as it is useless)",
    match: 
     /^\s*(?<_1>use_(?:configure|build|automake|autoconf|xmkmf|libtool|destroot|extract|cvs|svn|patch|test)|(?:configure|build|automake|autoconf|xmkmf|libtool|destroot|extract|cvs|svn|patch|test)\.(?:dir|(?:pre_|post_)?args|env|type|cmd)(?:-(?:delete|append))?)(?!\S)/},
   {captures: {1 => {name: "keyword.other.tcl.macports"}},
    comment: "Procs defined with the `target_provides` keyword",
    match: 
     /^\s*(?<_1>(?:(?:pre|post)-)?(?:activate|build|checksum|clean|configure|destroot|distcheck|extract|fetch|install|livecheck|main|mirror|patch|pkg|mpkg|submit|test))(?!\S)/},
   {captures: {1 => {name: "keyword.other.tcl.macports"}},
    comment: "Procs defined with the `options` keyword",
    match: 
     /^\s*(?<_1>(?:build\.target|categories|checksum\.skip|checksums|configure\.(?:(?:c|cpp|cxx|objc|ld|f|f90|fc)flags|libs|classpath|perl|python|ruby|install)|cvs\.(?:date|module|password|root|tag)|default_variants|depends_(?:build|lib|run)|destroot\.(?:clean|destdir|keepdirs|target|umask|violate_mtree)|dist_subdir|distcheck\.check|distfiles|distname|distpath|epoch|extract\.(?:only|suffix)|fetch\.(?:password|type|use_epsv|user)|filesdir|gnustep\.domain|homepage|install\.(?:group|user)|libpath|livecheck\.(?:check|md5|name|distname|regex|url|version)|maintainers|(?:master|patch)_sites(?:\.mirror_subdir)?|name|os\.(?:arch|endian|platform|version)|patchfiles|platforms|portdbpath|portname|prefix|revision|sources_conf|startupitem\.(?:create|executable|init|logevents|logfile|name|pidfile|requires|restart|start|stop|type)|svn\.(?:tag|url)|test\.(?:run|target)|use_bzip2|use_zip|version|workdir|worksrcdir|xcode\.(?:build\.settings|configuration|destroot\.(?:path|settings|type)|project|target)|zope\.need_subdir|macosx_deployment_target)(?:-(?:delete|append))?)(?!\S)/},
   {captures: {1 => {name: "keyword.other.tcl.macports"}},
    match: /^\s*(?<_1>universal_variant)(?!\S)/},
   {begin: /^\s*(?<_1>(?:long_)?description)(?!\S)/,
    beginCaptures: {1 => {name: "keyword.other.tcl.macports"}},
    comment: 
     "special-case description and long_description for backslash-newline escapes and string scoping",
    contentName: "string.unquoted.tcl.macports",
    end: "[\\n;]",
    patterns: 
     [{include: "#escape"},
      {include: "#string"},
      {include: "#braces"},
      {include: "#embedded"},
      {include: "#variable"}]},
   {begin: /^(?<_1>variant)(?!\S)/,
    captures: {1 => {name: "keyword.other.variant.tcl.macports"}},
    end: "\\n",
    name: "meta.variant.tcl.macports",
    patterns: 
     [{match: /(?<=\s)(?:provides|requires|conflicts|description)(?!\S)/,
       name: "keyword.other.variant.tcl.macports"},
      {match: /(?<=\s)(?<_1>[\w-]+)/,
       name: "entity.name.function.variant.tcl.macports"},
      {include: "#string"},
      {begin: /(?<_1>\{)/,
       beginCaptures: 
        {1 => {name: "punctuation.section.variant.tcl.macports"}},
       end: "(\\})",
       endCaptures: 
        {1 => {name: "punctuation.terminator.variant.tcl.macports"}},
       patterns: [{include: "source.tcl.macports"}]}]},
   {begin: 
     /^(?<_1>platform)(?:\s+(?<_2>\S+))?(?:\s+(?<_3>\S+))?(?:\s+(?<_4>\S+))?\s+(?<_5>\{)/,
    beginCaptures: 
     {1 => {name: "keyword.other.variant.platform.tcl.macports"},
      2 => {name: "entity.name.function.variant.platform.tcl.macports"},
      5 => {name: "punctuation.section.variant.platform.tcl.macports"}},
    end: "(\\})",
    endCaptures: 
     {1 => {name: "punctuation.terminator.variant.platform.tcl.macports"}},
    name: "meta.variant.platform.tcl.macports",
    patterns: [{include: "source.tcl.macports"}]},
   {match: 
     /(?<=^|[\[{;])\s*(?<_1>adduser|addgroup|dirSize|binaryInPath|archiveTypeIsSupported|variant_isset|xinstall|system|reinplace|flock|readdir|strsed|mkstemp|mktemp|existsuser|existsgroup|nextuid|nextgid|md5|find|filemap|rpm-vercomp|rmd160|sha1|compat|umask|sudo|mkfifo|unixsocketpair|mkchannelfromfd|pipe|curl|readline|rl_history|getuid|geteuid|setuid|seteuid|name_to_uid|uid_to_name|ldelete|delete|include)\b/,
    name: "keyword.other.tcl.macports"},
   {include: "source.tcl"}],
 repository: 
  {:"bare-string" => 
    {begin: /(?:^|(?<=\s))"/,
     comment: "imported from Tcl grammar",
     end: "\"(\\S*)",
     endCaptures: {1 => {name: "invalid.illegal.tcl"}},
     patterns: [{include: "#escape"}, {include: "#variable"}]},
   braces: 
    {begin: /(?:^|(?<=\s))\{/,
     comment: "imported from Tcl grammar",
     end: "\\}(\\S*)",
     endCaptures: {1 => {name: "invalid.illegal.tcl"}},
     patterns: 
      [{match: /\\[{}\n]/, name: "constant.character.escape.tcl"},
       {include: "#inner-braces"}]},
   embedded: 
    {begin: /\[/,
     beginCaptures: {0 => {name: "punctuation.section.embedded.begin.tcl"}},
     comment: "imported from Tcl grammar",
     end: "\\]",
     endCaptures: {0 => {name: "punctuation.section.embedded.end.tcl"}},
     name: "source.tcl.embedded",
     patterns: [{include: "source.tcl.macports"}]},
   escape: 
    {comment: "imported from Tcl grammar",
     match: /\\(?<_1>\d{1,3}|x[a-fA-F0-9]+|u[a-fA-F0-9]{1,4}|.|\n)/,
     name: "constant.character.escape.tcl"},
   :"inner-braces" => 
    {begin: /\{/,
     comment: "imported from Tcl grammar",
     end: "\\}",
     patterns: 
      [{match: /\\[{}\n]/, name: "constant.character.escape.tcl"},
       {include: "#inner-braces"}]},
   string: 
    {applyEndPatternLast: 1,
     begin: /(?:^|(?<=\s))(?=")/,
     comment: "imported from Tcl grammar",
     end: "",
     name: "string.quoted.double.tcl",
     patterns: [{include: "#bare-string"}]},
   variable: 
    {captures: {1 => {name: "punctuation.definition.variable.tcl"}},
     comment: "imported from Tcl grammar",
     match: /(?<_1>\$)(?<_2>[a-zA-Z0-9_:]+(?<_3>\([^\)]+\))?|\{[^\}]*\})/,
     name: "variable.other.tcl"}},
 scopeName: "source.tcl.macports",
 uuid: "33EC56FE-2BD4-4B73-A6CD-73395F4E5E58"}
