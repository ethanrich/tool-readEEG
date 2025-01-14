########################################################################
##
## Copyright (C) 2016-2022 The Octave Project Developers
##
## See the file COPYRIGHT.md in the top-level directory of this
## distribution or <https://octave.org/copyright/>.
##
## This file is part of Octave.
##
## Octave is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## Octave is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <https://www.gnu.org/licenses/>.
##
########################################################################

## -*- texinfo -*-
## @deftypefn {} {@var{outstr} =} __publish_latex_output__ (@var{type}, @var{varargin})
##
## Internal function.
##
## The first input argument @var{type} defines the required strings
## (@samp{str}) or cell-strings (@samp{cstr}) in @var{varargin} in order
## to produce @LaTeX{} output.
##
## @var{type} is one of
##
## @itemize @bullet
## @item
## @samp{output_file_extension} ()
##
## @item
## @samp{header} (title_str, intro_str, toc_cstr)
##
## @item
## @samp{footer} ()
##
## @item
## @samp{code} (str)
##
## @item
## @samp{code_output} (str)
##
## @item
## @samp{section} (str)
##
## @item
## @samp{preformatted_code} (str)
##
## @item
## @samp{preformatted_text} (str)
##
## @item
## @samp{bulleted_list} (cstr)
##
## @item
## @samp{numbered_list} (cstr)
##
## @item
## @samp{graphic} (str)
##
## @item
## @samp{html} (str)
##
## @item
## @samp{latex} (str)
##
## @item
## @samp{text} (str)
##
## @item
## @samp{blockmath} (str)
##
## @item
## @samp{inlinemath} (str)
##
## @item
## @samp{bold} (str)
##
## @item
## @samp{italic} (str)
##
## @item
## @samp{monospaced} (str)
##
## @item
## @samp{link} (url_str, url_str, str)
##
## @item
## @samp{TM} ()
##
## @item
## @samp{R} ()
##
## @item
## @samp{escape_special_chars} (str)
## @end itemize
## @end deftypefn

function outstr = __publish_latex_output__ (type, varargin)
  outstr = feval (["do_" type], varargin{:});
endfunction

function outstr = do_output_file_extension ()
  outstr = ".tex";
endfunction

function outstr = do_header (title_str, intro_str, toc_cstr)

  publish_comment = sprintf ("%s\n",
"",
"",
"% This document was generated by the publish-function",
["% from GNU Octave " version()],
"");

  latex_preamble = sprintf ("%s\n",
"",
"",
'\documentclass[10pt]{article}',
'\usepackage{listings}',
'\usepackage{mathtools}',
'\usepackage{amssymb}',
'\usepackage{graphicx}',
'\usepackage{hyperref}',
'\usepackage{xcolor}',
'\usepackage{titlesec}',
'\usepackage[utf8]{inputenc}',
'\usepackage[T1]{fontenc}',
'\usepackage{lmodern}');

  ## "lstlisting" doesn't support multi-byte UTF-8 characters.
  ## Add substitution rules for some characters (commonly used in languages with
  ## Latin-based script).
  ## Set of substitions taken from:
  ## https://en.wikibooks.org/w/index.php?title=LaTeX/Source_Code_Listings&oldid=3815132#Encoding_issue
  ## FIXME: Any multi-byte UTF-8 character in a non-section comment without a
  ##        substitution rule will still cause an error.  This should be fixed
  ##        more generally, or a way how to work around this limitation should
  ##        be documented.
  listings_option = sprintf ("%s\n",
"",
"",
'\lstset{',
'language=Octave,',
'numbers=none,',
'frame=single,',
'tabsize=2,',
'showstringspaces=false,',
'breaklines=true,',
'inputencoding=utf8,',
'extendedchars=true,',
'literate=',
'  {á}{{\''a}}1 {é}{{\''e}}1 {í}{{\''i}}1 {ó}{{\''o}}1 {ú}{{\''u}}1',
'  {Á}{{\''A}}1 {É}{{\''E}}1 {Í}{{\''I}}1 {Ó}{{\''O}}1 {Ú}{{\''U}}1',
'  {à}{{\`a}}1 {è}{{\`e}}1 {ì}{{\`i}}1 {ò}{{\`o}}1 {ù}{{\`u}}1',
'  {À}{{\`A}}1 {È}{{\''E}}1 {Ì}{{\`I}}1 {Ò}{{\`O}}1 {Ù}{{\`U}}1',
'  {ä}{{\"a}}1 {ë}{{\"e}}1 {ï}{{\"i}}1 {ö}{{\"o}}1 {ü}{{\"u}}1',
'  {Ä}{{\"A}}1 {Ë}{{\"E}}1 {Ï}{{\"I}}1 {Ö}{{\"O}}1 {Ü}{{\"U}}1',
'  {â}{{\^a}}1 {ê}{{\^e}}1 {î}{{\^i}}1 {ô}{{\^o}}1 {û}{{\^u}}1',
'  {Â}{{\^A}}1 {Ê}{{\^E}}1 {Î}{{\^I}}1 {Ô}{{\^O}}1 {Û}{{\^U}}1',
'  {ã}{{\~a}}1 {ẽ}{{\~e}}1 {ĩ}{{\~i}}1 {õ}{{\~o}}1 {ũ}{{\~u}}1',
'  {Ã}{{\~A}}1 {Ẽ}{{\~E}}1 {Ĩ}{{\~I}}1 {Õ}{{\~O}}1 {Ũ}{{\~U}}1',
'  {œ}{{\oe}}1 {Œ}{{\OE}}1 {æ}{{\ae}}1 {Æ}{{\AE}}1 {ß}{{\ss}}1',
'  {ű}{{\H{u}}}1 {Ű}{{\H{U}}}1 {ő}{{\H{o}}}1 {Ő}{{\H{O}}}1',
'  {ç}{{\c c}}1 {Ç}{{\c C}}1 {ø}{{\o}}1 {å}{{\r a}}1 {Å}{{\r A}}1',
'  {€}{{\euro}}1 {£}{{\pounds}}1 {«}{{\guillemotleft}}1',
'  {»}{{\guillemotright}}1 {ñ}{{\~n}}1 {Ñ}{{\~N}}1 {¿}{{?`}}1 {¡}{{!`}}1',
'}');

  latex_head = sprintf ("%s\n",
"",
"",
'\titleformat*{\section}{\Huge\bfseries}',
'\titleformat*{\subsection}{\large\bfseries}',
'\renewcommand{\contentsname}{\Large\bfseries Contents}',
'\setlength{\parindent}{0pt}',
"",
'\begin{document}',
"",
['{\Huge\section*{' title_str '}}'],
"",
'\tableofcontents',
'\vspace*{4em}',
"");

  outstr = [publish_comment, latex_preamble, listings_option, latex_head];

endfunction

function outstr = do_footer (m_source_str)
  outstr = ["\n\n" '\end{document}' "\n"];
endfunction

function outstr = do_code (str)
  outstr = ['\begin{lstlisting}' "\n", str, "\n" '\end{lstlisting}' "\n"];
endfunction

function outstr = do_code_output (str)
  outstr = sprintf ("%s\n",
'\begin{lstlisting}[language={},xleftmargin=5pt,frame=none]',
str,
'\end{lstlisting}');
endfunction

function outstr = do_section (str)
  outstr = sprintf ("%s\n",
"",
"",
'\phantomsection',
['\addcontentsline{toc}{section}{' str '}'],
['\subsection*{' str '}'],
"");
endfunction

function outstr = do_preformatted_code (str)
  outstr = sprintf ("%s\n",
'\begin{lstlisting}',
str,
'\end{lstlisting}');
endfunction

function outstr = do_preformatted_text (str)
  outstr = sprintf ("%s\n",
'\begin{lstlisting}[language={}]',
str,
'\end{lstlisting}');
endfunction

function outstr = do_bulleted_list (cstr)

  outstr = ["\n" '\begin{itemize}' "\n"];
  for i = 1:numel (cstr)
    outstr = [outstr, '\item ' cstr{i} "\n"];
  endfor
  outstr = [outstr, '\end{itemize}' "\n"];

endfunction

function outstr = do_numbered_list (cstr)

  outstr = ["\n" '\begin{enumerate}' "\n"];
  for i = 1:numel (cstr)
    outstr = [outstr, '\item ' cstr{i} "\n"];
  endfor
  outstr = [outstr, "\\end{enumerate}\n"];

endfunction

function outstr = do_graphic (str)
  outstr = sprintf ("%s\n",
'\begin{figure}[!ht]',
['\includegraphics[width=\textwidth]{' str '}'],
'\end{figure}');
endfunction

function outstr = do_html (str)
  outstr = "";
endfunction

function outstr = do_latex (str)
  outstr = ["\n" str "\n"];
endfunction

function outstr = do_link (url_str, str)
  outstr = ['\href{' url_str '}{' str '}'];
endfunction

function outstr = do_text (str)
  outstr = ["\n\n" str "\n\n"];
endfunction

function outstr = do_blockmath (str)
  outstr = ["$$" str "$$"];
endfunction

function outstr = do_inlinemath (str)
  outstr = ["$" str "$"];
endfunction

function outstr = do_bold (str)
  outstr = ['\textbf{' str '}'];
endfunction

function outstr = do_italic (str)
  outstr = ['\textit{' str '}'];
endfunction

function outstr = do_monospaced (str)
  outstr = ['\texttt{' str '}'];
endfunction

function outstr = do_TM ()
  outstr = '\texttrademark ';
endfunction

function outstr = do_R ()
  outstr = '\textregistered ';
endfunction

function str = do_escape_special_chars (str)

  ## Escape \, {, }, &, %, #, _, ~, ^, <, >
  str = regexprep (str, '\\', "\\ensuremath{\\backslash}");
  str = regexprep (str, '(?<!\\)(\{|\}|&|%|#|_)', '\\$1');
  ## Revert accidental {} replacements for backslashes
  str = strrep (str, '\ensuremath\{\backslash\}', '\ensuremath{\backslash}');
  str = regexprep (str, '(?<!\\)~', "\\ensuremath{\\tilde{\\;}}");
  str = regexprep (str, '(?<!\\)\^', "\\^{}");
  str = regexprep (str, '(?<!\\)<', "\\ensuremath{<}");
  str = regexprep (str, '(?<!\\)>', "\\ensuremath{>}");

endfunction
