%% Start of file `resume.cls'.
% Résumé Class File
%
% This class has been downloaded from:
% https://github.com/billryan/resume
%
% Author:
% Bin "Bill" Yuan <yuanbin2014@gmail.com>
%
% Adapted to be a Quarto template by Mitchell O'Hara-Wild
%
% Class license:
% MIT (https://github.com/billryan/resume/blob/master/LICENSE)
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2015/05/25 An elegant Résumé class]
\LoadClass[11pt]{article}

% disable indent globally
\setlength{\parindent}{0pt}
% some general improvements, defines the XeTeX logo
\RequirePackage{xltxtra}
% use xifthen
\RequirePackage{xifthen}
% use hyperlink for email and url
\RequirePackage{hyperref}
\hypersetup{hidelinks}
\RequirePackage{url}
\urlstyle{tt}
% LOCAL: upstream loads the legacy `fontawesome` package (v4) and hand-rolls
% \email/\phone/\linkedin/\github/\homepage on top of its own glyph names.
% fontawesome5's \faIcon{name} interface is used instead, matching how the
% rest of the quarto-vitae org draws contact icons (see awesome-cv.cls and
% latexcv-preamble.tex), so the same icon name means the same glyph everywhere
% a CV written for this org is rendered.
\RequirePackage{fontawesome5}
% use xcolor for customizing color
\RequirePackage{xcolor}
% LOCAL: no upstream equivalent -- needed for \setstretch, which backs the
% `linestretch` option every Quarto pdf format exposes (see font-settings and
% the main body in resume.tex). Upstream's single-page design never needed it.
\RequirePackage{setspace}
% loading fonts
\RequirePackage{fontspec}
% LOCAL: upstream's \setmainfont points `Path = fonts/Main/` at four .otf
% faces it expects to ship beside the class, plus a fifth (Fontin-SmallCaps)
% grafted on purely to give \scshape a real small-caps glyph set, since TeX
% Gyre Termes has none of its own. None of those five files are carried by
% this port -- only the FontAwesome webfont is -- so the upstream call would
% fail to find its fonts. TeX Gyre Termes is an ordinary font on any TeX
% installation (the `tex-gyre` package), so it is loaded by name here, and
% left to Quarto's own `mainfont` metadata to override in resume-preamble.tex
% via font-settings.latex(), the same way every other quarto-vitae template
% exposes its body font. \scshape falls back to LaTeX's ordinary small-caps
% substitution warning rather than upstream's dedicated small-caps face; see
% the extension's README for this known cosmetic gap.
\setmainfont{TeX Gyre Termes}

\RequirePackage[
	a4paper,
	left=0.8in,
	right=0.8in,
	top=0.70in,
	bottom=0.55in,
	nohead
]{geometry}

\RequirePackage{titlesec}
\RequirePackage{enumitem}
\setlist{noitemsep} % removes spacing from items but leaves space around the whole list
%\setlist{nosep} % removes all vertical spacing within and around the list
\setlist[itemize]{topsep=0.25em, leftmargin=1.5pc}
\setlist[enumerate]{topsep=0.25em, leftmargin=1.5pc}
\RequirePackage[super]{nth}

% LOCAL: no upstream equivalent. Exposed as the `headcolor` YAML option (the
% same name every other quarto-vitae template uses), and given a black default
% here so a document that never sets it renders identically to upstream: the
% title rule and every entry's flush-right date are black either way, this
% just gives resume-preamble.tex a colour to redefine when one is set.
\definecolor{accent}{HTML}{000000}

\titleformat{\section}         % Customise the \section command
  {\Large\scshape\raggedright} % Make the \section headers large (\Large),
                               % small capitals (\scshape) and left aligned (\raggedright)
  {}{0em}                      % Can be used to give a prefix to all sections, like 'Section ...'
  {}                           % Can be used to insert code before the heading
  % LOCAL: wrapped in \color{accent} (upstream draws a plain black rule) so
  % that `headcolor` reaches something on the page even though this design
  % otherwise has no colour of its own.
  [{\color{accent}\titlerule}] % Inserts a horizontal line after the heading
\titlespacing*{\section}{0cm}{*1.8}{*1.8}

\titleformat{\subsection}
  {\large\raggedright}
  {}{0em}
  {}
\titlespacing*{\subsection}{0cm}{*1.8}{*0.6}

\newcommand{\datedsection}[2]{%
  \section[#1]{#1 \hfill \textcolor{accent}{#2}}%
}
\newcommand{\datedsubsection}[2]{%
  \subsection[#1]{#1 \hfill \textcolor{accent}{#2}}%
}
\newcommand{\datedline}[2]{%
  {\par #1 \hfill \textcolor{accent}{#2} \par}%
}

\newcommand{\name}[1]{
  \centerline{\Huge\scshape{#1}}
  \vspace{1.25ex}
}

% defines one's name
% usage: \name{<name>}
\newcommand{\nameTest}[1]{
  {\large\scshape{#1}}
}

% LOCAL: upstream's contact macros (\email, \phone, \github, ...) each build
% one service's link by hand. These are replaced by one generic macro, since
% quarto-vitae's `social` front matter is normalised by the curriculum filter
% into icon, url and label for every service.
%
% usage: \ressocial{<fontawesome icon>}{<url, may be empty>}{<label>}
\newcommand{\ressocial}[3]{%
  \faIcon{#1}\ \ifx\relax#2\relax#3\else\href{#2}{#3}\fi}

\newcommand{\basicInfo}[1]{
  \centerline{\sffamily\large{#1}}
  \vspace{1.5ex}
}

\newcommand{\role}[2]{
  {\par \textit{#1} ~ #2 \par}
  \vspace{0.85ex}
}

% LOCAL: no upstream equivalent. Builds the `\basicInfo` contact line from
% the `social` items, joined by
% \rescontactsep, the same way awesome-cv.cls's \acvHeaderSocialSep and
% latexcv-preamble.tex's \cvcontactsep separate an optional set of fields.
% resume-preamble.tex calls \rescontact once per field present; this file only
% owns the separator and the "is this the first one" bookkeeping.
\newif\ifresfirstcontact
\resfirstcontacttrue
\newcommand{\rescontactsep}{~\textperiodcentered~}
\newcommand{\rescontact}[1]{%
  \ifresfirstcontact\resfirstcontactfalse\else\rescontactsep\fi
  #1}
