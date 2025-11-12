# Zigma LaTeX Class - User Guide

**Version**: 0.5.0  
**Last Updated**: 2025-11-05  
**Status**: Released

Welcome to the Zigma LaTeX Class user guide! This document provides comprehensive instructions for using Zigma in your academic documents.

---

## Table of Contents

1. [Getting Started](#getting-started)
2. [Author Management](#author-management)
3. [Configuration Reference](#configuration-reference)
4. [Advanced Features](#advanced-features)
5. [Examples](#examples)
6. [Troubleshooting](#troubleshooting)
7. [FAQ](#faq)

---

## Getting Started

### Minimal Document

The simplest Zigma document:

```latex
\documentclass{zigma-class/zigma}

\title{My Article}
\author{John Doe}
\date{\today}

\begin{document}
\maketitle

Your content here...

\end{document}
```

### Basic Setup with Authors

```latex
\documentclass{zigma-class/zigma}

\zigmasetup{
  authors.0.name = {John Doe},
  authors.0.email = {john@university.edu},
  authors.0.affiliation = {0},
  
  affiliations.0 = {University Name - Department},
}

\title{My Article}
\date{\today}

\begin{document}
\maketitle

Content...

\end{document}
```

---

## Author Management

### Single Author

For a document with one author:

```latex
\zigmasetup{
  % Define the affiliation first
  affiliations.0 = {Stanford University - Computer Science Department},
  
  % Then the author
  authors.0.name = {Alice Johnson},
  authors.0.email = {alice@stanford.edu},
  authors.0.orcid = {0000-0001-2345-6789},
  authors.0.affiliation = {0},
  authors.0.corresponding = {true},
}
```

### Multiple Authors, Single Affiliation

When all authors share the same affiliation:

```latex
\zigmasetup{
  affiliations.0 = {MIT - Department of Physics},
  
  authors.0.name = {Bob Smith},
  authors.0.email = {bob@mit.edu},
  authors.0.affiliation = {0},
  authors.0.corresponding = {true},
  
  authors.1.name = {Carol White},
  authors.1.email = {carol@mit.edu},
  authors.1.affiliation = {0},
}
```

### Multiple Authors, Multiple Affiliations

Complex scenario with shared affiliations:

```latex
\zigmasetup{
  % Define all affiliations
  affiliations.0 = {University of Rome - Department of Physics},
  affiliations.1 = {CERN - Geneva - Switzerland},
  affiliations.2 = {INFN - Sezione di Roma},
  
  % Author 1: Affiliations 0 and 2
  authors.0.name = {Mario Rossi},
  authors.0.email = {mario.rossi@uniroma1.it},
  authors.0.orcid = {0000-0001-2345-6789},
  authors.0.affiliation = {0,2},  % Multiple affiliations separated by comma
  authors.0.corresponding = {true},
  
  % Author 2: Affiliations 0 and 1
  authors.1.name = {Laura Bianchi},
  authors.1.email = {laura.bianchi@cern.ch},
  authors.1.orcid = {0000-0002-3456-7890},
  authors.1.affiliation = {0,1},
  
  % Author 3: Only affiliation 1
  authors.2.name = {Giuseppe Verdi},
  authors.2.affiliation = {1},
}
```

### Author Properties Reference

All available author properties:

| Property        | Type         | Required | Description               | Example                 |
|-----------------|--------------|----------|---------------------------|-------------------------|
| `name`          | text         | ✅ Yes   | Full author name          | `{John Doe}`            |
| `email`         | text         | ❌ No    | Contact email             | `{john@example.com}`    |
| `orcid`         | text         | ❌ No    | ORCID identifier          | `{0000-0001-2345-6789}` |
| `affiliation`   | text/numbers | ✅ Yes   | Affiliation ID(s)         | `{0}` or `{0,2}`        |
| `corresponding` | boolean      | ❌ No    | Corresponding author flag | `{true}` or `{false}`   |

### Affiliation Formatting Tips

✅ **Good practices**:
```latex
affiliations.0 = {University Name - Department Name}
affiliations.1 = {Institute Name - City - Country}
affiliations.2 = {Organization, City, Country}
```

❌ **Avoid**:
```latex
affiliations.0 = {Too much detail: Building X, Room 123, Street...}
affiliations.1 = {Acronyms only like UoR-DCS}  % Spell out institutions
```

---

## Configuration Reference

### Page Layout

Control document margins and spacing:

```latex
\zigmasetup{
  % Margins (any valid LaTeX dimension)
  margin.left = 2.5cm,
  margin.right = 2.5cm,
  margin.top = 3cm,
  margin.bottom = 3cm,
  
  % Column separation (for two-column layout)
  column.sep = 15pt,
}
```

**Common margin presets**:

```latex
% Narrow margins
margin.left = 2cm, margin.right = 2cm,
margin.top = 2cm, margin.bottom = 2cm,

% Standard margins
margin.left = 2.5cm, margin.right = 2.5cm,
margin.top = 3cm, margin.bottom = 3cm,

% Wide margins (more whitespace)
margin.left = 3cm, margin.right = 3cm,
margin.top = 3.5cm, margin.bottom = 3.5cm,
```

### Fonts

Customize document fonts:

```latex
\zigmasetup{
  fonts.serif = {stix2},     % Main text font
  fonts.sans = {helvet},      % Sans-serif font
  fonts.mono = {lmtt},        % Monospace font (code)
}
```

**Available font options**:

| Font Family | Value        | Description                       |
|-------------|--------------|-----------------------------------|
| Serif       | `stix2`      | STIX Two (default, scientific)    |
|             | `libertinus` | Libertinus (elegant)              |
|             | `times`      | Times New Roman                   |
| Sans        | `helvet`     | Helvetica (default)               |
|             | `avant`      | Avant Garde                       |
| Mono        | `lmtt`       | Latin Modern Typewriter (default) |
|             | `courier`    | Courier                           |

### Colors

Define and use custom colors:

```latex
% Define colors before \zigmasetup
\definecolor{myblue}{RGB}{0,102,204}
\definecolor{myred}{RGB}{204,51,51}

\zigmasetup{
  colors.main = {myblue},
  colors.section = {myblue},
  colors.accent = {myred},
}
```

**Default color palette**:
- `zigma-main` - Dark blue (0.08, 0.26, 0.52)
- `zigma-section` - Medium blue (0.10, 0.35, 0.65)
- `zigma-accent` - Bright red (0.85, 0.20, 0.20)
- `zigma-box-bg` - Light gray (0.95, 0.95, 0.95)
- `zigma-box-line` - Dark gray (0.60, 0.60, 0.60)

### Metadata

Document metadata for publishing:

```latex
\zigmasetup{
  % Identifiers
  metadata.doi = {10.1234/journal.2024.001},
  metadata.uuid = {550e8400-e29b-41d4-a716-446655440000},
  
  % Publication dates (YYYY-MM-DD format)
  metadata.received = {2024-01-15},
  metadata.revised = {2024-02-20},
  metadata.accepted = {2024-03-10},
  metadata.published = {2024-04-01},
  
  % Keywords and licensing
  metadata.keywords = {quantum mechanics, particle physics, LHC},
  metadata.license = {CC-BY-4.0},
  
  % URL display
  metadata.url = {https://journal.org/article/123},
  metadata.url.show = {true},
}
```

### Labels (Localization)

Customize text labels for different languages:

```latex
\zigmasetup{
  % English (default)
  labels.keyword = {Keywords},
  labels.abstract = {Abstract},
  labels.information = {Article Information},
  labels.note = {Note},
  
  % Or Italian
  labels.keyword = {Parole chiave},
  labels.abstract = {Riassunto},
  labels.information = {Informazioni articolo},
}
```

### Toggles

Enable or disable features:

```latex
\zigmasetup{
  % Display options
  show.metadata = false,    % Hide metadata section
  show.abstract = true,     % Show abstract (default)
  show.toc = false,         % Table of contents
  
  % Debug options
  debug = false,            % Production mode (default)
  debug.colors = false,     % Don't show color boxes
}
```

---

## Advanced Features

### Debug Mode

Enable comprehensive logging:

```latex
\zigmasetup{
  debug = true,
}
```

This will output:
```
ZIGMA INPUT KEY: authors.0.name VAL: Einstein
ZIGMA GOT KEY: 0 PROP: name VAL: Einstein
...
===== ZIGMA STATE DUMP =====
margin.left=70.87204pt
...
=== ZIGMA AUTHORS START===
id=0 name=Albert Einstein email=albert@ias.edu ...
=== ZIGMA AUTHORS END===
```

**When to use debug mode**:
- ✅ During document development
- ✅ When authors aren't appearing correctly
- ✅ When troubleshooting configuration
- ❌ Not for final production (verbose output)

### Header and Footer Customization

```latex
\zigmasetup{
  % Headers
  header.left = {Journal Name},
  header.center = {},
  header.right = {\thepage},
  
  % Footers
  footer.left = {© 2024 Authors},
  footer.center = {},
  footer.right = {},
}
```

### Starting Page Number

```latex
\zigmasetup{
  page.start = 42,  % Start from page 42
}
```

---

## Examples

### Example 1: Single-Author Paper

```latex
\documentclass{zigma-class/zigma}

\zigmasetup{
  affiliations.0 = {Harvard University - Department of Mathematics},
  
  authors.0.name = {Emma Wilson},
  authors.0.email = {emma.wilson@harvard.edu},
  authors.0.orcid = {0000-0001-2345-6789},
  authors.0.affiliation = {0},
  authors.0.corresponding = {true},
  
  metadata.doi = {10.1234/math.2024.001},
  metadata.keywords = {topology, differential geometry},
}

\title{On the Properties of Manifolds}
\date{\today}

\begin{document}
\maketitle

\begin{abstract}
This paper investigates...
\end{abstract}

\section{Introduction}
The study of manifolds...

\end{document}
```

### Example 2: Multi-Author Collaboration

```latex
\documentclass{zigma-class/zigma}

\zigmasetup{
  % Three institutions
  affiliations.0 = {CERN - Geneva - Switzerland},
  affiliations.1 = {University of California - Berkeley - USA},
  affiliations.2 = {University of Tokyo - Japan},
  
  % Lead author (CERN + Berkeley)
  authors.0.name = {Dr. Sarah Chen},
  authors.0.email = {s.chen@cern.ch},
  authors.0.orcid = {0000-0001-2345-6789},
  authors.0.affiliation = {0,1},
  authors.0.corresponding = {true},
  
  % Second author (Berkeley only)
  authors.1.name = {Prof. Michael Brown},
  authors.1.email = {m.brown@berkeley.edu},
  authors.1.orcid = {0000-0002-3456-7890},
  authors.1.affiliation = {1},
  
  % Third author (Tokyo only)
  authors.2.name = {Dr. Yuki Tanaka},
  authors.2.email = {y.tanaka@u-tokyo.ac.jp},
  authors.2.affiliation = {2},
  
  % Metadata
  metadata.doi = {10.1234/phys.2024.042},
  metadata.received = {2024-01-15},
  metadata.accepted = {2024-03-20},
  metadata.keywords = {particle physics, LHC, Higgs boson},
  metadata.license = {CC-BY-4.0},
}

\title{Measurement of Higgs Boson Properties at 13 TeV}
\date{\today}

\begin{document}
\maketitle

\begin{abstract}
We present measurements...
\end{abstract}

\section{Introduction}
Content...

\end{document}
```

### Example 3: Using Templates (v0.8.5)

Pre-configured templates simplify common document types:

#### Il Cibernetico Template
```latex
\documentclass[template=ilcibernetico,bibfile=refs.bib]{zigma-class/zigma}

\zigmasetup{
  title = {Artificial Intelligence in Robotics},
  small.title = {AI in Robotics},
  abstract = {This paper explores...},
  keywords = {AI, robotics, machine learning},
  journal.name = {Il Cibernetico},
  
  authors.0.name = {Marco Rossi},
  authors.0.email = {m.rossi@univ.it},
  authors.0.corresponding = true,
  
  affiliations.0 = {University of Rome - CS Dept},
}

\begin{document}
\maketitle
\section{Introduction}
Research shows \zigmacite{key1}...
\zigmaprintbib
\end{document}
```

**Features**: Green theme (#096), IEEE bibliography, smart headers (small.title or title + lead author)

#### IEEE Template
```latex
\documentclass[template=ieee,bibfile=refs.bib]{zigma-class/zigma}

\zigmasetup{
  title = {Novel Machine Learning Algorithm},
  authors.0.name = {Alice Johnson},
  authors.0.corresponding = true,
}

\begin{document}
\maketitle
Your IEEE-style paper...
\zigmaprintbib
\end{document}
```

#### APA Template
```latex
\documentclass[template=apa,bibfile=refs.bib]{zigma-class/zigma}

\zigmasetup{
  title = {Cognitive Development in Children},
  authors.0.name = {Sarah Smith},
}

\begin{document}
\maketitle
Your APA-style paper...
\zigmaprintbib
\end{document}
```

#### Nature Template
```latex
\documentclass[template=nature,bibfile=refs.bib]{zigma-class/zigma}

\zigmasetup{
  title = {CRISPR Gene Editing Breakthrough},
  authors.0.name = {Dr. Chen},
}

\begin{document}
\maketitle
Your Nature-style article...
\zigmaprintbib
\end{document}
```

#### Thesis Template
```latex
\documentclass[template=thesis]{zigma-class/zigma}

\zigmasetup{
  title = {Deep Learning Applications},
  subtitle = {A Comprehensive Study},
  authors.0.name = {John Doe},
  affiliations.0 = {University Name - Department},
}

\begin{document}
\maketitle
\chapter{Introduction}
Your thesis content...
\end{document}
```

**Available templates**: `ilcibernetico`, `ieee`, `apa`, `nature`, `thesis`

See test files: `test-template-*.tex` for complete working examples.

### Example 4: With Debug Mode

```latex
\documentclass{zigma-class/zigma}

\zigmasetup{
  % Enable debug to see what's happening
  debug = true,
  
  affiliations.0 = {Test University},
  
  authors.0.name = {Test Author},
  authors.0.email = {test@example.com},
  authors.0.affiliation = {0},
}

\title{Test Document}
\date{\today}

\begin{document}
\maketitle
Test content
\end{document}
```

### Example 5: Smart Cross-References (v0.9.0) 🆕

Intelligent referencing with automatic type detection:

```latex
\documentclass{zigma-class/zigma}

\zigmasetup{
  title = {Cross-Reference Examples},
  authors.0.name = {Research Team},
}

\begin{document}
\maketitle

\section{Introduction}
\label{sec:intro}

This section introduces the topic.

\section{Background}
\label{sec:background}

Some background information.

\begin{figure}[h]
\centering
\rule{5cm}{3cm}
\caption{Main diagram}
\label{fig:main}
\end{figure}

\begin{figure}[h]
\centering
\rule{4cm}{2cm}
\caption{Supporting chart}
\label{fig:support}
\end{figure}

\begin{table}[h]
\centering
\begin{tabular}{cc}
Data & Value \\
A & 10 \\
B & 20
\end{tabular}
\caption{Results table}
\label{tab:results}
\end{table}

\begin{equation}
E = mc^2
\label{eq:relativity}
\end{equation}

\section{Methods}

% Single smart reference
As discussed in \zigmaref{sec:intro}, the approach is novel.
% Output: "As discussed in Section 1, the approach is novel."

The data is shown in \zigmaref{tab:results}.
% Output: "The data is shown in Table 1."

% Multiple references with Oxford comma
See \zigmarefs{sec:intro,sec:background} for details.
% Output: "See Sections 1 and 2 for details."

The results (\zigmarefs{fig:main,fig:support}) demonstrate the concept.
% Output: "The results (Figures 1 and 2) demonstrate the concept."

% Number only (no prefix)
In Section \zigmaref*{sec:intro} we showed...
% Output: "In Section 1 we showed..."

% Uppercase
\Zigmaref{eq:relativity} is Einstein's famous equation.
% Output: "EQUATION 1 is Einstein's famous equation."

% Page references
The introduction is \zigmapageref{sec:intro}.
% Output: "The introduction is on page 1."

% Full reference
See \zigmafullref{fig:main} for details.
% Output: "See Figure 1 on page 2 for details."

\end{document}
```

**Language customization example**:

```latex
\zigmasetup{
  % German labels
  labels.section = {Abschnitt},
  labels.figure = {Abbildung},
  labels.table = {Tabelle},
  labels.equation = {Gleichung},
  
  % German plurals
  labels.sections = {Abschnitte},
  labels.figures = {Abbildungen},
  labels.tables = {Tabellen},
  labels.equations = {Gleichungen},
}

% Now: \zigmaref{sec:intro} → "Abschnitt 1"
%      \zigmarefs{fig:a,fig:b} → "Abbildungen 1 and 2"
```

---

## Troubleshooting

### Authors Not Appearing

**Symptom**: Authors defined in `\zigmasetup` don't show up in output.

**Solutions**:
1. ✅ Check that `debug = true` shows the authors are registered
2. ✅ Verify author indexing starts at 0 (not 1)
3. ✅ Ensure affiliations are defined before use
4. ✅ Check for typos in field names (`corresponding` not `correspondent`)

**Debug checklist**:
```latex
\zigmasetup{
  debug = true,  % See what's registered
  
  % Check output includes:
  % === ZIGMA AUTHORS START===
  % id=0 name=Your Name ...
  % === ZIGMA AUTHORS END===
}
```

### Compilation Errors

#### Error: `Missing \endcsname`

**Cause**: Syntax error in expl3 code or malformed input.

**Solution**: Check for:
- Empty braces in weird places
- Unmatched braces in author/affiliation values
- Special characters not escaped

```latex
% Bad
affiliations.0 = {Company & Co.}  % & needs escaping

% Good
affiliations.0 = {Company \& Co.}
```

#### Error: `Unknown key`

**Cause**: Typo in key name or unsupported key.

**Solution**: Check spelling:
```latex
% Wrong
authors.0.orcid_id = {...}  % underscore not supported

% Correct
authors.0.orcid = {...}
```

### Affiliation Numbers Wrong

**Symptom**: Affiliation superscripts show wrong numbers.

**Cause**: Affiliation IDs don't match.

**Solution**: Verify ID consistency:
```latex
\zigmasetup{
  % Define first
  affiliations.0 = {Uni A},
  affiliations.1 = {Uni B},
  
  % Reference by ID
  authors.0.affiliation = {0},  % Must match defined ID
  authors.1.affiliation = {1},
}
```

### Font Warnings

**Symptom**: `Font shape undefined` warnings.

**Cause**: Requested font not available in your TeX distribution.

**Solution**: Either install the font or choose an alternative:
```latex
% If stix2 not available
fonts.serif = {times},  % Fallback to Times

% Or check what's available
% texdoc fontname
```

### PDF Not Generating

**Symptom**: Compilation hangs or times out.

**Solutions**:
1. ✅ Try with `debug = false` (verbose logging can slow compilation)
2. ✅ Check for infinite loops in custom code
3. ✅ Reduce number of authors temporarily to isolate issue
4. ✅ Use `make klean` to clean auxiliary files

```bash
cd your-project
make klean     # Or: latexmk -C
lualatex your-document.tex
```

### ORCID Not Displaying

**Current Status**: ORCID is stored but not yet rendered in PDF output.

**Workaround**: Access via debug mode or wait for v0.5.0 which will include ORCID icon rendering.

---

## FAQ

### Can I use pdfLaTeX instead of LuaLaTeX?

**Answer**: LuaLaTeX is recommended for best results. pdfLaTeX may work but is not officially supported.

### How do I add a co-first author?

**Answer**: Currently not directly supported. Workaround:
```latex
authors.0.name = {John Doe$^*$},
authors.1.name = {Jane Smith$^*$},
```
Then add footnote explaining `*` means co-first author.

### Can I use BibTeX/BibLaTeX?

**Answer**: Yes! Zigma is compatible with standard bibliography packages:
```latex
\usepackage[style=numeric]{biblatex}
\addbibresource{references.bib}
...
\printbibliography
```

### How do I change the document to single-column?

**Answer**: Pass option to base class:
```latex
\documentclass[onecolumn]{zigma-class/zigma}
```

### Can I customize section formatting?

**Answer**: Currently limited. Future versions will include hooks. For now, use standard LaTeX commands after `\begin{document}`:
```latex
\begin{document}
\renewcommand{\section}{...}  % Customize
```

### Is Zigma suitable for books?

**Answer**: Zigma is designed for journal articles. For books, consider using `memoir` or `book` class.

### How do I report bugs?

**Answer**: Open an issue at: https://git.xed.it/exedre/zigma-class/issues

Include:
- Minimal reproducible example
- Compilation log with `debug = true`
- LaTeX distribution version

---

## Quick Reference Card

### Most Common Keys

```latex
\zigmasetup{
  % Authors (minimum required)
  authors.0.name = {Name},
  authors.0.affiliation = {0},
  affiliations.0 = {Institution},
  
  % Often used
  authors.0.email = {email@domain.com},
  authors.0.orcid = {0000-0000-0000-0000},
  authors.0.corresponding = {true},
  
  % Metadata
  metadata.doi = {10.xxxx/xxxxx},
  metadata.keywords = {keyword1, keyword2},
  
  % Layout
  margin.left = 2.5cm,
  margin.right = 2.5cm,
  
  % Debug
  debug = true,  % During development only
}
```

---

## Getting Help

1. **Check this guide** - Most common issues covered above
2. **Enable debug mode** - See what Zigma is doing
3. **Check examples** - `test-*.tex` files in repository
4. **Read the code docs** - [`docs/CODE_ARCHITECTURE.md`](CODE_ARCHITECTURE.md)
5. **Search issues** - https://git.xed.it/exedre/zigma-class/issues
6. **Ask for help** - Open new issue with minimal example

---

## Next Steps

- Read [Code Architecture](CODE_ARCHITECTURE.md) for advanced customization
- Check [CHANGELOG](../CHANGELOG.md) for version history
- Contribute improvements via pull requests

---

**Happy writing with Zigma!** 📝

*Last updated: 2025-11-05 | Version 0.5.0 | Released*
