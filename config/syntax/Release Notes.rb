# Encoding: UTF-8

{fileTypes: ["tmReleaseNotes"],
 name: "Release Notes",
 patterns: 
  [{captures: 
     {1 => {name: "punctuation.definition.separator.release-notes"},
      2 => {name: "meta.toc-list.release-notes"},
      3 => {name: "punctuation.definition.separator.release-notes"}},
    match: 
     /^(?<_1>\[)(?:[\d-]+: )?(?<_2>REVISION (?<_3>\d+|v[\d.b]+))(?<_4>\])$\n/,
    name: "meta.separator.release-notes"},
   {begin: /^(?<_1>[ \t]*)(?=\S)/,
    contentName: "meta.paragraph.release-notes",
    end: "^(?!\\1(?=\\S))",
    patterns: 
     [{match: /(?<_1>https?|ftp|mailto):\S+?(?=[)>,.':;"]*(?<_2>\s|$)|$)/,
       name: "markup.underline.link.release-notes"},
      {captures: 
        {1 => {name: "keyword.other.release-notes"},
         2 => {name: "punctuation.definition.keyword.release-notes"},
         3 => {name: "punctuation.definition.keyword.release-notes"},
         4 => {name: "constant.other.bundle-name.release-notes"}},
       match: 
        /(?<_1>(?<_2>\[)(?:NEW|FIXED|CHANGED|REMOVED|INFO)(?<_3>\])) (?:(?<_4>.+? bundle):)?/},
      {captures: 
        {1 => {name: "storage.type.ticket.release-notes"},
         2 => {name: "constant.numeric.ticket.release-notes"}},
       match: /(?<_1>[Tt]icket) (?<_2>[0-9A-F]{8})\b/,
       name: "meta.ticket.release-notes"},
      {comment: 
        "I do not want spell checking for CamelCase words. Since this is generally when quoting various API’s, I have deliberately used A-Z and a-z (ASCII) -- Allan",
       match: /\b[A-Z]*[a-z]+[A-Z]\w*\b/,
       name: "meta.word.camel-case.release-notes"},
      {captures: {1 => {name: "constant.other.committer-name.release-notes"}},
       match: 
        /\((?<_1>G(?<_2>erd Knops|a(?<_3>vin Kistner|rrett J. Woodworth)|ra(?<_4>nt Hollingworth|eme Rocher))|R(?<_5>yan McCuaig|ich Barton|o(?<_6>ss Harmes|ger Braunstein|b(?<_7>ert Rainthorpe| (?<_8>Rix|Bevan))))|M(?<_9>i(?<_10>cha(?<_11>il Pishchagin|el Sheets)|tch Chapman|etek Bąk|k(?<_12>e Mellor|ael Säker))|a(?<_13>t(?<_14>s Persson|t(?<_15>hew Gilbert|eo Spinelli| Pelletier))|r(?<_16>tin Ström|k Grimes)|x Williams))|B(?<_17>ill Duenskie|ob Fleck|en(?<_18>oit Gagnon|jamin Jackson| Perry)|arrett Clark|r(?<_19>ian (?<_20>Donovan|Lalor)|ett Terpstra|ad (?<_21>Miller|Choate)))|H(?<_22>enrik Nyh|adley Wickham)|S(?<_23>t(?<_24>ephen Skubik-Peplaski|éphane Payrard|anley Rost)|imon (?<_25>Gregory|Strandgaard)|u(?<_26>ne Foldager|dara Williams)|ebastian Gräßl|am DeVore)|Nathan Youngman|C(?<_27>h(?<_28>a(?<_29>ndler McWilliams|rilaos Skiadas)|ris(?<_30>topher Forsythe| (?<_31>Thomas|Jenkins)))|iarán Walsh)|T(?<_32>homas Aylott|o(?<_33>rsten Becker|m Lazar|bias Luetke)|akaaki Kato|roy Mcilvena)|Ian (?<_34>Joyner|White)|Ollivier Robert|D(?<_35>om(?<_36>inique Peretti|enico Carbotta)|uane Johnson|a(?<_37>n(?<_38>iel Harple| Kelley)|vid (?<_39>Glasser|Bonnet|Hansson|Powers|Wikler))|rew Colthorp)|J(?<_40>iun Wei Chia|o(?<_41>shua Emmons|nathan (?<_42>Ragan-Kelley|Chaffer)|e Maller|achim Mårtensson)|ustin French|eroen van der Ham|a(?<_43>cob Rus|y Soffian|kub Nešetřil|m(?<_44>is Buck|es (?<_45>Edward Gray II|A. Baker))))|Paul(?<_46>o Jorge Lopes de Moura| Bissex)|Eric Hsu|K(?<_47>umar McMillan|evin Ballard)|F(?<_48>ergus Bremner|abien POTENCIER|lorent Pillet|r(?<_49>édéric Ballériaux|ank Brault))|Wil(?<_50>son Miner|liam (?<_51>D. Neumann|Prater))|A(?<_52>n(?<_53>thony Underwood|d(?<_54>y Herbert|ers Thid|rew Henson))|dam Sanderson|urelio Marinho Jargas|parajita Fishman|l(?<_55>e(?<_56> Muñoz|xand(?<_57>er John Ross|re Girard))|an Schussman|lan Odgaard)|mro Nasr))\)$/}]}],
 scopeName: "text.plain.release-notes",
 uuid: "8926CAFE-1CF3-4CF9-A056-4FF90F596E9A"}
