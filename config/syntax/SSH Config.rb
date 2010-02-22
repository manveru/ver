# Encoding: UTF-8

{fileTypes: ["ssh_config", ".ssh/config", "sshd_config"],
 name: "SSH Config",
 patterns: 
  [{match: 
     /\b(?<_1>AddressFamily|B(?<_2>atchMode|indAddress)|C(?<_3>hallengeResponseAuthentication|heckHostIP|iphers?|learAllForwardings|ompression(?<_4>Level)?|onnect(?<_5>Timeout|ionAttempts)|ontrolMaster|ontrolPath)|DynamicForward|E(?<_6>nableSSHKeysign|scapeChar)|Forward(?<_7>Agent|X11(?<_8>Trusted)?)|G(?<_9>SSAPI(?<_10>Authentication|DelegateCredentials)|atewayPorts|lobalKnownHostsFile)|Host(?<_11>KeyAlgorithms|KeyAlias|Name|basedAuthentication)|Identit(?<_12>iesOnly|yFile)|L(?<_13>ocalForward|ogLevel)|MACs|N(?<_14>oHostAuthenticationForLocalhost|umberOfPasswordPrompts)|P(?<_15>asswordAuthentication|ort|referredAuthentications|rotocol|roxyCommand|ubkeyAuthentication)|R(?<_16>SAAuthentication|emoteForward|hostsRSAAuthentication)|S(?<_17>erverAliveCountMax|erverAliveInterval|martcardDevice|trictHostKeyChecking)|TCPKeepAlive|U(?<_18>sePrivilegedPort|ser(?<_19>KnownHostsFile)?)|VerifyHostKeyDNS|XAuthLocation)\b/,
    name: "keyword.other.ssh-config"},
   {captures: 
     {1 => {name: "comment.line.number-sign.ssh-config"},
      2 => {name: "punctuation.definition.comment.ssh-config"},
      3 => {name: "comment.line.double-slash.ssh-config"},
      4 => {name: "punctuation.definition.comment.ssh-config"}},
    match: /(?<_1>(?<_2>#).*$\n?)|(?<_3>(?<_4>\/\/).*$\n?)/},
   {captures: 
     {1 => {name: "storage.type.ssh-config"},
      2 => {name: "entity.name.section.ssh-config"},
      3 => {name: "meta.toc-list.ssh-config"}},
    match: /(?:^| |\t)(?<_1>Host)\s+(?<_2>(?<_3>.*))$/},
   {match: 
     /\b(?<_1>25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?<_2>25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?<_3>25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?<_4>25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/,
    name: "constant.numeric.ssh-config"},
   {match: /\b[0-9]+\b/, name: "constant.numeric.ssh-config"}],
 scopeName: "source.ssh-config",
 uuid: "B273855C-59D3-4DF3-9B7C-E68E0057D315"}
