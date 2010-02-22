# Encoding: UTF-8

{fileTypes: [],
 foldingStartMarker: /\/\*\*|\{\s*$/,
 foldingStopMarker: /\*\*\/|^\s*\}/,
 name: "TeX Math",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.constant.math.tex"}},
    match: 
     /(?<_1>\\)(?<_2>s(?<_3>s(?<_4>earrow|warrow|lash)|h(?<_5>ort(?<_6>downarrow|uparrow|parallel|leftarrow|rightarrow|mid)|arp)|tar|i(?<_7>gma|m(?<_8>eq)?)|u(?<_9>cc(?<_10>sim|n(?<_11>sim|approx)|curlyeq|eq|approx)?|pset(?<_12>neq(?<_13>q)?|plus(?<_14>eq)?|eq(?<_15>q)?)?|rd|m|bset(?<_16>neq(?<_17>q)?|plus(?<_18>eq)?|eq(?<_19>q)?)?)|p(?<_20>hericalangle|adesuit)|e(?<_21>tminus|arrow)|q(?<_22>su(?<_23>pset(?<_24>eq)?|bset(?<_25>eq)?)|c(?<_26>up|ap)|uare)|warrow|m(?<_27>ile|all(?<_28>s(?<_29>etminus|mile)|frown)))|h(?<_30>slash|ook(?<_31>leftarrow|rightarrow)|eartsuit|bar)|R(?<_32>sh|ightarrow|e|bag)|Gam(?<_33>e|ma)|n(?<_34>s(?<_35>hort(?<_36>parallel|mid)|im|u(?<_37>cc(?<_38>eq)?|pseteq(?<_39>q)?|bseteq))|Rightarrow|n(?<_40>earrow|warrow)|cong|triangle(?<_41>left(?<_42>eq(?<_43>slant)?)?|right(?<_44>eq(?<_45>slant)?)?)|i(?<_46>plus)?|u|p(?<_47>lus|arallel|rec(?<_48>eq)?)|e(?<_49>q|arrow|g|xists)|v(?<_50>dash|Dash)|warrow|le(?<_51>ss|q(?<_52>slant|q)?|ft(?<_53>arrow|rightarrow))|a(?<_54>tural|bla)|VDash|rightarrow|g(?<_55>tr|eq(?<_56>slant|q)?)|mid|Left(?<_57>arrow|rightarrow))|c(?<_58>hi|irc(?<_59>eq|le(?<_60>d(?<_61>circ|S|dash|ast)|arrow(?<_62>left|right)))?|o(?<_63>ng|prod|lon|mplement)|dot(?<_64>s|p)?|u(?<_65>p|r(?<_66>vearrow(?<_67>left|right)|ly(?<_68>eq(?<_69>succ|prec)|vee(?<_70>downarrow|uparrow)?|wedge(?<_71>downarrow|uparrow)?)))|enterdot|lubsuit|ap)|Xi|Maps(?<_72>to(?<_73>char)?|from(?<_74>char)?)|B(?<_75>ox|umpeq|bbk)|t(?<_76>h(?<_77>ick(?<_78>sim|approx)|e(?<_79>ta|refore))|imes|op|wohead(?<_80>leftarrow|rightarrow)|a(?<_81>u|lloblong)|riangle(?<_82>down|q|left(?<_83>eq(?<_84>slant)?)?|right(?<_85>eq(?<_86>slant)?)?)?)|i(?<_87>n(?<_88>t(?<_89>er(?<_90>cal|leave))?|plus|fty)?|ota|math)|S(?<_91>igma|u(?<_92>pset|bset))|zeta|o(?<_93>slash|times|int|dot|plus|vee|wedge|lessthan|greaterthan|m(?<_94>inus|ega)|b(?<_95>slash|long|ar))|d(?<_96>i(?<_97>v(?<_98>ideontimes)?|a(?<_99>g(?<_100>down|up)|mond(?<_101>suit)?)|gamma)|o(?<_102>t(?<_103>plus|eq(?<_104>dot)?)|ublebarwedge|wn(?<_105>harpoon(?<_106>left|right)|downarrows|arrow))|d(?<_107>ots|agger)|elta|a(?<_108>sh(?<_109>v|leftarrow|rightarrow)|leth|gger))|Y(?<_110>down|up|left|right)|C(?<_111>up|ap)|u(?<_112>n(?<_113>lhd|rhd)|p(?<_114>silon|harpoon(?<_115>left|right)|downarrow|uparrows|lus|arrow)|lcorner|rcorner)|jmath|Theta|Im|p(?<_116>si|hi|i(?<_117>tchfork)?|erp|ar(?<_118>tial|allel)|r(?<_119>ime|o(?<_120>d|pto)|ec(?<_121>sim|n(?<_122>sim|approx)|curlyeq|eq|approx)?)|m)|e(?<_123>t(?<_124>h|a)|psilon|q(?<_125>slant(?<_126>less|gtr)|circ|uiv)|ll|xists|mptyset)|Omega|D(?<_127>iamond|ownarrow|elta)|v(?<_128>d(?<_129>ots|ash)|ee(?<_130>bar)?|Dash|ar(?<_131>s(?<_132>igma|u(?<_133>psetneq(?<_134>q)?|bsetneq(?<_135>q)?))|nothing|curly(?<_136>vee|wedge)|t(?<_137>heta|imes|riangle(?<_138>left|right)?)|o(?<_139>slash|circle|times|dot|plus|vee|wedge|lessthan|ast|greaterthan|minus|b(?<_140>slash|ar))|p(?<_141>hi|i|ropto)|epsilon|kappa|rho|bigcirc))|kappa|Up(?<_142>silon|downarrow|arrow)|Join|f(?<_143>orall|lat|a(?<_144>t(?<_145>s(?<_146>emi|lash)|bslash)|llingdotseq)|rown)|P(?<_147>si|hi|i)|w(?<_148>p|edge|r)|l(?<_149>hd|n(?<_150>sim|eq(?<_151>q)?|approx)|ceil|times|ightning|o(?<_152>ng(?<_153>left(?<_154>arrow|rightarrow)|rightarrow|maps(?<_155>to|from))|zenge|oparrow(?<_156>left|right))|dot(?<_157>s|p)|e(?<_158>ss(?<_159>sim|dot|eq(?<_160>qgtr|gtr)|approx|gtr)|q(?<_161>slant|q)?|ft(?<_162>slice|harpoon(?<_163>down|up)|threetimes|leftarrows|arrow(?<_164>t(?<_165>ail|riangle))?|right(?<_166>squigarrow|harpoons|arrow(?<_167>s|triangle|eq)?))|adsto)|vertneqq|floor|l(?<_168>c(?<_169>orner|eil)|floor|l|bracket)?|a(?<_170>ngle|mbda)|rcorner|bag)|a(?<_171>s(?<_172>ymp|t)|ngle|pprox(?<_173>eq)?|l(?<_174>pha|eph)|rrownot|malg)|V(?<_175>dash|vdash)|r(?<_176>h(?<_177>o|d)|ceil|times|i(?<_178>singdotseq|ght(?<_179>s(?<_180>quigarrow|lice)|harpoon(?<_181>down|up)|threetimes|left(?<_182>harpoons|arrows)|arrow(?<_183>t(?<_184>ail|riangle))?|rightarrows))|floor|angle|r(?<_185>ceil|parenthesis|floor|bracket)|bag)|g(?<_186>n(?<_187>sim|eq(?<_188>q)?|approx)|tr(?<_189>sim|dot|eq(?<_190>qless|less)|less|approx)|imel|eq(?<_191>slant|q)?|vertneqq|amma|g(?<_192>g)?)|Finv|xi|m(?<_193>ho|i(?<_194>nuso|d)|o(?<_195>o|dels)|u(?<_196>ltimap)?|p|e(?<_197>asuredangle|rge)|aps(?<_198>to|from(?<_199>char)?))|b(?<_200>i(?<_201>n(?<_202>dnasrepma|ampersand)|g(?<_203>s(?<_204>tar|qc(?<_205>up|ap))|nplus|c(?<_206>irc|u(?<_207>p|rly(?<_208>vee|wedge))|ap)|triangle(?<_209>down|up)|interleave|o(?<_210>times|dot|plus)|uplus|parallel|vee|wedge|box))|o(?<_211>t|wtie|x(?<_212>slash|circle|times|dot|plus|empty|ast|minus|b(?<_213>slash|ox|ar)))|u(?<_214>llet|mpeq)|e(?<_215>cause|t(?<_216>h|ween|a))|lack(?<_217>square|triangle(?<_218>down|left|right)?|lozenge)|a(?<_219>ck(?<_220>s(?<_221>im(?<_222>eq)?|lash)|prime|epsilon)|r(?<_223>o|wedge))|bslash)|L(?<_224>sh|ong(?<_225>left(?<_226>arrow|rightarrow)|rightarrow|maps(?<_227>to|from))|eft(?<_228>arrow|rightarrow)|leftarrow|ambda|bag)|Arrownot)\b/,
    name: "constant.character.math.tex"},
   {captures: {1 => {name: "punctuation.definition.constant.math.tex"}},
    match: 
     /(?<_1>\\)(?<_2>sum|prod|coprod|int|oint|bigcap|bigcup|bigsqcup|bigvee|bigwedge|bigodot|bigotimes|bogoplus|biguplus)\b/,
    name: "constant.character.math.tex"},
   {captures: {1 => {name: "punctuation.definition.constant.math.tex"}},
    match: 
     /(?<_1>\\)(?<_2>arccos|arcsin|arctan|arg|cos|cosh|cot|coth|csc|deg|det|dim|exp|gcd|hom|inf|ker|lg|lim|liminf|limsup|ln|log|max|min|pr|sec|sin|sinh|sup|tan|tanh)\b/,
    name: "constant.other.math.tex"},
   {begin: /(?<_1>(?<_2>\\)Sexpr)(?<_3>\{)/,
    beginCaptures: 
     {1 => {name: "support.function.sexpr.math.tex"},
      2 => {name: "punctuation.definition.function.math.tex"},
      3 => {name: "punctuation.section.embedded.begin.math.tex"}},
    contentName: "source.r.embedded.math.tex",
    end: "(\\})",
    endCaptures: {1 => {name: "punctuation.section.embedded.end.math.tex"}},
    name: "meta.function.sexpr.math.tex",
    patterns: [{include: "source.r"}]},
   {captures: {1 => {name: "punctuation.definition.constant.math.tex"}},
    match: /(?<_1>\\)(?<_2>[^a-zA-Z]|[A-Za-z]+)(?=\b|\}|\]|\^|\_)/,
    name: "constant.other.general.math.tex"},
   {match: /(?<_1>(?<_2>[0-9]*[\.][0-9]+)|[0-9]+)/,
    name: "constant.numeric.math.tex"},
   {match: /«press a-z and space for greek letter»[a-zA-Z]*/,
    name: "meta.placeholder.greek.math.tex"}],
 scopeName: "text.tex.math",
 uuid: "027D6AF4-E9D3-4250-82A1-8A42EEFE4F76"}
