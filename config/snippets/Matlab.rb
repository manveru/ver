# Encoding: UTF-8

[{content: 
   "%  `if [[ ${TM_FILENAME} != '' ]]; then echo -e \"\\n% ${TM_FILENAME}\\n% \";fi`\n% Copyright (C) `date +%Y` ${TM_FULLNAME}`if [[ ${TM_ORGANIZATION_NAME} != '' ]]; then echo -e \", ${TM_ORGANIZATION_NAME}\";fi`. `if [[ ${TM_EMAIL} != '' ]]; then echo -e \"\\n% ${TM_EMAIL}\";fi``if [[ ${TM_URL} != '' ]]; then echo -e \"\\n% ${TM_URL}\";fi`\n% All rights reserved.\n%\n% Redistribution and use in source and binary forms, with or without\n% modification, are permitted provided that the following conditions are met:\n%     * Redistributions of source code must retain the above copyright\n%       notice, this list of conditions and the following disclaimer.\n%     * Redistributions in binary form must reproduce the above copyright\n%       notice, this list of conditions and the following disclaimer in the\n%       documentation and/or other materials provided with the distribution.\n%     * Neither the name of the <organization> nor the\n%       names of its contributors may be used to endorse or promote products\n%       derived from this software without specific prior written permission.\n%\n% THIS SOFTWARE IS PROVIDED BY <copyright holder> ``AS IS'' AND ANY\n% EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED\n% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE\n% DISCLAIMED. IN NO EVENT SHALL <copyright holder> BE LIABLE FOR ANY\n% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES\n% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;\n% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND\n% ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS\n% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n% \n",
  name: "BSD",
  scope: "source.matlab, source.octave",
  tabTrigger: "bsd",
  uuid: "DE617B87-A492-4C94-81CB-38F491C4C9B3"},
 {content: 
   "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   $1   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n",
  name: "Comment Divide",
  scope: "source.matlab, source.octave",
  uuid: "0844D21C-383B-4106-8474-8F79589731C6"},
 {content: 
   "%  `if [[ ${TM_FILENAME} != '' ]]; then echo -e \"\\n% ${TM_FILENAME}\\n% \";fi`\n% Copyright (C) `date +%Y` ${TM_FULLNAME}`if [[ ${TM_ORGANIZATION_NAME} != '' ]]; then echo -e \", ${TM_ORGANIZATION_NAME}\";fi`. `if [[ ${TM_EMAIL} != '' ]]; then echo -e \"\\n% ${TM_EMAIL}\";fi``if [[ ${TM_URL} != '' ]]; then echo -e \"\\n% ${TM_URL}\";fi`\n% \n% This program is free software; you can redistribute it and/or\n% modify it under the terms of the GNU General Public License\n% as published by the Free Software Foundation; either version 2\n% of the License, or (at your option) any later version.\n% \n% This program is distributed in the hope that it will be useful,\n% but WITHOUT ANY WARRANTY; without even the implied warranty of\n% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n% GNU General Public License for more details.\n% \n% You should have received a copy of the GNU General Public License\n% along with this program; if not, write to the Free Software\n% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.\n% \n",
  name: "GPL",
  scope: "source.matlab, source.octave",
  tabTrigger: "gpl",
  uuid: "2FA74452-3A9B-428E-9DE4-7C04DA978635"},
 {content: 
   "## Copyright (C) ${TM_YEAR} $TM_FULLNAME\n##\n## This program is free software; you can redistribute it and/or modify\n## it under the terms of the GNU General Public License as published by\n## the Free Software Foundation; either version 2 of the License, or\n## (at your option) any later version.\n##\n## This program is distributed in the hope that it will be useful,\n## but WITHOUT ANY WARRANTY; without even the implied warranty of\n## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n## GNU General Public License for more details.\n##\n## You should have received a copy of the GNU General Public License\n## along with this program; If not, see <http://www.gnu.org/licenses/>.\n\n## -*- texinfo -*-\n## @deftypefn {Function File} {${1:Outputs} = } ${2:Function Name} (${3:Input Arguments)\n## ${4:Short Description}\n##\n## ${5:Long Description}\n##\n## @seealso{${6:functions}}\n## @end deftypefn\n\n## Author:  $TM_FULLNAME\n\n$0\n\nendfunction",
  name: "Octave function",
  scope: "source.matlab",
  tabTrigger: "octfun",
  uuid: "5C7F21FA-156C-4A86-AB20-7F9678010BCA"},
 {content: 
   "%\tRev. by ${TM_FULLNAME} on `date +%Y-%m-%d`: ${1:Short description}",
  name: "Revisions",
  scope: "source.matlab, source.octave",
  tabTrigger: "rev",
  uuid: "87BC3C5B-627C-49AD-97B6-455345C1D478"},
 {content: "^($1) $2",
  name: "^",
  scope: "source.matlab, source.octave",
  tabTrigger: "^",
  uuid: "6B86576E-F8E3-4E3A-8083-CFE4C0DF9E42"},
 {content: "case ${2:'${3:string}'}\n\t$0",
  name: "case",
  scope: "source.matlab, source.octave",
  tabTrigger: "case",
  uuid: "F7A928F5-B70D-4DB0-8DEF-F61928038A6C"},
 {content: "clear('${1:all}'$2);",
  name: "clear",
  scope: "source.matlab, source.octave",
  tabTrigger: "clear",
  uuid: "B5FEAC12-94C4-4D45-9907-7EE843F09C0D"},
 {content: "disp('${1:Text}');",
  name: "disp",
  scope: "source.matlab, source.octave",
  tabTrigger: "disp",
  uuid: "975C9569-8B7D-4A60-8ED4-478A724D3A4E"},
 {content: 
   "disp(sprintf('${1:%s}\\\\n'${1/([^%]|%%)*(%.)?.*/(?2:, :\\);)/}$2${1/([^%]|%%)*(%.)?.*/(?2:\\);)/});",
  name: "disp sprintf",
  scope: "source.matlab, source.octave",
  tabTrigger: "dsp",
  uuid: "EC4078AC-7F43-42CA-A83A-E1477558D84E"},
 {content: 
   "dlmwrite('${1:filename}.dat', [${2:variables}], ${3:'${4:delimiter}', '${5:\\t}'});\n$0",
  name: "dlmwrite",
  scope: "source.matlab, source.octave",
  tabTrigger: "dlmwrite",
  uuid: "0FDCE9D1-A757-4793-816D-1364192CE326"},
 {content: "else\n\t${1:body}",
  name: "else",
  scope: "source.matlab, source.octave",
  tabTrigger: "else",
  uuid: "582075F1-DB3F-4280-9F46-B615F8EF4A86"},
 {content: "elseif ${1:condition}\n\t$0",
  name: "elseif",
  scope: "source.matlab, source.octave",
  tabTrigger: "elseif",
  uuid: "EA7BD80E-6346-44E9-A909-CE0703CFB390"},
 {content: "error('${1:Description}');",
  name: "error",
  scope: "source.matlab, source.octave",
  tabTrigger: "error",
  uuid: "7135F592-1176-478A-BA31-BD8A7DA56F93"},
 {content: "exp($1) $2",
  name: "exp",
  scope: "source.matlab, source.octave",
  tabTrigger: "e",
  uuid: "C00046EC-C7DC-4BC5-81CD-EBCB0F6FE8F7"},
 {content: 
   "for ${1:ii}=${2:1}${3::${4:n}}\n\t$0\n`if [[ $TM_USE_OCTAVE -ne '0' ]]\n\tthen echo \"endfor\"\nelse\n\techo \"end\"\nfi`",
  name: "for … end",
  scope: "source.matlab, source.octave",
  tabTrigger: "for",
  uuid: "08CB1F21-B7EB-4AD7-B066-BB365966E390"},
 {content: 
   "fprintf(${1:fid}, '${2:%s}\\\\n'${2/([^%]|%%)*(%.)?.*/(?2:, :\\);)/}$3${2/([^%]|%%)*(%.)?.*/(?2:\\);)/}",
  name: "fprintf",
  scope: "source.matlab, source.octave",
  tabTrigger: "fpr",
  uuid: "163D3790-C8E8-4888-81D7-50907D825EA0"},
 {content: 
   "function ${1:Output variables} = ${2:functionName}(${3:Input variables})\n$TM_COMMENT_START\t${2/.*/\\U$0/}   ${4:Short description}\n$TM_COMMENT_START\t\t[${1/.*/\\U$0/}] = ${2/.*/\\U$0/}(${6:${3/.*/\\U$0/}})\n$TM_COMMENT_START\n$TM_COMMENT_START\t${5:Long description}\n$TM_COMMENT_START\t\n$TM_COMMENT_START\tCreated by $TM_FULLNAME on `date +%Y-%m-%d`.\n$TM_COMMENT_START\tCopyright (c) ${TM_YEAR} ${TM_ORGANIZATION_NAME}. All rights reserved.\n\n$0\n\n`if [[ $TM_CLOSE_FUNCTIONS -ne '0' ]]\n\tthen\n\tif [[ $TM_USE_OCTAVE -ne '0' ]]\n\t\tthen echo \"endfunction\"\n\telse\n\t\techo \"end $TM_COMMENT_START function\" \n\tfi\nfi`",
  name: "function",
  scope: "source.matlab, source.octave",
  tabTrigger: "fun",
  uuid: "0EA9BDAD-6EA3-48C4-ADF5-EA549D84CAF0"},
 {content: "get(${1:gca},'${2:PropertyName}');",
  name: "get",
  scope: "source.matlab, source.octave",
  tabTrigger: "get",
  uuid: "9915BCE4-2499-4E17-9006-7BB08A8539F0"},
 {content: "griddata(${1:xx}, ${2:yy}, ${3:zz}, ${4:xi}, ${5:yi}); ",
  name: "griddata",
  scope: "source.matlab, source.octave",
  tabTrigger: "griddata",
  uuid: "8E4BA761-42BB-4CFC-B117-A547228878B8"},
 {content: 
   "if ${1:condition}\n\t$2\nelse\n\t$3\n`if [[ $TM_USE_OCTAVE -ne '0' ]]\n\tthen echo \"endif\"\nelse\n\techo \"end\"\nfi`",
  name: "if … else …end",
  scope: "source.matlab, source.octave",
  tabTrigger: "ife",
  uuid: "4A86BFC8-5C03-45F8-B7D6-597F476E7C93"},
 {content: 
   "if ${1:condition}\n\t${2:body}\nelseif ${3:condition}\n\t${4:body}\nelse\n\t${5:body}\nend\n",
  name: "if … elseif … end",
  scope: "source.matlab , source.octave",
  tabTrigger: "ifeif",
  uuid: "93234216-9807-416E-8416-A130A05C2C1F"},
 {content: 
   "if ${1:condition}\n\t$0\n`if [[ $TM_USE_OCTAVE -ne '0' ]]\n\tthen echo \"endif\"\nelse\n\techo \"end\"\nfi`",
  name: "if … end",
  scope: "source.matlab, source.octave",
  tabTrigger: "if",
  uuid: "876FEC4C-FD21-401A-8947-0B2E232E19CA"},
 {content: 
   "line(${1:xvector},${2:yvector}${3:,'Color','${4:b}','LineWidth',${5:1},'LineStyle','${6:-}'})\n",
  name: "line",
  scope: "source.matlab, source.octave",
  tabTrigger: "line",
  uuid: "3FFA60EB-FA14-47DE-AEF7-5A3E840BE637"},
 {content: 
   "error(nargchk(${1:min}, ${2:max}, ${3:nargin}, `if [[ $TM_USE_OCTAVE -eq '0' ]]; then\n\techo -n \"'struct'\"\nfi` ));\n",
  name: "nargchk",
  scope: "source.matlab, source.octave",
  tabTrigger: "nargchk",
  uuid: "8325A3D7-1025-48C4-810F-CF41E7E71DA2"},
 {content: 
   "set(${1:get(${2:gca},'${3:PropertyName}')},'${4:PropertyName}',${5:PropertyValue});",
  name: "set",
  scope: "source.matlab , source.octave",
  tabTrigger: "set",
  uuid: "1166137D-A579-484D-BDD7-AC62EFFA3FFA"},
 {content: 
   "%% ${1:functionname}: ${2:function description}\nfunction [${3:outputs}] = ${1}(${4:arg})\n${3/,?\\s*([a-zA-Z]\\w*)|,\\s*/(?1:\\t$1 = ;\\n)/g}",
  name: "small function",
  scope: "source.matlab, source.octave",
  tabTrigger: "func",
  uuid: "2376F2E2-E240-422F-B6E8-48B6AA20C9EE"},
 {content: 
   "sprintf('${1:%s}\\\\n'${1/([^%]|%%)*(%.)?.*/(?2:, :\\);)/}$2${1/([^%]|%%)*(%.)?.*/(?2:\\);)/}",
  name: "sprintf",
  scope: "source.matlab, source.octave",
  tabTrigger: "spr",
  uuid: "71CFA3F2-D883-4571-95B9-D98651890156"},
 {content: 
   "switch ${1:switch_expression}\n\tcase ${2:case_expression}\n\t\t${3:body}\n\totherwise\n\t\t${4:body}\nend",
  name: "switch ... case ... otherwise ... end",
  scope: "source.matlab, source.octave",
  tabTrigger: "switch",
  uuid: "89BADD5A-72B8-4FE5-B082-499C7E7AB452"},
 {content: 
   "switch ${1:var}\ncase ${2:'${3:string}'}\n\t$0\n`if [[ $TM_USE_OCTAVE -ne '0' ]]\n\tthen echo \"endswitch\"\nelse\n\techo \"end\"\nfi`",
  name: "switch … case … end",
  scope: "source.matlab",
  tabTrigger: "switch",
  uuid: "631FAA9C-ECC2-484A-A29C-3CD66D944693"},
 {content: 
   "switch ${1:var}\ncase ${2:'${3:string}'}\n\t$4\notherwise\n\t$0\n`if [[ $TM_USE_OCTAVE -ne '0' ]]\n\tthen echo \"endswitch\"\nelse\n\techo \"end\"\nfi`",
  name: "switch … case … otherwise … end",
  scope: "source.matlab",
  tabTrigger: "switcho",
  uuid: "C600A817-A58A-4884-9BDC-F7CB13407CB6"},
 {content: "set(get(gca,'Title'),'String',${1:'${2}'});",
  name: "title",
  scope: "source.matlab , source.octave",
  tabTrigger: "zla",
  uuid: "7298E093-E86F-4A60-ACFF-67580F24FD27"},
 {content: 
   "try \n\t$1\ncatch \n\t$0\n`if [[ $TM_USE_OCTAVE -ne '0' ]]\n\tthen echo \"end_try_catch\"\nelse\n\techo \"end\"\nfi`",
  name: "try … catch … end",
  scope: "source.matlab",
  tabTrigger: "try",
  uuid: "B287F24B-9BC5-4EAB-9621-1E73D367AAB7"},
 {content: "[${1:s},${2:w}] = unix('${3:Unix commands}');",
  name: "unix",
  scope: "source.matlab, source.octave",
  tabTrigger: "uni",
  uuid: "F0A7C9BF-8FE2-4452-8EC9-F71881C7831F"},
 {content: 
   "unwind_protect \n\t$1\nunwnd_protect_cleanup \n\t$0\nend_unwind_protect",
  name: "unwind_protect … cleanup … end",
  scope: "source.matlab",
  tabTrigger: "unwind",
  uuid: "9475371F-F8A7-4C46-BAC9-B42E7E34F2AD"},
 {content: "warning(['${1:Description}']);",
  name: "warning",
  scope: "source.matlab, source.octave",
  tabTrigger: "war",
  uuid: "6392FF26-D584-435E-8202-9BC99FF26488"},
 {content: "while ${1:condition}\n\t${2:body}\nend\n",
  name: "while",
  scope: "source.matlab , source.octave",
  tabTrigger: "whi",
  uuid: "ADE63DB1-7F3A-4EAC-A5A4-3A35A28FE8F0"},
 {content: "set(get(gca,'XLabel'),'String',${1:'${2}'});",
  name: "xlabel",
  scope: "source.matlab , source.octave",
  tabTrigger: "xla",
  uuid: "178F5EE1-2953-4FB2-8623-99A1C7D0772F"},
 {content: "set(gca,'XTick',${1:[${2}]});",
  name: "xtick",
  scope: "source.matlab , source.octave",
  tabTrigger: "xti",
  uuid: "A93C4844-87F4-4136-9580-75B697D0CFD7"},
 {content: "set(get(gca,'YLabel'),'String',${1:'${2}'});",
  name: "ylabel",
  scope: "source.matlab , source.octave",
  tabTrigger: "yla",
  uuid: "1F4C6EA6-370C-45A9-96C5-36E69CC297E3"},
 {content: "set(gca,'YTick',${1:[${2}]});",
  name: "ytick",
  scope: "source.matlab , source.octave",
  tabTrigger: "yti",
  uuid: "2FED97FA-0EB0-45E3-B92F-757903E79684"},
 {content: "set(get(gca,'ZLabel'),'String',${1:'${2}'});",
  name: "zlabel",
  scope: "source.matlab , source.octave",
  tabTrigger: "zla",
  uuid: "3C12382B-FD63-4DD8-9198-02D25AF755FF"}]
