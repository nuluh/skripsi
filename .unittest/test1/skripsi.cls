%%
%% This is file `skripsi.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% skripsi.dtx  (with options: `class')
%% ----------------------------------------------------------------
%% thesis --- A Bachelor Thesis class
%% E-mail: you@your.domain
%% Released under the LaTeX Project Public License v1.3c or later
%% See https://www.latex-project.org/lppl.txt
%% ----------------------------------------------------------------
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{skripsi}[2025/05/10 Bachelor Thesis Class]
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
    family=skripsikvopt,
    prefix=skripsikvopt@
}
\DeclareBoolOption[false]{draftmark}
\DeclareBoolOption[true]{primarytitle}
\DeclareBoolOption[true]{secondarytitle}
\DeclareStringOption[3]{sectiondepth}
\DeclareStringOption[3]{tocdepth}
\DeclareStringOption[default]{cover}
\DeclareComplementaryOption{noprimarytitle}{primarytitle}
\DeclareComplementaryOption{nosecondarytitle}{secondarytitle}
\ProcessKeyvalOptions*
\LoadClass[a4paper,12pt,oneside]{book}
\RequirePackage{polyglossia}
\RequirePackage{fontspec}
\RequirePackage{titling}
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{tikzpagenodes}
\usetikzlibrary{calc}
\RequirePackage{svg}
\RequirePackage{etoolbox}
\RequirePackage{tocbibind}
\RequirePackage{indentfirst}
\RequirePackage{float}
\RequirePackage{atbegshi}
\RequirePackage{amsmath,amsfonts,amssymb}
\RequirePackage[backend=biber]{biblatex}
\RequirePackage{hyperref}
\hypersetup{bookmarksopen, bookmarksnumbered=true, bookmarksdepth=3}
\RequirePackage{hyperxmp}
\RequirePackage[acronym, nogroupskip, toc]{glossaries}
\ExecuteBibliographyOptions{
    alltimes=24h,
    datezeros=false,
    dateera=secular,
    dateeraauto=600,
    dateuncertain=true,
    datecirca=true,
    sorting=none,
    url=false,
    doi=false,
    isbn=false
}
\setmainlanguage[variant=indonesian]{malay}
\setotherlanguage{english}
\ifskripsikvopt@draftmark
  \RequirePackage{draftwatermark}
  \DraftwatermarkOptions{%
    text={\sffamily\bfseries
      DRAFT
      \href{https://github.com/nuluh/thesis}{%
        \color{magenta}\fbox{\bfseries\normalsize\texttt{ver.\ 2025.j5}}%
      }%
      \ \normalsize{Copyright~\textcopyright~Rifqi D. Panuluh}%
    },
    color={[gray]{0.8}},
    fontsize=1.5em,
    angle=90,
    hpos=20cm,
    vpos=20cm
  }
  \RequirePackage[left]{lineno}
  \linenumbers
\fi
\newcommand*\skripsi@setup@layout{%
  \geometry{left=4cm, top=3cm, right=3cm, bottom=3cm}%
  \setlength{\parskip}{0.5em}%
}
\skripsi@setup@layout
\defaultfontfeatures{Ligatures=TeX}
\setmainfont{Times New Roman}[
  SmallCapsFont  = {Latin Modern Roman}, % fallback for \textsc
]
\setsansfont{Arial}
\setmonofont{Courier New}
\fancypagestyle{fancy}{%
    \fancyhf{}
    \fancyhead[R]{\nouppercase{\rightmark}}
    \fancyhead[L]{\nouppercase{\leftmark}}
    \fancyfoot[C]{\thepage}
}
\fancypagestyle{fancyplainfrontmatter}{%
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[C]{\thepage}
}
\fancypagestyle{fancyplain}{%
    \fancyhf{}
    \setlength{\headheight}{15pt} % avoid fancyhdr warning
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead[R]{\thepage}
}
\newcounter{savepagenumber}
\renewcommand\mainmatter{%
  \cleardoublepage
  \setcounter{savepagenumber}{\value{page}}
  \@mainmattertrue
  \pagenumbering{arabic}%
}
\renewcommand\backmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \pagenumbering{roman}%
  \setcounter{page}{\value{savepagenumber}}%
  \@mainmatterfalse
}
\RequirePackage{titlesec}
\newcommand*\skripsi@setup@sectioning{%
\titlespacing{\chapter}{0pt}{-0pt}{*1}
\titleformat{\chapter}[display]
  {\normalsize\bfseries\centering}
  {\MakeUppercase\chaptername~\Roman{chapter}}
  {1ex}
  {\MakeUppercase}
\titleformat{\section}
    {\normalsize\bfseries}{\thesection}{1em}{}
\titleformat{\subsection}
    {\normalsize\bfseries}{\thesubsection}{1em}{}
\titlespacing{\section}{0em}{*1}{*1}
\setcounter{secnumdepth}{3}
}
\skripsi@setup@sectioning
\makeatletter
\let\original@maketitle\maketitle

\renewcommand{\maketitle}{%
  \ifskripsikvopt@primarytitle
    \ifdefstring{\skripsikvopt@cover}{legacy}{%
      \original@maketitle
      \IfFileExists{frontmatter/maketitle.tex}{%
      \ClassWarning{skripsi.cls}{Omit 'cover=legacy' option to use
                    user-defined primary cover page
                    'frontmatter/maketitle.tex'}
      }{}%
    }{%
      \IfFileExists{frontmatter/maketitle.tex}{%
        \input{frontmatter/maketitle}%
        \ClassWarning{skripsi.cls}{Using user-defined cover page
                      'frontmatter/maketitle.tex'}%
      }{%
      \ifdefined\thetitle\else \ClassError{skripsi.cls}{Missing \protect\title}{}\fi
      \ifdefined\theauthor\else \ClassError{skripsi.cls}{Missing \protect\author}{}\fi
      \ifdefined\thedate\else \ClassError{skripsi.cls}{Missing \protect\date}{}\fi
      \@check{program}
      \@check{faculty}
      \@check{university}
      \@check{yearofsubmission}
        {%
          \begin{titlepage}
          \newgeometry{margin=3cm}%
          \noindent
          \begin{minipage}[t][0.49\textheight][t]{\textwidth}
          \centering
          {\fontsize{14pt}{16pt}\selectfont \textbf{\MakeUppercase{Tugas Akhir}}\par}
          \vspace{1.5cm}
          {\fontsize{14pt}{16pt}\selectfont \textbf{\MakeUppercase{\thetitle}}\par}
          \vfill
          \end{minipage}
          \begin{tikzpicture}[remember picture, overlay]
              % This respects your geometry margins
              \coordinate (center) at (current page text area.center);

              % The logo at center of page (ANCHOR POINT) shift up by 1cm
              \node at ($(center) + (0cm,1cm)$)
              {\includegraphics[width=5cm]{frontmatter/img/logo.png}};

              % --- Option A: diagonal across the whole paper ---
              % \draw[red, line width=1pt] (current page.north west) -- (current page.south east);
              % \draw[red, line width=1pt] (current page.north east) -- (current page.south west);
              % % horizontal and vertical
              % \draw[blue, line width=1pt] (current page.north) -- (current page.south);
              % \draw[blue, line width=1pt] (current page.west) -- (current page.east);
              % % horizontal line with 1cm up offset
              % \draw[green, line width=1pt] ($(current page.west) + (0cm,1cm)$) -- ($(current page.east) + (0cm,1cm)$);

          \end{tikzpicture}%
          \begin{minipage}[b][0.49\textheight][b]{\textwidth}
          \centering

          \vfill

          \textbf{Disusun oleh:} \\
          {\fontsize{14pt}{16pt}\selectfont \textbf{\theauthor}} \\
          {\fontsize{14pt}{16pt}\selectfont \textbf{\theauthorid}} \\

          \vfill

          {\fontsize{12pt}{14pt}\selectfont
          \textbf{\MakeUppercase\theprogram} \\
          \textbf{\MakeUppercase\thefaculty} \\
          \textbf{\MakeUppercase\theuniversity} \\
          \textbf{\theyearofsubmission}
          }
          \end{minipage}
          \end{titlepage}%
        }
      }%
    }%
  \else
      \IfFileExists{frontmatter/maketitle.tex}{%
        \ClassWarning{skripsi.cls}{Omit 'noprimarytitle' option to use
                      user-defined cover page
                      'frontmatter/maketitle.tex'}%
      }{}%
  \fi
  \ifskripsikvopt@secondarytitle
    \clearpage
    \IfFileExists{frontmatter/maketitle_secondary.tex}{%
      \input{frontmatter/maketitle_secondary}%
      \ClassWarning{skripsi.cls}{Using user-defined secondary cover page}
    }{%
      {%
        \begin{titlepage}
        \newgeometry{margin=3cm, left=4cm}
        \noindent
        \begin{minipage}[t][0.49\textheight][t]{\textwidth}
        \centering
        {\fontsize{14pt}{16pt}\selectfont \textbf{\MakeUppercase{Tugas Akhir}}\par}
        \vspace{1.5cm}
        {\fontsize{14pt}{16pt}\selectfont \textbf{\MakeUppercase{\thetitle}}\par}
        \vspace{1cm}
        {\normalsize\selectfont Diajukan guna melengkapi persyaratan untuk memenuhi gelar Sarjana Teknik di Program Studi Teknik Sipil, Fakultas Teknik, Universitas Muhammadiyah Yogyakarta\par}
        \vfill
        \end{minipage}
        \begin{tikzpicture}[remember picture, overlay]
            % This respects your geometry margins
            \coordinate (center) at (current page text area.center);

            % The logo at center of page (ANCHOR POINT) shift up by 1cm
            \node at ($(center) + (0cm,1cm)$)
                {\includegraphics[width=5cm]{frontmatter/img/logo.png}};

            % --- Option A: diagonal across the whole paper ---
            % \draw[red, line width=1pt] (current page.north west) -- (current page.south east);
            % \draw[red, line width=1pt] (current page.north east) -- (current page.south west);
            % % horizontal and vertical
            % \draw[blue, line width=1pt] (current page.north) -- (current page.south);
            % \draw[blue, line width=1pt] (current page.west) -- (current page.east);
            % % horizontal line with 1cm up offset
            % \draw[green, line width=1pt] ($(current page.west) + (0cm,1cm)$) -- ($(current page.east) + (0cm,1cm)$);
        \end{tikzpicture}%
        \begin{minipage}[b][0.49\textheight][b]{\textwidth}
        \centering
        \vfill

        \textbf{Disusun oleh:} \\
        {\fontsize{14pt}{16pt}\selectfont \textbf{\theauthor}} \\
        {\fontsize{14pt}{16pt}\selectfont \textbf{\theauthorid}} \\
        \vfill
        {\fontsize{12pt}{14pt}\selectfont
        \textbf{\MakeUppercase\theprogram} \\
        \textbf{\MakeUppercase\thefaculty} \\
        \textbf{\MakeUppercase\theuniversity} \\
        \textbf{\theyearofsubmission}
        }
        \end{minipage}
        \end{titlepage}%
      }
      \ClassWarning{skripsi.cls}{File frontmatter/maketitle_secondary.tex
                    not found, using embedded secondary cover page}%
    }%
  \else
      \IfFileExists{frontmatter/maketitle_secondary.tex}{%
        \ClassWarning{skripsi.cls}{Omit 'nosecondarytitle' option to use
                      user-defined secondary cover page
                      'frontmatter/maketitle_secondary.tex'}%
      }{}%
  \fi
}
\RequirePackage{tocloft}
\renewcommand{\cftchappresnum}{\MakeUppercase\chaptername~}
\renewcommand{\cftchapaftersnum}{\quad}
\renewcommand{\cftchapfont}{\normalsize\MakeUppercase}
\makeatletter
\patchcmd{\l@chapter}
  {\cftchapfont #1}% original
  {\cftchapfont{#1}}% patched
  {}{}            % success/failure handlers
\makeatother
\setlength{\cftbeforetoctitleskip}{0cm}
\setlength{\cftbeforeloftitleskip}{0cm}
\setlength{\cftbeforelottitleskip}{0cm}
\setlength{\cftbeforechapskip}{0em}
\setlength{\cftchapindent}{0pt}
\setlength{\cftsecindent}{0em}
\setlength{\cftsubsecindent}{2em}
\setlength{\cftchapnumwidth}{3.5em}
\setlength{\cftsecnumwidth}{2em}
\setlength{\cftsubsecnumwidth}{2.5em}
\setlength{\cftfignumwidth}{6em}
\setlength{\cfttabnumwidth}{4em}
\renewcommand \cftchapdotsep{1}
\renewcommand \cftsecdotsep{1}
\renewcommand \cftsubsecdotsep{1}
\renewcommand \cftfigdotsep{1.5}
\renewcommand \cfttabdotsep{1.5}
\renewcommand{\cftchapleader}{\normalfont\cftdotfill{\cftsecdotsep}}
\renewcommand{\cftchappagefont}{\normalfont}
\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand\thesection{\arabic{chapter}.\arabic{section}}
\renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure}}
\renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}
\renewcommand{\cftfigpresnum}{\figurename~}
\renewcommand{\cfttabpresnum}{\tablename~}
\renewcommand{\cfttoctitlefont}{\hfill\bfseries\MakeUppercase}
\renewcommand{\cftaftertoctitle}{\hfill} % https://tex.stackexchange.com/a/255699/394075
\renewcommand{\cftloftitlefont}{\hfill\bfseries\MakeUppercase}
\renewcommand{\cftafterloftitle}{\hfill}
\renewcommand{\cftlottitlefont}{\hfill\bfseries\MakeUppercase}
\renewcommand{\cftafterlottitle}{\hfill}
\makeatletter
\setcounter{tocdepth}{\skripsikvopt@tocdepth}
\makeatother
\def\listterminator{;}
\makeatletter
\newcommand\alphabubblesort[1]{\def\presorted{}\def\sortedlist{}%
  \sortlist#1,\listterminator,\relax}
\def\sortlist#1#2,#3#4,#5\relax{%
  \if\listterminator#3#4\relax%
    \expandafter\def\expandafter\sortedlist\expandafter{\sortedlist#1#2}%
  \else
    \ifnum\the\lccode`#1<\the\lccode`#3\relax%
      \expandafter\expandafter\expandafter\def\expandafter\expandafter%
      \expandafter\sortedlist\expandafter\expandafter\expandafter{%
      \expandafter\sortedlist\presorted#1#2, }%
      \expandafter\def\expandafter\svfirst\expandafter{\presorted#3#4}%
      \def\presorted{}%
      \expandafter\sortlist\svfirst,#5\relax%
    \else%
      \ifnum`#1=`#3\relax%
        \ifx\relax#2\relax%
          \expandafter\expandafter\expandafter\def\expandafter\expandafter%
          \expandafter\sortedlist\expandafter\expandafter\expandafter{%
          \expandafter\sortedlist\presorted#1#2, }%
          \expandafter\def\expandafter\svfirst\expandafter{\presorted#3#4}%
          \def\presorted{}%
          \expandafter\sortlist\svfirst,#5\relax%
        \else%
          \ifx\relax#4\relax%
            \expandafter\expandafter\expandafter\def\expandafter\expandafter%
            \expandafter\sortedlist\expandafter\expandafter\expandafter{%
            \expandafter\sortedlist\presorted#3#4, }%
            \expandafter\def\expandafter\svfirst\expandafter{\presorted#1#2}%
            \def\presorted{}%
            \expandafter\sortlist\svfirst,#5\relax%
          \else
            \g@addto@macro\presorted{#1}%
            \sortlist#2,#4,#5\relax%
          \fi%
        \fi%
      \else%
        \let\tmp\sortedlist%
        \def\sortedlist{}%
        \expandafter\def\expandafter\svfirst\expandafter{\presorted#3#4}%
        \expandafter\def\expandafter\svsecond\expandafter{\presorted#1#2}%
        \def\presorted{}%
        \expandafter\expandafter\expandafter\expandafter\expandafter%
        \expandafter\expandafter\sortlist\expandafter\expandafter%
        \expandafter\tmp\expandafter\svfirst\expandafter,\svsecond,#5\relax%
      \fi%
    \fi%
  \fi%
  }
\newcommand{\keywords}[1]{%
  \bigskip\noindent
  \alphabubblesort{#1}
  \ifnum\strcmp{\languagename}{malay}=0
  Kata Kunci: \sortedlist%
  \else
    \textit{Keywords: \sortedlist}%
  \fi
  \gdef\SortedKeywords{\sortedlist} \pdfstringdef\kwpdf{\SortedKeywords}%
  \immediate\special{pdf:docinfo << /Keywords (\kwpdf) >>}%

  \hypersetup{pdfkeywords={\SortedKeywords}}%
}
\makeatother
\makeatletter
\newcommand{\@authorid}{}
\newcommand{\@firstadvisor}{}
\newcommand{\@secondadvisor}{}
\newcommand{\@firstexaminer}{}
\newcommand{\@secondexaminer}{}
\newcommand{\@headdepartement}{}
\newcommand{\@headdepartementid}{}
\newcommand{\@faculty}{}
\newcommand{\@program}{}
\newcommand{\@university}{}
\newcommand{\@yearofsubmission}{}
\newcommand{\authorid}[1]{\gdef\@authorid{#1}}
\newcommand{\firstadvisor}[1]{\gdef\@firstadvisor{#1}}
\newcommand{\secondadvisor}[1]{\gdef\@secondadvisor{#1}}
\newcommand{\firstexaminer}[1]{\gdef\@firstexaminer{#1}}
\newcommand{\secondexaminer}[1]{\gdef\@secondexaminer{#1}}
\newcommand{\headdepartement}[1]{\gdef\@headdepartement{#1}}
\newcommand{\headdepartementid}[1]{\gdef\@headdepartementid{#1}}
\newcommand{\faculty}[1]{\gdef\@faculty{#1}}
\newcommand{\program}[1]{\gdef\@program{#1}}
\newcommand{\university}[1]{\gdef\@university{#1}}
\newcommand{\yearofsubmission}[1]{\gdef\@yearofsubmission{#1}}
\newcommand{\theauthorid}{\@authorid}
\newcommand{\thefirstadvisor}{\@firstadvisor}
\newcommand{\thesecondadvisor}{\@secondadvisor}
\newcommand{\thefirstexaminer}{\@firstexaminer}
\newcommand{\thesecondexaminer}{\@secondexaminer}
\newcommand{\theheaddepartement}{\@headdepartement}
\newcommand{\theheaddepartementid}{\@headdepartementid}
\newcommand{\thefaculty}{\@faculty}
\newcommand{\theprogram}{\@program}
\newcommand{\theuniversity}{\@university}
\newcommand{\theyearofsubmission}{\@yearofsubmission}
\newcommand{\@check}[1]{%
  \expandafter\ifdefstring\expandafter{\csname @#1\endcsname}{}{%
    \ClassError{skripsi.cls}{Missing \protect#1}%
      {You must declare \protect#1{...} in preamble}%
  }%
}
\makeatother
%% 
%% Copyright (C) 2025
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License (LPPL), either
%% version 1.3c of this license or (at your option) any later
%% version.  The latest version of this license is in the file:
%% 
%% https://www.latex-project.org/lppl.txt
%% 
%% This work is "maintained" (as per LPPL maintenance status) by
%% You.
%% 
%% This work consists of the file  thesis.dtx
%% and the derived files           thesis.ins,
%%                                 thesis.pdf and
%%                                 thesis.cls.
%% 
%%
%% End of file `skripsi.cls'.
