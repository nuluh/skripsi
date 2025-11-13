\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{skripsi}[2025/05/10 Bachelor Thesis Class]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
    family=skripsikvopt,
    prefix=skripsikvopt@
}

% key-value options
\DeclareBoolOption[false]{draftmark}
\DeclareBoolOption[true]{primarytitle}
\DeclareBoolOption[true]{secondarytitle}
% section number depth and tocdepth
\DeclareStringOption[3]{sectiondepth}
\DeclareStringOption[3]{tocdepth}
\DeclareStringOption[fixed]{pnumwidth}
% cover page style
\DeclareStringOption[default]{cover}  % default is 'custom'

% Add complementary options for the "no" versions
\DeclareComplementaryOption{noprimarytitle}{primarytitle}
\DeclareComplementaryOption{nosecondarytitle}{secondarytitle}

\ProcessKeyvalOptions*

\LoadClass[a4paper,12pt,oneside]{book}

% Load common packages
\RequirePackage{polyglossia}
\RequirePackage{fontspec}
\RequirePackage{titlesec}
\RequirePackage{titling}
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{graphicx}
\RequirePackage{svg}
\RequirePackage{etoolbox}
\RequirePackage[titles]{tocloft}
\RequirePackage{tocbibind}
\RequirePackage{indentfirst}
\RequirePackage{float}
\RequirePackage{atbegshi}
\RequirePackage{amsmath,amsfonts,amssymb}
\RequirePackage[style=apa,%
                % dateabbrev=false,% when false, don't abbreviate months/year divisions
                % julian=true,% convert dates before gregorianstart to Julian Calendar
                % gregorianstart=1582-10-15,% Default
                % alldates=short,%
                % alldates=ymd,% Year-Month-Day format
                % alldates=iso,% ISO8601 format
                % alldatesusetime=true, % print time components in non-compact date ranges
                % alltimes=12h,%
                alltimes=24h,% prints 24 hour format times (default)
                % alltimes=24hcomp,% prints 24 hour compressed format times
                % seconds=true,% uncomment to print seconds
                % timezones=true,% uncomment to print timezones
                datezeros=false,% pad date components with zeros?
                dateera=secular,% prints BCE/CE controlled by dateerauto, datezeros
                % dateera=christian,% prints BC/AD controlled by dateerauto, datezeros
                % dateera=astronomical,% prints astronomical dates, controlled by datezeros
                dateeraauto=600,% Sets the max year ceiling for automatic printing of era
                % abbreviate=false,% prints full date localisation strings
                dateuncertain=true,%
                datecirca=true,%
                sorting=none,%
                url=false,%
                doi=false,%
                isbn=false,%
                backend=biber]{biblatex}
\RequirePackage[bookmarksopen, bookmarksnumbered, bookmarksdepth=3]{hyperref}
\RequirePackage{hyperxmp}
\RequirePackage[acronym, nogroupskip, toc]{glossaries}
% \RequirePackage{glossaries-extra}
% \RequirePackage{hyperxmp}

% Polyglossia set language
\setmainlanguage[variant=indonesian]{malay}
\setotherlanguages{english}

% Change "Bibliography" to "Daftar Pustaka" for book class
% \DefineBibliographyStrings{english}{%
% andothers={dkk\adddot},
% pages    ={hlm\adddot},
% }


% \DefineBibliographyStrings{english}{
%   bibliography = {Daftar Pustaka},
% }

% \DefineBibliographyStrings{american-apa}{%
%     bibliography = {Daftar Pustaka},
% }
% \renewcommand{\bibname}{DAFTAR PUSTAKA}

% Conditionally load the watermark package and settings
\ifskripsikvopt@draftmark
  \RequirePackage{draftwatermark}
  % All watermark settings in one place:
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
    % hanchor=c,
    hpos=20cm,
    % vanchor=m,
    vpos=20cm
  }
  \RequirePackage[left]{lineno}
  \linenumbers
\fi

% Page layout
\geometry{left=4cm, top=3cm, right=3cm, bottom=3cm}
\setlength{\parskip}{0.5em}
% \setlength{\parindent}{0pt}

% Fonts
\defaultfontfeatures{Ligatures=TeX}
\setmainfont{Times New Roman}[
  SmallCapsFont  = {Latin Modern Roman}, % fallback for \textsc
]
\setsansfont{Arial}
\setmonofont{Courier New}

% % Header and footer
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
% Some LaTeX commands, like \chapter and \chapter*, use the \thispagestyle command to automatically switch to the plain page style, thus ignoring the page style currently in effect. To customize even such pages you must redefine the plain pagestyle. And current 'plain' style by default has correct format. This following command only used for non-chapter-page
\fancypagestyle{fancyplain}{%
    \fancyhf{}
    \setlength{\headheight}{15pt} % to avoid fancyhdr warning
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead[R]{\thepage}
}

% change the behaviour of \backmatter to change page number into roman by continue frontmatter page counter (modified from original book.cls)
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

% Chapter formatting
\titlespacing{\chapter}{0pt}{0cm}{*1.5}

\titleformat{\chapter}[display]
  {\normalsize\bfseries\centering}
  {\MakeUppercase\chaptername~\Roman{chapter}} % << display format
  {1ex}
  {\MakeUppercase}
\titleformat{\section}
    {\normalsize\bfseries}{\thesection}{1em}{}

\titleformat{\subsection}
    {\normalsize\bfseries}{\thesubsection}{1em}{}

% Section numbering depth
\makeatletter
\setcounter{secnumdepth}{\skripsikvopt@sectiondepth}
\makeatother

% Ensure chapter reference in TOC matches
\renewcommand{\cftchappresnum}{\MakeUppercase\chaptername~}
\renewcommand{\cftchapaftersnum}{\quad}

% Redefine \maketitle
% Save the original \maketitle before redefining it
\makeatletter
\let\original@maketitle\maketitle

\renewcommand{\maketitle}{%
  \ifskripsikvopt@primarytitle
    % Check if user explicitly wants default
    \ifdefstring{\skripsikvopt@cover}{legacy}{%
      % Use original book \maketitle
      \original@maketitle
      \IfFileExists{frontmatter/maketitle.tex}{%
      \ClassWarning{skripsi.cls}{Omit 'cover=legacy' option to use user-defined primary cover page 'frontmatter/maketitle.tex'}
      }{}%
    }{%
      % Try to use user's custom file first
      \IfFileExists{frontmatter/maketitle.tex}{%
        \input{frontmatter/maketitle}%
        \ClassWarning{skripsi.cls}{Using user-defined cover page 'frontmatter/maketitle.tex'}%
      }{%
        % embedded version
        {\begin{titlepage}
        \centering
        \vspace*{1cm}

        {\fontsize{14pt}{16pt}\selectfont \textbf{\MakeUppercase{Tugas Akhir (EMBED)}}\par}
        \vspace{1.5cm}

        {\fontsize{14pt}{16pt}\selectfont \textbf{\MakeUppercase{\thetitle}}\par}
        \vspace{1.5cm}

        \includegraphics[width=5cm]{frontmatter/img/logo.png}
        \vspace{1.5cm}

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

        \end{titlepage}%
        }
      }%
    }%
  \else
      \IfFileExists{frontmatter/maketitle.tex}{%
        \ClassWarning{skripsi.cls}{Omit 'noprimarytitle' option to use user-defined cover page 'frontmatter/maketitle.tex'}%
      }{}%
  \fi
  \ifskripsikvopt@secondarytitle
    \clearpage
    \IfFileExists{frontmatter/maketitle_secondary.tex}{%
      \input{frontmatter/maketitle_secondary}%
      \ClassWarning{skripsi.cls}{Using user-defined secondary cover page}
    }{%
      {
        \begin{titlepage}
        \centering
        {\fontsize{14pt}{16pt}\selectfont \textbf{\MakeUppercase{Tugas Akhir (Embed)}}\par}
        \vspace{1.5cm}

        {\fontsize{14pt}{16pt}\selectfont \textbf{\MakeUppercase{\thetitle}}\par}
        \vspace{1cm}
        {\normalsize\selectfont Diajukan guna melengkapi persyaratan untuk memenuhi gelar Sarjana Teknik di Program Studi Teknik Sipil, Fakultas Teknik, Universitas Muhammadiyah Yogyakarta\par}
        \vspace{1.5cm}

        \includegraphics[width=5cm]{frontmatter/img/logo.png}
        \vspace{1.5cm}


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
        \end{titlepage}%
      }
      \ClassWarning{skripsi.cls}{File frontmatter/maketitle_secondary.tex not found, using embedded secondary cover page}%
    }%
  \else
      \IfFileExists{frontmatter/maketitle_secondary.tex}{%
        \ClassWarning{skripsi.cls}{Omit 'nosecondarytitle' option to use user-defined secondary cover page 'frontmatter/maketitle_secondary.tex'}%
      }{}%
  \fi
}
\makeatother
% Chapter & Section format
% thanks to https://latex.org/forum/viewtopic.php?p=83118&sid=a22ccb456531faabf65070c18af69680#p83118 for elegant solution
\makeatletter
\patchcmd{\l@chapter}
  {\cftchapfont #1}% original
  {\cftchapfont{#1}}% patched
  {}{}            % success/failure handlers
\makeatother
\renewcommand{\cftchapfont}{\normalsize\MakeUppercase}
% \renewcommand{\cftsecfont}{}
% \renewcommand{\cftsubsecfont}{\itshape}
% \renewcommand{\thesection}{\textup{\Roman{chapter}}.\arabic{section}}

% Dot leaders, spacing, indentation
\makeatletter
\ifdefstring{\skripsikvopt@pnumwidth}{auto}{%
% Thanks to https://tex.stackexchange.com/a/397295/270151 for clever solution to fix the fixed length \@pnumwidth problem to auto-like width
% \patchcmd{<cmd>}{<search>}{<replace>}{<success>}{<failure>}
\patchcmd{\cftchapfillnum}% <cmd>
  {\makebox[\@pnumwidth][\cftpnumalign]}% <search>
  {}% <replace>
  {}{}% <success><failure>
\patchcmd{\cftsecfillnum}% <cmd>
  {\makebox[\@pnumwidth][\cftpnumalign]}% <search>
  {}% <replace>
  {}{}% <success><failure>
\patchcmd{\cftsubsecfillnum}% <cmd>
  {\makebox[\@pnumwidth][\cftpnumalign]}% <search>
  {}% <replace>
  {}{}% <success><failure>
\patchcmd{\cftsubsubsecfillnum}% <cmd>
  {\makebox[\@pnumwidth][\cftpnumalign]}% <search>
  {}% <replace>
  {}{}% <success><failure>
\makeatother
}{
  % Fixed width page numbers (default)
}
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
\renewcommand \cftchapdotsep{1} % https://tex.stackexchange.com/a/273764
\renewcommand \cftsecdotsep{1} % https://tex.stackexchange.com/a/273764
\renewcommand \cftsubsecdotsep{1} % https://tex.stackexchange.com/a/273764
\renewcommand \cftsubsubsecdotsep{1} % https://tex.stackexchange.com/a/273764
\renewcommand \cftfigdotsep{1.5} % https://tex.stackexchange.com/a/273764
\renewcommand \cfttabdotsep{1.5} % https://tex.stackexchange.com/a/273764
\renewcommand{\cftchapleader}{\normalfont\cftdotfill{\cftchapdotsep}}
\renewcommand{\cftchappagefont}{\normalfont}

% Add Prefix in the Lof and LoT entries
\renewcommand{\cftfigpresnum}{\figurename~}
\renewcommand{\cfttabpresnum}{\tablename~}

% Ensure TOC and References Respect Custom Numbering
\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand\thesection{\arabic{chapter}.\arabic{section}}

% Change figure numbering to include chapter (e.g., Figure 1.1, 1.2...)
\renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure}}
\renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}

% Table of Content (TOC, LoF, LoT) Title styling
% \renewcommand{\contentsname}{DAFTAR ISI}
\renewcommand{\cfttoctitlefont}{\hfill\bfseries\MakeUppercase}
\renewcommand{\cftaftertoctitle}{\hfill} % https://tex.stackexchange.com/a/255699/394075
\renewcommand{\cftloftitlefont}{\hfill\bfseries\MakeUppercase}
\renewcommand{\cftafterloftitle}{\hfill}
\renewcommand{\cftlottitlefont}{\hfill\bfseries\MakeUppercase}
% TOC depth
\makeatletter
\setcounter{tocdepth}{\skripsikvopt@tocdepth}
\makeatother

% Defines a new glossary called “notation”
\newglossary[nlg]{notation}{not}{ntn}{Notation}

% Define the new glossary style called 'mylistalt'
\makeatletter
\newglossarystyle{mylistalt}{%
  % start the list, initializing glossaries internals
  \renewenvironment{theglossary}%
    {\glslistinit\begin{enumerate}}%
    {\end{enumerate}}%
  % suppress all headers/groupskips
  \renewcommand*{\glossaryheader}{}%
  \renewcommand*{\glsgroupheading}[1]{}%
  \renewcommand*{\glsgroupskip}{}%
  % main entries: let \item produce "1." etc., then break
  \renewcommand*{\glossentry}[2]{%
    \item \glstarget{##1}{\glossentryname{##1}}%
    \mbox{}\\
    \glossentrydesc{##1}
    % [##2] % appears on page x
  }%
  % sub-entries as separate paragraphs, still aligned
  \renewcommand*{\subglossentry}[3]{%
    \par
    \glssubentryitem{##2}%
    \glstarget{##2}{\strut}\space
    \glossentrydesc{##2}\space ##3%
  }%
}

% Define the header for the location column
\providecommand*{\locationname}{Location}

% Define the new glossary style 'altlong3customheader'
\newglossarystyle{altlong3customheader}{%
  % The glossary will be a longtable environment with three columns:
  % 1. Symbol (left-aligned)
  % 2. Description (paragraph, width \glsdescwidth)
  % 3. Location (paragraph, width \glspagelistwidth)
  \renewenvironment{theglossary}%
    {\begin{longtable}{lp{\glsdescwidth}p{\glspagelistwidth}}}%
    {\end{longtable}}%
  % Define the table header row
  \renewcommand*{\symbolname}{Simbol}
  \renewcommand*{\descriptionname}{Keterangan}
  \renewcommand*{\locationname}{Halaman}
  \renewcommand*{\glossaryheader}{%
    \bfseries\symbolname & \bfseries\descriptionname & \bfseries\locationname \tabularnewline\endhead}%
  % Suppress group headings (e.g., A, B, C...)
  \renewcommand*{\glsgroupheading}[1]{}%
  % Define how a main glossary entry is displayed
  % ##1 is the entry label
  % ##2 is the location list (page numbers)
  \renewcommand{\glossentry}[2]{%
    \glsentryitem{##1}% Inserts entry number if entrycounter option is used
    \glstarget{##1}{\glossentryname{##1}} & % Column 1: Symbol (with hyperlink target)
    \glossentrydesc{##1}\glspostdescription & % Column 2: Description (with post-description punctuation)
    ##2\tabularnewline % Column 3: Location list
  }%
  % Define how a sub-entry is displayed
  % ##1 is the sub-entry level (e.g., 1 for first sub-level)
  % ##2 is the entry label
  % ##3 is the location list
  \renewcommand{\subglossentry}[3]{%
    & % Column 1 (Symbol) is left blank for sub-entries to create an indented look
    \glssubentryitem{##2}% Inserts sub-entry number if subentrycounter is used
    \glstarget{##2}{\strut}\glossentrydesc{##2}\glspostdescription & % Column 2: Description (target on strut for hyperlink)
    ##3\tabularnewline % Column 3: Location list
  }%
  % Define the skip between letter groups (if group headings were enabled)
  % For 3 columns, we need 2 ampersands for a full blank row if not using \multicolumn
  \ifglsnogroupskip
    \renewcommand*{\glsgroupskip}{}%
  \else
    \renewcommand*{\glsgroupskip}{& & \tabularnewline}%
  \fi
}

% Define a new style 'supercol' based on 'super'
\newglossarystyle{supercol}{%
  \setglossarystyle{super}% inherit everything from the original
  % override just the main-entry format:
  \renewcommand*{\glossentry}[2]{%
    \glsentryitem{##1}%
    \glstarget{##1}{\glossentryname{##1}}\space  % <-- added colon here
    &: \glossentrydesc{##1}\glspostdescription\space ##2\tabularnewline
  }%
  % likewise for sub‐entries, if you want a colon there too:
  \renewcommand*{\subglossentry}[3]{%
    &: 
    \glssubentryitem{##2}%
    \glstarget{##2}{\strut}\glossentryname{##2}\space % <-- and here
    \glossentrydesc{##2}\glspostdescription\space ##3\tabularnewline
  }%
}
% Define a new style 'supercolnoloc' based on 'super'
\newglossarystyle{supercolnoloc}{%
  \setglossarystyle{super}% inherit everything from the original
  \renewenvironment{theglossary}%
  {\begin{longtable}{lp{0.8\textwidth}}}%
  {\end{longtable}}%
  % override just the main-entry format:
  \renewcommand*{\glossentry}[2]{%
    \glsentryitem{##1}%
    \glstarget{##1}{\glossentryname{##1}}\space  % <-- added colon here
    &: \glossentrydesc{##1}\glspostdescription \tabularnewline
  }%
  % likewise for sub‐entries, if you want a colon there too:
  \renewcommand*{\subglossentry}[3]{%
    &: 
    \glssubentryitem{##2}%
    \glstarget{##2}{\strut}\glossentryname{##2}\space % <-- and here
    \glossentrydesc{##2}\glspostdescription\space ##3\tabularnewline
  }%
}
\makeatother

% A new command that enables us to enter bi-lingual (Slovene and English) terms
% syntax: \addterm[options]{label}{Slovene}{Slovene first use}{English}{Slovene
% description}
\newcommand{\addterm}[6][]{
  \newglossaryentry{#2}{
    name={#3 (angl.\ #5)},
    first={#4 (\emph{#5})},
    text={#3},
    sort={#3},
    description={#6},
    #1 % pass additional options to \newglossaryentry
  }
}

% A new command that enables us to enter (English) acronyms with bi-lingual
% (Slovene and English) long versions
% syntax: \addacronym[options]{label}{abbreviation}{Slovene long}{Slovene first
% use long}{English long}{Slovene description}
\newcommand{\addacronym}[7][]{
  % Create the main glossary entry with \newacronym
  % \newacronym[key-val list]{label}{abbrv}{long}
  \newacronym[
    name={#4 (angl.\ #6,\ #3)},
    first={\emph{#5} (angl.\ \emph{#6},\ \emph{#3})},
    sort={#4},
    description={#7},
    #1 % pass additional options to \newglossaryentry
    ]
    {#2}{#3}{#4}
  % Create a cross-reference from the abbreviation to the main glossary entry by
  % creating an auxiliary glossary entry (note: we set the label of this entry
  % to '<original label>_auxiliary' to avoid clashes)
  \newglossaryentry{#2_auxiliary}{
    name={#3},
    sort={#3},
    description={\makefirstuc{#6}},
    see=[See:]{#2}
  }
}

% Keywords command for abstract (polyglossia-compatible)
% --- Track main language vs. current language ---
% Thanks to https://tex.stackexchange.com/a/333659
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

% Wrap your existing \keywords so it:
%  1) computes \sortedlist
%  2) prints it
%  3) also updates PDF metadata for XeLaTeX via xdvipdfmx \special
\newcommand{\keywords}[1]{%
  \bigskip\noindent
  \alphabubblesort{#1}
  \ifnum\strcmp{\languagename}{malay}=0
  Kata Kunci: \sortedlist%
  \else
    \textit{Keywords: \sortedlist}%
  \fi
  % -- store for metadata --
  \gdef\SortedKeywords{\sortedlist}%
  % Sanitize for PDF string (escapes parentheses, makes nice unicode)
  \pdfstringdef\kwpdf{\SortedKeywords}%
  % For XeLaTeX/xdvipdfmx, override PDF docinfo directly; the last call wins.
  \immediate\special{pdf:docinfo << /Keywords (\kwpdf) >>}%
  % If you also want hyperref’s internal copy updated (harmless):
  \hypersetup{pdfkeywords={\SortedKeywords}}%
}
\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Change the text of the cross-reference links to the Slovene long version.
\renewcommand*{\glsseeitemformat}[1]{\emph{\acrlong{#1}}.}

% % Apply a custom fancyhdr layout only on the first page of each \chapter, and use no header/footer elsewhere
% % \let\oldchapter\chapter
% % \renewcommand{\chapter}{%
% %   \cleardoublepage
% %   \pagestyle{fancyplainchapter}%
% %   \oldchapter
% %   \thispagestyle{fancyplainchapter} % ensure chapter start page uses it
% %   \pagestyle{fancyplain}% switch for subsequent pages
% % }

\makeatletter
% Extracting the Year from \today
\newcommand{\theyear}{%
  \expandafter\@car\expandafter\@gobble\the\year\@nil
}

% Declare internal macros as initially empty
\newcommand{\@authorid}{}
\newcommand{\@secondadvisor}{}
\newcommand{\@firstexaminer}{}
\newcommand{\@secondexaminer}{}
\newcommand{\@headdepartement}{}
\newcommand{\@headdepartementid}{}
\newcommand{\@faculty}{}
\newcommand{\@program}{}
\newcommand{\@university}{}
\newcommand{\@yearofsubmission}{}

% Define user commands to set these values.
\newcommand{\authorid}[1]{\gdef\@authorid{#1}}
\newcommand{\secondadvisor}[1]{\gdef\@secondadvisor{#1}}
\newcommand{\firstexaminer}[1]{\gdef\@firstexaminer{#1}}
\newcommand{\secondexaminer}[1]{\gdef\@secondexaminer{#1}}
\newcommand{\headdepartement}[1]{\gdef\@headdepartement{#1}}
\newcommand{\headdepartementid}[1]{\gdef\@headdepartementid{#1}}
\newcommand{\faculty}[1]{\gdef\@faculty{#1}}
\newcommand{\program}[1]{\gdef\@program{#1}}
\newcommand{\university}[1]{\gdef\@university{#1}}
\newcommand{\yearofsubmission}[1]{\gdef\@yearofsubmission{#1}}

% Now expose robust “the‑” getters to access the values
\newcommand{\theauthorid}{\@authorid}
\newcommand{\thesecondadvisor}{\@secondadvisor}
\newcommand{\thefirstexaminer}{\@firstexaminer}
\newcommand{\thesecondexaminer}{\@secondexaminer}
\newcommand{\theheaddepartement}{\@headdepartement}
\newcommand{\theheaddepartementid}{\@headdepartementid}
\newcommand{\thefaculty}{\@faculty}
\newcommand{\theprogram}{\@program}
\newcommand{\theuniversity}{\@university}
\newcommand{\theyearofsubmission}{\@yearofsubmission}

% \AtBeginDocument{%
%   \hypersetup{
%     pdftitle={\@title},
%     pdfauthor={Rifqi D. Panuluh}
%   }%
% }
% Ensure title/author/date get expanded correctly in hypersetup
\hypersetup{
  % pdftitle={gfhfdhfd},
  % pdfauthor={Rifqi D. Panuluh},
  % pdfdate={\@date},
  pdfsubject={Bachelor Thesis},
  % pdfpublisher={Universitas Muhammadiyah Yogyakarta},
  % pdfcontactemail={rifqi.damar.ft21@mail.umy.ac.id},
  pdfcopyright={Copyright (C) 2025, Rifqi D. Panuluh},
  pdflicenseurl={https://github.com/nuluh/thesis/blob/main/LICENSE},
  pdfurl  = {https://github.com/nuluh/thesis/releases/download/v1.0/main.pdf},
  pdflang={id},
  pdfcreator={XeLaTeX with hyperref and hyperxmp},
  pdfproducer={TeX Live 2024},
  keeppdfinfo=true
}
\makeatother
\endinput