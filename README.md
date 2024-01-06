# Overview
This is the source code repository for my personal CV (affectionately called as Selu-CV). It is made using TeX and based on the awesome template, [Awesome-CV](https://github.com/posquit0/Awesome-CV).

# Where can I get the PDF?
https://public.selubi.tech/personal/resume-english.pdf

# Customization
Below are the list of customization I did against the original `awesome-cv`. All customization is backward-compatible.

## Paragraph allowed job description
Original:
```tex
% Define an environment for cvitems(for cventry)
\newenvironment{cvitems}{%
  \vspace{-4.0mm}
  \begin{justify}
  \begin{itemize}[leftmargin=2ex, nosep, noitemsep]
    \setlength{\parskip}{0pt}
    \renewcommand{\labelitemi}{\bullet}
}{%
  \end{itemize}
  \end{justify}
  \vspace{-4.0mm}
}
```
Modified:
```tex
% Bullet points to be used within cvitems and cvjobdesc
\newenvironment{cvbullets}{%
  \begin{itemize}[leftmargin=2ex, nosep, noitemsep]
    \setlength{\parskip}{0pt}
    \renewcommand{\labelitemi}{\bullet}
}{%
  \end{itemize}
}

% Define an environment for cvitems(for cventry) (backwards-compatible with original awesome-cv)
\newenvironment{cvitems}{%
  \vspace{-4.0mm}
  \begin{justify}
  \begin{cvbullets}
}{%
  \end{cvbullets}
  \end{justify}
  \vspace{-4.0mm}
}

% Define an environment for the job description that can accommodate paragraphs as well
\newenvironment{cvjobdesc}{%
  \vspace{-4.0mm}
  \begin{justify}
}{%
  \end{justify}
  \vspace{-4.0mm}
}
```

Basically I decoupled the itemize part of `cvitems` to `cvbullets` but kept the `cvitems` as original for backward compatibility.

I then created a new class `cvjobdesc` to mimic `cvitems` without the `cvbullets` part. We can call `cvbullets` by ourselves later.

## Languages in header
Added the below snippet to include languages spoken in header.
```tex
%-------------------------------------------------------------------------------
%                Commands for personal information
%-------------------------------------------------------------------------------

...


% Defines writer's languages (optional)
% Usage: \languages{<languages>}
\newcommand*{\languages}[1]{\def\@languages{#1}}

...

%-------------------------------------------------------------------------------
%                Commands for elements of CV structure
%-------------------------------------------------------------------------------
% Under makecvheader
    \ifthenelse{\isundefined{\@languages}}%
    {}%
    {%
        \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
        \faLanguage\acvHeaderIconSep\@languages%
    }%
```

## Spaces between section is changed to 2.5mm
```tex
%-------------------------------------------------------------------------------
%                Commands for extra
%-------------------------------------------------------------------------------

...

\newcommand{\acvSectionTopSkip}{2.5mm}
```

## Japanese language support added
```tex
%-------------------------------------------------------------------------------
%                Handle Japanese Characters
%-------------------------------------------------------------------------------
% See https://ja.overleaf.com/learn/latex/Japanese#Using_Google_Noto_fonts for more details
\RequirePackage{xeCJK}
\setCJKmainfont{Noto Sans CJK JP}
\setCJKsansfont{Noto Sans CJK JP}
\setCJKmonofont{Noto Sans Mono CJK JP}

```
