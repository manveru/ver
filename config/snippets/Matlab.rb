# Encoding: UTF-8

{"for" => 
  {scope: "source.matlab, source.octave",
   name: "for … end",
   content: 
    "for ${1:ii}=${2:1}${3::${4:n}}\n\t$0\n`if [[ $TM_USE_OCTAVE -ne '0' ]]\n\tthen echo \"endfor\"\nelse\n\techo \"end\"\nfi`"},
 "fun" => 
  {scope: "source.matlab, source.octave",
   name: "function",
   content: 
    "function ${1:Output variables} = ${2:functionName}(${3:Input variables})\n$TM_COMMENT_START\t${2/.*/\\U$0/}   ${4:Short description}\n$TM_COMMENT_START\t\t[${1/.*/\\U$0/}] = ${2/.*/\\U$0/}(${6:${3/.*/\\U$0/}})\n$TM_COMMENT_START\n$TM_COMMENT_START\t${5:Long description}\n$TM_COMMENT_START\t\n$TM_COMMENT_START\tCreated by $TM_FULLNAME on `date +%Y-%m-%d`.\n$TM_COMMENT_START\tCopyright (c) ${TM_YEAR} ${TM_ORGANIZATION_NAME}. All rights reserved.\n\n$0\n\n`if [[ $TM_CLOSE_FUNCTIONS -ne '0' ]]\n\tthen\n\tif [[ $TM_USE_OCTAVE -ne '0' ]]\n\t\tthen echo \"endfunction\"\n\telse\n\t\techo \"end $TM_COMMENT_START function\" \n\tfi\nfi`"},
 "if" => 
  {scope: "source.matlab, source.octave",
   name: "if … end",
   content: 
    "if ${1:condition}\n\t$0\n`if [[ $TM_USE_OCTAVE -ne '0' ]]\n\tthen echo \"endif\"\nelse\n\techo \"end\"\nfi`"},
 "bsd" => 
  {scope: "source.matlab, source.octave",
   name: "BSD",
   content: 
    "%  `if [[ ${TM_FILENAME} != '' ]]; then echo -e \"\\n% ${TM_FILENAME}\\n% \";fi`\n% Copyright (C) `date +%Y` ${TM_FULLNAME}`if [[ ${TM_ORGANIZATION_NAME} != '' ]]; then echo -e \", ${TM_ORGANIZATION_NAME}\";fi`. `if [[ ${TM_EMAIL} != '' ]]; then echo -e \"\\n% ${TM_EMAIL}\";fi``if [[ ${TM_URL} != '' ]]; then echo -e \"\\n% ${TM_URL}\";fi`\n% All rights reserved.\n%\n% Redistribution and use in source and binary forms, with or without\n% modification, are permitted provided that the following conditions are met:\n%     * Redistributions of source code must retain the above copyright\n%       notice, this list of conditions and the following disclaimer.\n%     * Redistributions in binary form must reproduce the above copyright\n%       notice, this list of conditions and the following disclaimer in the\n%       documentation and/or other materials provided with the distribution.\n%     * Neither the name of the <organization> nor the\n%       names of its contributors may be used to endorse or promote products\n%       derived from this software without specific prior written permission.\n%\n% THIS SOFTWARE IS PROVIDED BY <copyright holder> ``AS IS'' AND ANY\n% EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED\n% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE\n% DISCLAIMED. IN NO EVENT SHALL <copyright holder> BE LIABLE FOR ANY\n% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES\n% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;\n% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND\n% ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS\n% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n% \n"},
 "gpl" => 
  {scope: "source.matlab, source.octave",
   name: "GPL",
   content: 
    "%  `if [[ ${TM_FILENAME} != '' ]]; then echo -e \"\\n% ${TM_FILENAME}\\n% \";fi`\n% Copyright (C) `date +%Y` ${TM_FULLNAME}`if [[ ${TM_ORGANIZATION_NAME} != '' ]]; then echo -e \", ${TM_ORGANIZATION_NAME}\";fi`. `if [[ ${TM_EMAIL} != '' ]]; then echo -e \"\\n% ${TM_EMAIL}\";fi``if [[ ${TM_URL} != '' ]]; then echo -e \"\\n% ${TM_URL}\";fi`\n% \n% This program is free software; you can redistribute it and/or\n% modify it under the terms of the GNU General Public License\n% as published by the Free Software Foundation; either version 2\n% of the License, or (at your option) any later version.\n% \n% This program is distributed in the hope that it will be useful,\n% but WITHOUT ANY WARRANTY; without even the implied warranty of\n% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n% GNU General Public License for more details.\n% \n% You should have received a copy of the GNU General Public License\n% along with this program; if not, write to the Free Software\n% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.\n% \n"},
 "octfun" => 
  {scope: "source.matlab",
   name: "Octave function",
   content: 
    "## Copyright (C) ${TM_YEAR} $TM_FULLNAME\n##\n## This program is free software; you can redistribute it and/or modify\n## it under the terms of the GNU General Public License as published by\n## the Free Software Foundation; either version 2 of the License, or\n## (at your option) any later version.\n##\n## This program is distributed in the hope that it will be useful,\n## but WITHOUT ANY WARRANTY; without even the implied warranty of\n## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n## GNU General Public License for more details.\n##\n## You should have received a copy of the GNU General Public License\n## along with this program; If not, see <http://www.gnu.org/licenses/>.\n\n## -*- texinfo -*-\n## @deftypefn {Function File} {${1:Outputs} = } ${2:Function Name} (${3:Input Arguments)\n## ${4:Short Description}\n##\n## ${5:Long Description}\n##\n## @seealso{${6:functions}}\n## @end deftypefn\n\n## Author:  $TM_FULLNAME\n\n$0\n\nendfunction"},
 "^" => 
  {scope: "source.matlab, source.octave", name: "^", content: "^($1) $2"},
 "case" => 
  {scope: "source.matlab, source.octave",
   name: "case",
   content: "case ${2:'${3:string}'}\n\t$0"},
 "clear" => 
  {scope: "source.matlab, source.octave",
   name: "clear",
   content: "clear('${1:all}'$2);"},
 nil => 
  {scope: "source.matlab, source.octave",
   name: "Comment Divide",
   content: 
    "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   $1   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n"},
 "dsp" => 
  {scope: "source.matlab, source.octave",
   name: "disp sprintf",
   content: 
    "disp(sprintf('${1:%s}\\\\n'${1/([^%]|%%)*(%.)?.*/(?2:, :\\);)/}$2${1/([^%]|%%)*(%.)?.*/(?2:\\);)/});"},
 "disp" => 
  {scope: "source.matlab, source.octave",
   name: "disp",
   content: "disp('${1:Text}');"},
 "dlmwrite" => 
  {scope: "source.matlab, source.octave",
   name: "dlmwrite",
   content: 
    "dlmwrite('${1:filename}.dat', [${2:variables}], ${3:'${4:delimiter}', '${5:\\t}'});\n$0"},
 "else" => 
  {scope: "source.matlab, source.octave",
   name: "else",
   content: "else\n\t${1:body}"},
 "elseif" => 
  {scope: "source.matlab, source.octave",
   name: "elseif",
   content: "elseif ${1:condition}\n\t$0"},
 "error" => 
  {scope: "source.matlab, source.octave",
   name: "error",
   content: "error('${1:Description}');"},
 "e" => 
  {scope: "source.matlab, source.octave", name: "exp", content: "exp($1) $2"},
 "fpr" => 
  {scope: "source.matlab, source.octave",
   name: "fprintf",
   content: 
    "fprintf(${1:fid}, '${2:%s}\\\\n'${2/([^%]|%%)*(%.)?.*/(?2:, :\\);)/}$3${2/([^%]|%%)*(%.)?.*/(?2:\\);)/}"},
 "get" => 
  {scope: "source.matlab, source.octave",
   name: "get",
   content: "get(${1:gca},'${2:PropertyName}');"},
 "griddata" => 
  {scope: "source.matlab, source.octave",
   name: "griddata",
   content: "griddata(${1:xx}, ${2:yy}, ${3:zz}, ${4:xi}, ${5:yi}); "},
 "ife" => 
  {scope: "source.matlab, source.octave",
   name: "if … else …end",
   content: 
    "if ${1:condition}\n\t$2\nelse\n\t$3\n`if [[ $TM_USE_OCTAVE -ne '0' ]]\n\tthen echo \"endif\"\nelse\n\techo \"end\"\nfi`"},
 "ifeif" => 
  {scope: "source.matlab , source.octave",
   name: "if … elseif … end",
   content: 
    "if ${1:condition}\n\t${2:body}\nelseif ${3:condition}\n\t${4:body}\nelse\n\t${5:body}\nend\n"},
 "line" => 
  {scope: "source.matlab, source.octave",
   name: "line",
   content: 
    "line(${1:xvector},${2:yvector}${3:,'Color','${4:b}','LineWidth',${5:1},'LineStyle','${6:-}'})\n"},
 "nargchk" => 
  {scope: "source.matlab, source.octave",
   name: "nargchk",
   content: 
    "error(nargchk(${1:min}, ${2:max}, ${3:nargin}, `if [[ $TM_USE_OCTAVE -eq '0' ]]; then\n\techo -n \"'struct'\"\nfi` ));\n"},
 "rev" => 
  {scope: "source.matlab, source.octave",
   name: "Revisions",
   content: 
    "%\tRev. by ${TM_FULLNAME} on `date +%Y-%m-%d`: ${1:Short description}"},
 "set" => 
  {scope: "source.matlab , source.octave",
   name: "set",
   content: 
    "set(${1:get(${2:gca},'${3:PropertyName}')},'${4:PropertyName}',${5:PropertyValue});"},
 "func" => 
  {scope: "source.matlab, source.octave",
   name: "small function",
   content: 
    "%% ${1:functionname}: ${2:function description}\nfunction [${3:outputs}] = ${1}(${4:arg})\n${3/,?\\s*([a-zA-Z]\\w*)|,\\s*/(?1:\\t$1 = ;\\n)/g}"},
 "spr" => 
  {scope: "source.matlab, source.octave",
   name: "sprintf",
   content: 
    "sprintf('${1:%s}\\\\n'${1/([^%]|%%)*(%.)?.*/(?2:, :\\);)/}$2${1/([^%]|%%)*(%.)?.*/(?2:\\);)/}"},
 "switch" => 
  {scope: "source.matlab, source.octave",
   name: "switch ... case ... otherwise ... end",
   content: 
    "switch ${1:switch_expression}\n\tcase ${2:case_expression}\n\t\t${3:body}\n\totherwise\n\t\t${4:body}\nend"},
 "switcho" => 
  {scope: "source.matlab",
   name: "switch … case … otherwise … end",
   content: 
    "switch ${1:var}\ncase ${2:'${3:string}'}\n\t$4\notherwise\n\t$0\n`if [[ $TM_USE_OCTAVE -ne '0' ]]\n\tthen echo \"endswitch\"\nelse\n\techo \"end\"\nfi`"},
 "zla" => 
  {scope: "source.matlab , source.octave",
   name: "zlabel",
   content: "set(get(gca,'ZLabel'),'String',${1:'${2}'});"},
 "try" => 
  {scope: "source.matlab",
   name: "try … catch … end",
   content: 
    "try \n\t$1\ncatch \n\t$0\n`if [[ $TM_USE_OCTAVE -ne '0' ]]\n\tthen echo \"end_try_catch\"\nelse\n\techo \"end\"\nfi`"},
 "uni" => 
  {scope: "source.matlab, source.octave",
   name: "unix",
   content: "[${1:s},${2:w}] = unix('${3:Unix commands}');"},
 "unwind" => 
  {scope: "source.matlab",
   name: "unwind_protect … cleanup … end",
   content: 
    "unwind_protect \n\t$1\nunwnd_protect_cleanup \n\t$0\nend_unwind_protect"},
 "war" => 
  {scope: "source.matlab, source.octave",
   name: "warning",
   content: "warning(['${1:Description}']);"},
 "whi" => 
  {scope: "source.matlab , source.octave",
   name: "while",
   content: "while ${1:condition}\n\t${2:body}\nend\n"},
 "xla" => 
  {scope: "source.matlab , source.octave",
   name: "xlabel",
   content: "set(get(gca,'XLabel'),'String',${1:'${2}'});"},
 "xti" => 
  {scope: "source.matlab , source.octave",
   name: "xtick",
   content: "set(gca,'XTick',${1:[${2}]});"},
 "yla" => 
  {scope: "source.matlab , source.octave",
   name: "ylabel",
   content: "set(get(gca,'YLabel'),'String',${1:'${2}'});"},
 "yti" => 
  {scope: "source.matlab , source.octave",
   name: "ytick",
   content: "set(gca,'YTick',${1:[${2}]});"}}
