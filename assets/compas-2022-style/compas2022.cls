%====================================
% Title                 : Fichier de styles pour Compas 2022 (inspire des fichiers de styles d'ETR'97)
% Copyright (C) 1997 by : GDR-PRS-TR
% Last Version          : 1.0 (29 avril 1997)
% Modification          : 7 avril 1997 mis a jour des styles par JMB.
%                       : 29 avril 1997 auteur(s) unique/multiples.
% Adapatation pour RenPar'9
% Modification de Christophe Cerin le 11 fevrier 2003
% Modification de Pierre Kuonen le 3 Decembre 2007 pour RenPar'18/SympA'2008/CFSE'6
% Modification de Thierry Gautier le 12/04/2012 pour Compas2013
% Modification de Vincent Danjean le 16/04/2012 pour Compas2013
% Modification de Etienne Rivière le 12/10/2013 pour Compas2014
% Modification de Michaël Hauspie le 11/02/2015 pour Compas2015
% Modification de Kevin   Martin  le 15/11/2015 pour Compas2016
% Patch de Hughes de Lassus appliqué le 7/03/2016 pour Compas2016
% Patch de Alain Tchana pour Compas2018
% Patch de Philippe Roose pour Compas2019
% Patch de Frédéric Suter pour Compas2021
% Patch de Gil Utard pour Compas2022
%===========================================================
%%
%A utiliser avec le Latex2e
%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{compas2022}%
[2012/09/21 v1.5 real LaTeX class]

%===========================================================
%                       Gestion des options
%===========================================================


\newif\ifCOMPAS@confselected%

\COMPAS@confselectedfalse

\def\@COMPAS@setconf#1{%
  \ifCOMPAS@confselected%
  \ClassError{compas2022}{%
    Duplicate conference in class options}{%
    Only one option between 'parallelisme', 'architecture', 'systeme' is allowed}%
  \fi
  \global\COMPAS@confselectedtrue%
  \global\def\COMPAS@conf{#1}%
}

\DeclareOption{parallelisme}{%
  \@COMPAS@setconf{parallelisme}%
}
\DeclareOption{architecture}{%
  \@COMPAS@setconf{architecture}%
}
\DeclareOption{systeme}{%
  \@COMPAS@setconf{systeme}%
}
%\DeclareOption{tempsreel}{%
%  \@COMPAS@setconf{tempsreel}%
%}
%\DeclareOption{repartition}{%
%  \@COMPAS@setconf{repartition}%
%}

% Choose a default size but allow to overwrite it with a class option
\def\@@compasPtSize{11pt}
\DeclareOption{10pt}{\def\@@compasPtSize{10pt}}
\DeclareOption{11pt}{\def\@@compasPtSize{11pt}}
\DeclareOption{12pt}{\def\@@compasPtSize{12pt}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\DeclareOption*{%
   \PassOptionsToClass{\CurrentOption}{article}%
}

\ProcessOptions\relax

\LoadClass[twoside, \@@compasPtSize]{article}

\ifCOMPAS@confselected%
\else%
\ClassError{compas2022}{%
  No conference selected in the class options}{%
  When loading the class, you *must* choose one of the four
  \MessageBreak conferences ('parallelisme', 'architecture', 'systeme'), for example:\MessageBreak
  \protect\documentclass[parallelisme]{compas2022}
  }%
\fi%

%===========================================================
%                       Mise en page
%===========================================================

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[french]{babel}
\RequirePackage{euler}
\RequirePackage{palatino}

\RequirePackage{epsfig}
\RequirePackage{shadow}
\RequirePackage{amsmath}
\RequirePackage{amssymb}

\bibliographystyle{compas}
\pagestyle{plain}

% --- Panneau
\font\myl=manfnt
\def\panneau{{\myl\char"7F}}
% ---

\newcommand{\toappear}[1]{\setcounter{page}{#1}}
\newdimen\mathindent            % Pour ne pas utiliser fleqn.sty
\oddsidemargin   -4mm           % 3cm a gauche des impaires
\evensidemargin  4mm            % 2cm a gauche des paires
\topmargin      -18mm            % 2.5cm en haut
\headheight     13mm            % taille de l'entete (lignes)
\headsep        24pt            % espace entre entete et texte
\footskip       30pt            % espace entre pied de page et texte
\textheight 230mm                 % longeur du texte
\textwidth 160mm                  % largeur du texte
\parskip 1pt                      % pas de sauts entre paragraphes
\parindent 0pt                    % largeur de l'indentation
\newdimen\@bls                    % \@b(ase)l(ine)s(kip)
\@bls=\baselineskip               % \@bls ~= \baselineskip for \normalsize
\advance\@bls -1ex                % (fudge term)
\newdimen\@eps                    %
\@eps=0.0001pt                    % \eps = very small positive quantity

\def\section{\@startsection{section}{1}{\z@}
  {1.5\@bls plus 0.5\@bls}{1\@bls}{\normalsize\bf}}
\def\subsection{\@startsection{subsection}{2}{\z@}
  {1\@bls plus 0.25\@bls}{\@eps}{\normalsize\bf}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}
  {1\@bls plus 0.25\@bls}{\@eps}{\normalsize\bf}}
\def\paragraph{\@startsection{paragraph}{4}{\parindent}
  {1\@bls plus 0.25\@bls}{0.5em}{\normalsize\bf}}
\def\subparagraph{\@startsection{subparagraph}{4}{\parindent}
  {1\@bls plus 0.25\@bls}{0.5em}{\normalsize\bf}}

\def\@sect#1#2#3#4#5#6[#7]#8{\ifnum #2>\c@secnumdepth
  \def\@svsec{}\else 
  \refstepcounter{#1}\edef\@svsec{\csname the#1\endcsname.\hskip0.5em}\fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup 
      #6\relax
      \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty \@M #8\par}%
    \endgroup
    \csname #1mark\endcsname{#7}\addcontentsline
      {toc}{#1}{\ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}\fi #7}%
  \else
    \def\@svsechd{#6\hskip #3\@svsec #8\csname #1mark\endcsname
      {#7}\addcontentsline{toc}{#1}{\ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}\fi #7}}%
  \fi \@xsect{#5}}

% FIGURES AND TABLES
\floatsep 10mm plus 4pt minus 4pt % Space between adjacent floats moved
                                  % to top or bottom of text page.
\textfloatsep=\floatsep           % Space between main text and floats
                                  % at top or bottom of page.
\intextsep=\floatsep              % Space between in-text figures and 
                                  % text.

% FOOTNOTE
%\long\def\@makefntext#1{\parindent 1em\noindent\hbox{${}^{\@thefnmark}$} #1}
%
% Nouvelle version Christophe Cerin
%
\long\def\@makefntext#1{\parindent 1em\noindent\raise5pt\hbox{\tiny\thefootnote} #1}

% EQUATION
\mathindent=0em 

%===========================================================
%                               Titre
%===========================================================
\newcommand{\shorttitle}[1]{\newcommand{\@shorttitle}{#1}}
\def\maketitle{\begingroup        % Initialize generation of front-matter
%   \let\thanks\@gobble
    \def\thefootnote{\fnsymbol{footnote}}%
    \newpage \global\@topnum\z@ 
    \@maketitle \thispagestyle{crcplain}\@thanks
  \endgroup
  \let\maketitle\relax \let\@maketitle\relax
  \gdef\@thanks{}\let\thanks\relax
  \gdef\@address{}\gdef\@author{}\gdef\@title{}\let\address\relax}


\def\@maketitle{\null             % Actual formatting of \maketitle
  \vskip 2ex                     % Vertical space above title.
  \raggedright                    % Front-matter text is ragged right
  \hyphenpenalty\@M               % and is not hyphenated.
  {\LARGE \@title \par}           % Title set in larger font. 
  \vskip\@bls                     % One line of vertical space after title.
  {\normalsize                    % each author set in the normal 
   \@author \par}                 % typeface size 
  \vskip\@bls                     % One line of vertical space after author.
  \@address                       % all addresses
  \par}                           % One line of vertical space at the end.

\newcounter{address} 
\def\theaddress{\alph{address}}
\def\@makeadmark#1{\hbox{$^{\rm #1}$}}   

\def\address#1{\begingroup
  \xdef\@tempa{\theaddress}\let\\=\relax
  \def\protect{\noexpand\protect\noexpand}\xdef\@address{\@address
  \protect\addresstext{#1}}\endgroup}
\def\@address{}

\def\twoaddress#1{\addressmark\begingroup
  \xdef\@tempa{\theaddress}\let\\=\relax
  \def\protect{\noexpand\protect\noexpand}\xdef\@address{\@address
  \protect\twoaddresstext{\@tempa}{#1}}\endgroup}
\def\@address{}

\def\addressmark{\stepcounter{address}%
  \xdef\@tempa{\theaddress}\@makeadmark{\@tempa}}

\def\addresstext#1{\leavevmode \begingroup
  \raggedright \hyphenpenalty\@M #1\par \endgroup
  \vskip\@bls}

\def\twoaddresstext#1#2{\leavevmode \begingroup
  \raggedright \hyphenpenalty\@M \@makeadmark{#1}#2\par \endgroup
  \vskip\@bls}

%===========================================================
%                               Bibliographie
%===========================================================
\def\thebibliography#1{\section*{Bibliographie}\list
 {\arabic{enumi}.}
  {\settowidth\labelwidth{#1.}\leftmargin=1.67em
   \labelsep\leftmargin \advance\labelsep-\labelwidth
   \itemsep\z@ \parsep\z@
   \usecounter{enumi}}\def\makelabel##1{\rlap{##1}\hss}%
   \def\newblock{\hskip 0.11em plus 0.33em minus -0.07em}
   \sloppy \clubpenalty=4000 \widowpenalty=4000 \sfcode`\.=1000\relax}

%===========================================================
%                               Entete/Pied de page
%===========================================================
\newcommand{\regle}{\noindent\rule[0mm]{\textwidth}{0.2mm}}

\def\ps@crcplain{%\let\@mkboth\@gobbletwo
     \def\@oddhead{\hfil\rparallelismedixnotice}%
     \def\@evenhead{\lparallelismedixnotice\hfil}%
     \let\@oddfoot\@empty
     \let\@evenfoot\@oddfoot}
\ps@crcplain                      % modified 'plain' page style


%===========================================================
%                       R\'esum\'e / Mots Cl\'es
%===========================================================
\let\COMPAS@keywords\relax%

\newcommand{\MotsCles}[1]{%
  \gdef\COMPAS@keywords{#1}}
\renewenvironment{abstract}{%
  \regle\vskip 0ex plus 2ex % extra glue after \maketitle
  \subsection*{R\'esum\'e}%
}{%
  \ifx\COMPAS@keywords\relax%
  \ClassWarning{compas2022}{No keywords defined with \protect\MotCles}
  \else
  \begin{description} % 5 mots cl\'es seulement!!!
  \item[Mots-cl\'es :]{\COMPAS@keywords}
  \end{description}
  \fi \regle\par%
  \gdef\MotsCles##1{%
    \ClassError{compas2022}{%
      \protect\MotCles\space must be used \MessageBreak%
      before the end of the abstract environment}{%
      Did you put the \protect\MotsCles\space macro after (instead of
      before or in) \MessageBreak the abstract environment?}
  }
}

\def\maketitle{\begingroup        % Initialize generation of front-matter
%   \let\thanks\@gobble
    \def\thefootnote{\fnsymbol{footnote}}%
    \newpage \global\@topnum\z@ 
    \@maketitle \thispagestyle{crcfirstpage}\@thanks
  \endgroup
%  \let\maketitle\relax \let\@maketitle\relax
  \gdef\@thanks{}%\let\thanks\relax
  \gdef\@address{}\gdef\@author{}\gdef\@title{}%\let\address\relax}
}

%===========================================================
%                               Titre de la confe'rence
%===========================================================
\def\parallelisme{Parall{\'e}lisme{}}
\def\systeme{Syst{\`e}me{}}
\def\architecture{Architecture{}}
\def\tempsreel{Temps R{\'e}el{}}
\def\lieuconf{MIS/UPJV - Amiens France,  5-8 juillet 2022}

\newcommand\COMPAS@CFPparallelisme{
  \def\labelconf{\underline{\parallelisme} / \architecture / \systeme}% / \tempsreel}% / \repartition{}}
}
\newcommand\COMPAS@CFPsysteme{
  \def\labelconf{\parallelisme / \architecture / \underline{\systeme}}% / \tempsreel}% / \repartition{}}
}
\newcommand\COMPAS@CFParchitecture{
  \def\labelconf{\parallelisme / \underline{\architecture} / \systemei}% / \tempsreel}% / \repartition{}}
}
%\newcommand\COMPAS@CFPtempsreel{
%  \def\labelconf{\parallelisme / \architecture / \systeme / \underline{\tempsreel}}% / \repartition{}}
%}

%\newcommand\COMPAS@CFPrepartition{
%  \def\labelconf{\parallelisme / \architecture / \systeme / \underline{\repartition}}
%}

\expandafter\csname COMPAS@CFP\COMPAS@conf\endcsname

\def\rparallelismedixnotice{\small%

  \begin{tabular}[b]{r}%
    {\bf Compas'2022}~: \labelconf \\
    \lieuconf
  \end{tabular}
}
\def\lparallelismedixnotice{\small%
  \begin{tabular}[b]{l}
    {\bf Compas'2022}~: \labelconf \\
    \lieuconf
  \end{tabular}
}
\def\ps@crcfirstpage{\let\@mkboth\@gobbletwo
     \def\@oddhead{\hfil\rparallelismedixnotice}%
     \def\@evenhead{\lparallelismedixnotice\hfil}%
     \let\@oddfoot\@empty
     \let\@evenfoot\@oddfoot}
\ps@crcplain

