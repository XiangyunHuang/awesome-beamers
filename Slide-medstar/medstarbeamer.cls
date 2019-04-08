%%%%%%%%% MedStar Beamer Template %%%%%%%%%
%%%%%%%% Written By: Anagha Kumar %%%%%
%%%%%%%% License: lppl1.3  %%%%%%%%%%%%%%%%
%%%%%%%% Version: 2015-11-12 %%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{medstarbeamer}
\LoadClassWithOptions{beamer}
\RequirePackage{anysize}
\RequirePackage{hyperref}
\RequirePackage{graphicx} 
\RequirePackage{pgf} 
\RequirePackage{xcolor}
\RequirePackage{booktabs}
\RequirePackage{soul}
\RequirePackage{background} 
\RequirePackage{cancel}
\RequirePackage{amsmath} 
\RequirePackage{enumerate}
\RequirePackage{ifthen}

\defbeamertemplate*{footline}{}
{
  \hbox{%
  \begin{beamercolorbox}[wd=.3333333\paperwidth,ht=0.25cm,dp=0.2cm,center]{author in head/foot}%
    \usebeamerfont{author in head/foot}\insertshortauthor
  \end{beamercolorbox}%
  \begin{beamercolorbox}[wd=.3333333\paperwidth,ht=0.25cm,dp=0.2cm,center]{title in head/foot}%
    \usebeamerfont{title in head/foot}\insertshorttitle
  \end{beamercolorbox}%
  \begin{beamercolorbox}[wd=.3333333\paperwidth,ht=0.25cm,dp=0.2cm, center]{date in head/foot}%
    \usebeamerfont{date in head/foot}\insertshortdate{}\hfill \insertframenumber{} / \inserttotalframenumber 
  \end{beamercolorbox}}%
}
% ht controls the height of the boxes. %I want the text in the boxes to be centered. %dp controls the depth 

\defbeamertemplate*{headline}{}
{
  \begin{beamercolorbox}{section in head/foot}
    \vskip3pt\insertnavigation{\paperwidth}\vskip3pt
  \end{beamercolorbox}%
  \ifbeamer@theme@subsection%
    \begin{beamercolorbox}[ht=0.25cm,dp=0.2cm, leftskip=0.5cm]{subsection in head/foot}
      \usebeamerfont{subsection in head/foot}\insertsubsectionhead
    \end{beamercolorbox}%
  \fi
}

\setbeamersize{text margin left=0.5cm,text margin right=0.75 cm} % This is important to specify so that the margins and hence, typeset font can be controlled in each slide. I prefer cm over em. 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usecolortheme{MedStarColors}
\newif\ifbeamer@theme@subsection
\beamer@theme@subsectiontrue %%%%%% adds in the blue line %%%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\logo{\includegraphics[ height=1.5cm, width=1.5cm]{medstarlogo}} %the size of the logo to be included in every frame

\setbeamercovered{dynamic} %overlays appear faintly 
\setbeamertemplate{navigation symbols}{}  % since I dislike the navigation symbols
\setbeamertemplate{caption}[numbered] % since beamer does not number captions without setting this 


%%%%%%%%%%%%Shrinking the table of contents if needed %%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\sizecontentsoutline}[1]
{
  \ifnum#1=1  
     \begin{frame}
    \tableofcontents 
    \end{frame}
    \else
 \ifnum#1=2 
    \begin{frame}
    \footnotesize{\tableofcontents}
    \end{frame}
  \fi
}

\newcommand{\sizecontentscurrent}[1]
{
\AtBeginSection{
\ifthenelse{\thesection > 1}{
  \ifnum#1=1  
     \begin{frame}
    \tableofcontents[currentsection]
    \end{frame}
    \else
 \ifnum#1=2 
    \begin{frame}
    \footnotesize{\tableofcontents[currentsection]}
    \end{frame}
  \fi
}
}
}

% Define Author, Date, Institute, Title using small caps and different fonts - theme