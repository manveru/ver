# Encoding: UTF-8

{fileTypes: ["conf", "htaccess"],
 foldingStartMarker: 
  /^[ ]*(?x)
	(?<_1><(?i:FilesMatch|Files|DirectoryMatch|Directory|LocationMatch|Location|VirtualHost|IfModule|IfDefine)\b.*?>
	)/,
 foldingStopMarker: 
  /^[ ]*(?x)
	(?<_1><\/(?i:FilesMatch|Files|DirectoryMatch|Directory|LocationMatch|Location|VirtualHost|IfModule|IfDefine)>
	)/,
 keyEquivalent: "^~A",
 name: "Apache",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.comment.apache-config"}},
    match: /(?<_1>#).*$\n?/,
    name: "comment.line.number-sign.apache-config"},
   {captures: 
     {1 => {name: "punctuation.definition.tag.apache-config"},
      2 => {name: "entity.name.tag.apache-config"},
      3 => {name: "punctuation.definition.tag.apache-config"},
      4 => {name: "meta.scope.between-tag-pair.apache-config"},
      5 => {name: "entity.name.tag.apache-config"},
      6 => {name: "punctuation.definition.tag.apache-config"}},
    match: 
     /^[ ]*(?<_1><)(?<_2>[a-zA-Z0-9:]+)[^>]*(?<_3>>(?<_4><)\/)(?<_5>\k<_2>)(?<_6>>)/,
    name: "meta.tag.any.html"},
   {begin: 
     /^[ ]*(?<_1>(?<_2><)(?<_3>VirtualHost)(?:[ ]+(?<_4>[^>]+))?(?<_5>>))/,
    beginCaptures: 
     {1 => {name: "meta.tag.apache-config"},
      2 => {name: "punctuation.definition.tag.apache-config"},
      3 => {name: "entity.name.tag.apache-config"},
      4 => {name: "meta.toc-list.virtual-host.apache-config"},
      5 => {name: "punctuation.definition.tag.apache-config"}},
    end: "^[ ]*((</)(VirtualHost)[^>]*(>))",
    endCaptures: 
     {1 => {name: "meta.tag.apache-config"},
      2 => {name: "punctuation.definition.tag.apache-config"},
      3 => {name: "entity.name.tag.apache-config"},
      4 => {name: "punctuation.definition.tag.apache-config"}},
    name: "meta.vhost.apache-config",
    patterns: [{include: "$base"}]},
   {begin: 
     /^[ ]*(?<_1>(?<_2><)(?<_3>Directory(?:Match)?)(?:[ ]+(?<_4>[^>]+))?(?<_5>>))/,
    beginCaptures: 
     {1 => {name: "meta.tag.apache-config"},
      2 => {name: "punctuation.definition.tag.apache-config"},
      3 => {name: "entity.name.tag.apache-config"},
      4 => {name: "meta.toc-list.directory.apache-config"},
      5 => {name: "punctuation.definition.tag.apache-config"}},
    end: "^[ ]*((</)(Directory(?:Match)?)[^>]*(>))",
    endCaptures: 
     {1 => {name: "meta.tag.apache-config"},
      2 => {name: "punctuation.definition.tag.apache-config"},
      3 => {name: "entity.name.tag.apache-config"},
      4 => {name: "punctuation.definition.tag.apache-config"}},
    name: "meta.directory.apache-config",
    patterns: [{include: "$base"}]},
   {begin: 
     /^[ ]*(?<_1>(?<_2><)(?<_3>Location(?:Match)?)(?:[ ]+(?<_4>[^>]+))?(?<_5>>))/,
    beginCaptures: 
     {1 => {name: "meta.tag.apache-config"},
      2 => {name: "punctuation.definition.tag.apache-config"},
      3 => {name: "entity.name.tag.apache-config"},
      4 => {name: "meta.toc-list.location.apache-config"},
      5 => {name: "punctuation.definition.tag.apache-config"}},
    end: "^[ ]*((</)(Location(?:Match)?)[^>]*(>))",
    endCaptures: 
     {1 => {name: "meta.tag.apache-config"},
      2 => {name: "punctuation.definition.tag.apache-config"},
      3 => {name: "entity.name.tag.apache-config"},
      4 => {name: "punctuation.definition.tag.apache-config"}},
    name: "meta.location.apache-config",
    patterns: [{include: "$base"}]},
   {begin: /(?<_1>^Include)/,
    beginCaptures: 
     {1 => {name: "support.constant.include.start.apache-config"}},
    end: "(\\n)",
    endCaptures: {1 => {name: "support.constant.include.end.apache-config"}},
    name: "source.include.apache-config",
    patterns: [{match: /(?<_1>.*)/, name: "text.include.apache-config"}]},
   {begin: /^[ ]*\b(?<_1>RewriteCond)\b/,
    captures: {1 => {name: "support.constant.rewritecond.apache-config"}},
    end: "$",
    patterns: 
     [{begin: /[ ]+/,
       end: "$",
       patterns: 
        [{include: "#vars"},
         {match: /[^ %\n]+/, name: "string.regexp.rewrite-test.apache-config"},
         {begin: /[ ]+/,
          end: "$",
          patterns: 
           [{match: /[^ %\n]+/,
             name: "string.other.rewrite-condition.apache-config"},
            {captures: 
              {1 => {name: "string.regexp.rewrite-operator.apache-config"}},
             match: /[ ]+(?<_1>\[[^\]]+\])/}]}]}]},
   {begin: /^[ ]*\b(?<_1>RewriteRule)\b/,
    captures: {1 => {name: "support.constant.rewriterule.apache-config"}},
    end: "$",
    patterns: 
     [{begin: /[ ]+/,
       end: "$",
       patterns: 
        [{include: "#vars"},
         {match: /[^ %]+/,
          name: "string.regexp.rewrite-pattern.apache-config"},
         {begin: /[ ]+/,
          end: "$",
          patterns: 
           [{include: "#vars"},
            {match: /[^ %\n]+/,
             name: "string.other.rewrite-substitution.apache-config"},
            {captures: 
              {1 => {name: "string.regexp.rewrite-operator.apache-config"}},
             match: /[ ]+(?<_1>\[[^\]]+\])/}]}]}]},
   {match: 
     /\b(?<_1>R(?<_2>e(?<_3>sourceConfig|direct(?<_4>Match|Temp|Permanent)?|qu(?<_5>ire|estHeader)|ferer(?<_6>Ignore|Log)|write(?<_7>Rule|Map|Base|Cond|Options|Engine|Lo(?<_8>ck|g(?<_9>Level)?))|admeName|move(?<_10>Handler|Charset|Type|InputFilter|OutputFilter|Encoding|Language))|Limit(?<_11>MEM|NPROC|CPU))|Group|XBitHack|M(?<_12>MapFile|i(?<_13>nSpare(?<_14>Servers|Threads)|meMagicFile)|odMimeUsePathInfo|Cache(?<_15>RemovalAlgorithm|M(?<_16>inObjectSize|ax(?<_17>StreamingBuffer|Object(?<_18>Size|Count)))|Size)|ultiviewsMatch|eta(?<_19>Suffix|Dir|Files)|ax(?<_20>RequestsPer(?<_21>Child|Thread)|MemFree|Spare(?<_22>Servers|Threads)|Clients|Threads(?<_23>PerChild)?|KeepAliveRequests))|B(?<_24>indAddress|S2000Account|rowserMatch(?<_25>NoCase)?)|S(?<_26>hmemUIDisUser|c(?<_27>oreBoardFile|ript(?<_28>Sock|InterpreterSource|Log(?<_29>Buffer|Length)?|Alias(?<_30>Match)?)?)|tart(?<_31>Servers|Threads)|S(?<_32>I(?<_33>StartTag|TimeFormat|UndefinedEcho|E(?<_34>ndTag|rrorMsg))|L(?<_35>R(?<_36>equire(?<_37>SSL)?|andomSeed)|Mutex|SessionCache(?<_38>Timeout)?|C(?<_39>ipherSuite|ertificate(?<_40>ChainFile|KeyFile|File)|A(?<_41>Revocation(?<_42>Path|File)|Certificate(?<_43>Path|File)))|Options|P(?<_44>assPhraseDialog|ro(?<_45>tocol|xy(?<_46>MachineCertificate(?<_47>Path|File)|C(?<_48>ipherSuite|A(?<_49>Revocation(?<_50>Path|File)|Certificate(?<_51>Path|File)))|Protocol|Engine|Verify(?<_52>Depth)?)))|Engine|Verify(?<_53>Client|Depth)))|uexecUserGroup|e(?<_54>ndBufferSize|cureListen|t(?<_55>Handler|InputFilter|OutputFilter|Env(?<_56>If(?<_57>NoCase)?)?)|rver(?<_58>Root|Signature|Name|T(?<_59>ype|okens)|Path|Limit|A(?<_60>dmin|lias)))|atisfy)|H(?<_61>ostnameLookups|eader(?<_62>Name)?)|N(?<_63>o(?<_64>Cache|Proxy)|umServers|ameVirtualHost|WSSL(?<_65>TrustedCerts|Upgradeable))|C(?<_66>h(?<_67>ildPerUserID|eckSpelling|arset(?<_68>SourceEnc|Options|Default))|GI(?<_69>MapExtension|CommandArgs)|o(?<_70>ntentDigest|okie(?<_71>Style|Name|Tracking|Domain|Prefix|Expires|Format|Log)|reDumpDirectory)|ustomLog|learModuleList|ache(?<_72>Root|Gc(?<_73>MemUsage|Clean|Interval|Daily|Unused)|M(?<_74>inFileSize|ax(?<_75>Expire|FileSize))|Size|NegotiatedDocs|TimeMargin|Ignore(?<_76>NoLastMod|CacheControl)|D(?<_77>i(?<_78>sable|rLe(?<_79>ngth|vels))|efaultExpire)|E(?<_80>nable|xpiryCheck)|F(?<_81>ile|orceCompletion)|LastModifiedFactor))|T(?<_82>hread(?<_83>sPerChild|StackSize|Limit)|ypesConfig|ime(?<_84>out|Out)|ransferLog)|I(?<_85>n(?<_86>clude|dex(?<_87>Ignore|O(?<_88>ptions|rderDefault)))|SAPI(?<_89>ReadAheadBuffer|CacheFile|FakeAsync|LogNotSupported|AppendLogTo(?<_90>Errors|Query))|dentityCheck|f(?<_91>Module|Define)|map(?<_92>Menu|Base|Default))|O(?<_93>ptions|rder)|D(?<_94>irectory(?<_95>Match|Slash|Index)?|ocumentRoot|e(?<_96>ny|f(?<_97>late(?<_98>MemLevel|BufferSize|CompressionLevel|FilterNote|WindowSize)|ault(?<_99>Type|Icon|Language)))|av(?<_100>MinTimeout|DepthInfinity|LockDB)?)|U(?<_101>se(?<_102>CanonicalName|r(?<_103>Dir)?)|nsetEnv)|P(?<_104>idFile|ort|assEnv|ro(?<_105>tocol(?<_106>ReqCheck|Echo)|xy(?<_107>Re(?<_108>ceiveBufferSize|quests|mote(?<_109>Match)?)|Ma(?<_110>tch|xForwards)|B(?<_111>lock|adHeader)|Timeout|IOBufferSize|Domain|P(?<_112>ass(?<_113>Reverse)?|reserveHost)|ErrorOverride|Via)?))|E(?<_114>nable(?<_115>MMAP|Sendfile|ExceptionHook)|BCDIC(?<_116>Convert(?<_117>ByType)?|Kludge)|rror(?<_118>Header|Document|Log)|x(?<_119>t(?<_120>endedStatus|Filter(?<_121>Options|Define))|pires(?<_122>ByType|Default|Active)|ample))|Virtual(?<_123>ScriptAlias(?<_124>IP)?|Host|DocumentRoot(?<_125>IP)?)|KeepAlive(?<_126>Timeout)?|F(?<_127>ile(?<_128>s(?<_129>Match)?|ETag)|or(?<_130>ce(?<_131>Type|LanguagePriority)|ensicLog)|ancyIndexing)|Win32DisableAcceptEx|L(?<_132>i(?<_133>sten(?<_134>Back(?<_135>log|Log))?|mit(?<_136>Request(?<_137>Body|Field(?<_138>s(?<_139>ize)?|Size)|Line)|XMLRequestBody|InternalRecursion|Except)?)|o(?<_140>c(?<_141>kFile|ation(?<_142>Match)?)|ad(?<_143>Module|File)|g(?<_144>Format|Level))|DAP(?<_145>SharedCache(?<_146>Size|File)|Cache(?<_147>TTL|Entries)|TrustedCA(?<_148>Type)?|OpCache(?<_149>TTL|Entries))|anguagePriority)|A(?<_150>ssignUserID|nonymous(?<_151>_(?<_152>MustGiveEmail|NoUserID|VerifyEmail|LogEmail|Authoritative))?|c(?<_153>ce(?<_154>ss(?<_155>Config|FileName)|pt(?<_156>Mutex|PathInfo|Filter))|tion)|dd(?<_157>Module(?<_158>Info)?|Handler|Charset|Type|I(?<_159>nputFilter|con(?<_160>By(?<_161>Type|Encoding))?)|OutputFilter(?<_162>ByType)?|De(?<_163>scription|faultCharset)|Encoding|Language|Alt(?<_164>By(?<_165>Type|Encoding))?)|uth(?<_166>GroupFile|Name|Type|D(?<_167>B(?<_168>GroupFile|M(?<_169>GroupFile|Type|UserFile|Authoritative)|UserFile|Authoritative)|igest(?<_170>GroupFile|ShmemSize|N(?<_171>cCheck|once(?<_172>Format|Lifetime))|Domain|Qop|File|Algorithm))|UserFile|LDAP(?<_173>RemoteUserIsDN|GroupAttribute(?<_174>IsDN)?|Bind(?<_175>DN|Password)|C(?<_176>harsetConfig|ompareDNOnServer)|DereferenceAliases|Url|Enabled|FrontPageHack|Authoritative)|Authoritative)|l(?<_177>ias(?<_178>Match)?|low(?<_179>CONNECT|Override|EncodedSlashes)?)|gentLog)|MIMEMagicFile)\b/,
    name: "support.constant.apache-config"},
   {match: 
     /\b(?<_1>access_module|actions_module|action_module|alias_module|anon_auth_module|asis_module|authn_anon_module|authn_dbd_module|authn_dbm_module|authn_default_module|authn_file_module|authz_dbm_module|authz_default_module|authz_groupfile_module|authz_host_module|authz_owner_module|authz_user_module|auth_basic_module|auth_digest_module|auth_module|autoindex_module|bonjour_module|cache_module|cern_meta_module|cgi_module|config_log_module|dav_fs_module|dav_module|dbd_module|dbm_auth_module|deflate_module|digest_module|dir_module|disk_cache_module|dumpio_module|env_module|expires_module|ext_filter_module|fastcgi_module|filter_module|foo_module|headers_module|hfs_apple_module|ident_module|imagemap_module|imap_module|includes_module|include_module|info_module|jk_module|logio_module|log_config_module|log_forensic_module|mem_cache_module|mime_magic_module|mime_module|negotiation_module|perl_module|php4_module|php5_module|proxy_ajp_module|proxy_balancer_module|proxy_connect_module|proxy_ftp_module|proxy_http_module|proxy_module|rendezvous_apple_module|rendezvous_module|rewrite_module|setenvif_module|speling_module|ssl_module|status_module|substitute_module|unique_id_module|userdir_module|usertrack_module|version_module|vhost_alias_module)\b/,
    name: "support.class.apache-config"},
   {begin: /"/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.apache-config"}},
    end: "\"(?!\")",
    endCaptures: 
     {0 => {name: "punctuation.definition.string.end.apache-config"}},
    name: "string.quoted.double.apache-config",
    patterns: 
     [{match: /""/, name: "constant.character.escape.apostrophe.apache"}]},
   {begin: /(?<_1><\/?)(?<_2>[a-zA-Z]+)/,
    captures: 
     {1 => {name: "punctuation.definition.tag.apache-config"},
      2 => {name: "entity.name.tag.apache-config"}},
    end: "(/?>)",
    name: "meta.tag.apache-config"}],
 repository: 
  {vars: 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.variable.apache-config"},
          3 => {name: "punctuation.definition.variable.apache-config"}},
        match: 
         /(?<_1>%\{)(?:HTTP_(?:USER_AGENT|REFERER|COOKIE|FORWARDED|HOST|PROXY_CONNECTION|ACCEPT)|REMOTE_(?:ADDR|HOST|USER|IDENT)|REQUEST_(?:METHOD|URI|FILENAME)|SCRIPT_FILENAME|PATH_INFO|QUERY_STRING|AUTH_TYPE|DOCUMENT_ROOT|SERVER_(?:ADMIN|NAME|ADDR|PORT|PROTOCOL|SOFTWARE)|TIME_(?:YEAR|MON|DAY|HOUR|MIN|SEC|WDAY)|TIME|API_VERSION|THE_REQUEST|IS_SUBREQ|(?:ENV|LA-U|LA-F|HTTP|SSL):[^\}]+)(?<_2>\})/,
        name: "support.variable.apache-config"},
       {match: /%\{[^\}]+\}/,
        name: "invalid.illegal.bad-var.apache-config"}]}},
 scopeName: "source.apache-config",
 uuid: "023D670E-80F1-11D9-9BD1-00039398C572"}
