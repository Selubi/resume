## Overview

This is the source code repository for my personal CV (affectionately called as Selu-CV). It is made using TeX and based on the awesome template, [Awesome-CV](https://github.com/posquit0/Awesome-CV).

## Where can I get the PDF?

https://public.selubi.tech/personal/resume-english.pdf

## Deployment

"But wait, its just a resume not an app, what do you mean by deploying a resume?"

No, "deployment" doesn't mean automatically sending the resume to recruiters (although that could be fun).

Deployment here means every time this repo changes, we automatically re-build and re-upload the PDF to the link on [where can i get the pdf](#where-can-i-get-the-pdf).

Deployment is done automatically via [`.github/workflows/build_and_upload_pdf.yaml`](.github/workflows/build_and_upload_pdf.yaml) if any changes on `**/*.tex` or `**/*.cls` is pushed to main branch.

At a high level:

1. Any `*.tex` file on the repository root is compiled to pdf with the same steps as [compiling to pdf](#compiling-to-pdf).
2. PDFs generated from step 1 is automatically uploaded to a bucket.

For those who are interested I'm using [Cloudflare R2](https://www.cloudflare.com/developer-platform/r2/) via [AWS CLI s3api](https://developers.cloudflare.com/r2/examples/aws/aws-cli/).

## Development guide

### Editing on local machine

This repository is setup to be edited via devcontainers. Just launch devcontainers with vscode with the settings in `.devcontainer`

### Compiling to PDF

Run the command below

```
make pdf <yourtexfile.tex>
```

It will compile the tex file provided with `latexmk (XeLaTeX)`. This is aligned with the default recipe specified in `latex-workshop.latex.recipe.default` the container.

## License

The template itself (code, formatting, structure) in this repository is licensed under MIT License.
However, please note that the personal data included in the resume is not covered under this license.
You are free to modify the template for your own use, but do not distribute the personal information contained in the original document.

## Customization

Below are the list of customization I did against the original `awesome-cv`.

### Paragraph allowed job description

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

% This is basically cvitems without the itemize
\newenvironment{cvjobdesc}{%
  \vspace{-4.0mm}
  \begin{justify}
}{%
  \end{justify}
  \vspace{-4.0mm}
}

% Define an environment for cvitems(for cventry) (backwards-compatible with original awesome-cv)
\newenvironment{cvitems}{%
  \begin{cvjobdesc}
  \begin{cvbullets}
}{%
  \end{cvbullets}
  \end{cvjobdesc}
}
```

Basically I decoupled the section formatting part and itemize part of `cvitems` to `cvjobdesc` and `cvbullets` but kept the `cvitems` as original for backward compatibility.

### Languages in header

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

### Spaces between section is changed to 2.5mm

```tex
%-------------------------------------------------------------------------------
%                Commands for extra
%-------------------------------------------------------------------------------

...

\newcommand{\acvSectionTopSkip}{2.5mm}
```

### Noto fonts usage

I installed noto fonts with `apt` within the `.devcontainer` and modified header to be Noto Sans.

```tex
\newfontfamily\headerfont[
  UprightFont=*-Regular,
  ItalicFont=*-Italic,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldItalic,
]{NotoSans}

\newfontfamily\headerfontlight[
  UprightFont=*-Thin,
  ItalicFont=*-ThinItalic,
  BoldFont=*-Medium,
  BoldItalicFont=*-MediumItalic,
]{NotoSans}
```

### Japanese language support added

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
