# Zigma LaTeX Class

[![License](https://img.shields.io/badge/license-LPPL-blue.svg)](LICENSE)
[![LaTeX](https://img.shields.io/badge/LaTeX-expl3-008080.svg)](https://www.latex-project.org/)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](CHANGELOG.md)
[![CTAN](https://img.shields.io/badge/CTAN-ready-green.svg)](https://ctan.org)

A modern, flexible LaTeX document class for academic journals and scientific publications, built entirely with LaTeX3's `expl3` programming layer. Features a modular base class renderer system for different base class rendering.

---

## ✨ Features

- **📝 Multi-Author Support** - Robust system for managing multiple authors with affiliations
- **🎨 Modern Design** - Clean, professional layout with customizable colors and fonts
- **🔌 Plugin System** - Modular base class selection (article, memoir, KOMA-Script, rho)
- **📄 Abstract & Keywords** - Full-width abstract and formatted keywords rendering
- **🔗 ORCID Integration**: Automatic ORCID icon rendering with clickable links
- **✉️ Enhanced Corresponding Markers**: Configurable symbols (✉/★/*) with automatic footer
- **📑 Header/Footer Support**: Customizable headers and footers for all plugins
- **📐 Layout Configuration**: Custom margins and column separation via class options
- **✅ Optional Validation**: On-demand author-affiliation validation
- **📊 Metadata Footer**: DOI, dates, license display
- **🔗 Clickable Titles**: Hyperlinked titles with title.url
- **📚 Bibliography Integration** 🎉: Six citation presets (IEEE, APA, Chicago, Nature, etc.)
- **🔗 Smart Cross-References** 🆕: Intelligent referencing with auto-detection
  - Auto-prefix detection (Section, Figure, Table, Equation, etc.)
  - Multiple reference support with Oxford comma
  - Multilingual support (customizable labels)
  - Page and full references
- **📚 4 Complete Plugins**: 
  - **Article**: Standard LaTeX articles
  - **Memoir**: Books, theses, long documents
  - **KOMA-Script**: European typography (scrartcl, scrreprt, scrbook)
  - **Rho**: Academic journals with full metadata support
- **🔧 Highly Configurable** - Key-value interface via `\zigmasetup{...}` command
- **🌍 International Ready** - Multilingual support with customizable labels
- **🐛 Debug Mode** - Built-in debugging system for development and troubleshooting
- **📚 Well Documented** - Comprehensive inline documentation and guides
- **🚀 expl3 Based** - Modern LaTeX3 implementation for reliability and extensibility

---

## 🚀 Quick Start

### Basic Example

```latex
\documentclass{zigma-class/zigma}

\zigmasetup{
  % Document metadata
  title = {Quantum Entanglement in Multi-Particle Systems},
  subtitle = {A Comprehensive Study},
  date = {\today},
  abstract = {This paper investigates quantum entanglement in multi-particle systems...},
  keywords = {quantum mechanics, entanglement, many-body physics},
  
  % Configure authors
  affiliations.0 = {University of Rome - Department of Physics},
  affiliations.1 = {CERN - Geneva},
  
  authors.0.name = {Mario Rossi},
  authors.0.email = {mario.rossi@uniroma1.it},
  authors.0.orcid = {0000-0001-2345-6789},
  authors.0.affiliation = {0},
  authors.0.corresponding = {true},
  
  authors.1.name = {Laura Bianchi},
  authors.1.email = {laura.bianchi@cern.ch},
  authors.1.affiliation = {1},
  
  % Metadata
  metadata.doi = {10.1234/example.2024},
}

\begin{document}
\maketitle

Your content here...

\end{document}
```

### Using Different Base Classes (Plugin System)

### With Bibliography

```latex
\documentclass[bib,bibpreset=ieee,bibfile=references.bib]{zigma-class/zigma}

\zigmasetup{
  title = {Machine Learning in Bioinformatics},
  authors.0.name = {Alice Johnson},
  authors.0.corresponding = true,
  abstract = {This paper surveys recent advances...},
  keywords = {machine learning, bioinformatics, genomics},
}

\begin{document}
\maketitle

\section{Introduction}
Recent work \zigmacite{smith2024} shows...
According to \zigmatextcite{doe2023}...

\zigmaprintbib
\end{document}
```

**Available presets**: `ieee`, `apa`, `chicago`, `nature`, `numeric`, `authoryear`

See `articles/bibliography-integration.org` for complete documentation.

### Using Templates 🆕

Pre-configured templates for common use cases:

```latex
% Il Cibernetico - Green themed academic journal
\documentclass[template=ilcibernetico,bibfile=references.bib]{zigma-class/zigma}

% IEEE style paper
\documentclass[template=ieee,bibfile=references.bib]{zigma-class/zigma}

% APA style paper
\documentclass[template=apa,bibfile=references.bib]{zigma-class/zigma}

% Nature journal style
\documentclass[template=nature,bibfile=references.bib]{zigma-class/zigma}

% Thesis template
\documentclass[template=thesis]{zigma-class/zigma}
```

**Available templates**: `ilcibernetico`, `ieee`, `apa`, `nature`, `thesis`

See test files: `test-template-*.tex` for complete examples.

### Smart Cross-References 🆕

Zigma provides intelligent cross-referencing with automatic type detection:

```latex
\documentclass{zigma-class/zigma}

\begin{document}

\section{Introduction}
\label{sec:intro}

\begin{figure}
\caption{Diagram}
\label{fig:diagram}
\end{figure}

\section{Methods}

% Smart references with auto-prefix
See \zigmaref{sec:intro} for background.
% Output: "See Section 1 for background."

The results are shown in \zigmaref{fig:diagram}.
% Output: "The results are shown in Figure 1."

% Multiple references with Oxford comma
See \zigmarefs{sec:intro,sec:methods,sec:results}.
% Output: "See Sections 1, 2, and 3."

% Number only (no prefix)
Section \zigmaref*{sec:intro} discusses...
% Output: "Section 1 discusses..."

% Uppercase variant
\Zigmaref{fig:diagram} shows the data.
% Output: "FIGURE 1 shows the data."

% Page references
Details are \zigmapageref{sec:intro}.
% Output: "Details are on page 1."

% Full reference (prefix + number + page)
See \zigmafullref{fig:diagram}.
% Output: "See Figure 1 on page 3."

\end{document}
```

**Supported label types**: `sec:`, `ch:`, `fig:`, `tab:`, `eq:`, `lst:`, `alg:`, `thm:`, `lem:`, `def:`, `app:`

**Language customization**:
```latex
\zigmasetup{
  % Italian labels
  labels.section = {Sezione},
  labels.figure = {Figura},
  labels.table = {Tabella},
  labels.sections = {Sezioni},  % plural
  labels.figures = {Figure},    % plural
  labels.tables = {Tabelle},    % plural
}
% Now: \zigmaref{sec:intro} → "Sezione 1"
```

```latex
% Use article (default)
\documentclass[baseclass=article]{zigma-class/zigma}

% Or use memoir for books
\documentclass[baseclass=memoir]{zigma-class/zigma}

% Or use KOMA-Script for European typography
\documentclass[baseclass=scrartcl]{zigma-class/zigma}

% Or use rho for academic journals
\documentclass[baseclass=rho]{zigma-class/zigma}

\zigmasetup{
  title = {Your Title},
  subtitle = {Optional Subtitle},
  % ... rest of configuration
}
```

### Customizing Layout

```latex
% Custom margins and column separation
\documentclass[
  baseclass=article,
  marginleft=3cm,
  marginright=2.5cm,
  margintop=3cm,
  marginbottom=3cm,
  columnsep=25pt
]{zigma-class/zigma}

% Note: KOMA plugin only supports columnsep (uses typearea for margins)
```

### Customizing Headers and Footers 🆕

```latex
\documentclass[baseclass=article]{zigma-class/zigma}

\zigmasetup{
  title = {My Document},
  
  % Custom headers (all plugins support this)
  header.left = {Chapter Title},
  header.center = {},
  header.right = {Author Name},
  
  % Custom footers
  footer.left = {My Book},
  footer.center = {Page \thepage},  % default if not set
  footer.right = {2025},
}
```

### Compilation

```bash
lualatex your-document.tex
```

Or use the provided Makefile:

```bash
make phase2  # Compile test-phase2.tex
make auth    # Compile test-auth.tex
make plugin  # Compile test-plugin.tex (with base class renderer system)
```

---

## 📦 Installation

### From Source

```bash
# Clone the repository
git clone https://github.com/exedre/zigma-latex.git
cd zigma-class

# Test the installation
make phase2

# Include in your document
\documentclass{zigma-class/zigma}
```

### Manual Installation

Copy the `zigma-class/` directory to:
- Local project: Same directory as your `.tex` file
- User texmf: `~/texmf/tex/latex/zigma/`
- System-wide: Your TeX distribution's local tree

---

## 🎯 Configuration

Zigma uses a modern key-value configuration system:

### Document Metadata 🆕

```latex
\zigmasetup{
  title = {Your Article Title},
  subtitle = {Optional Subtitle},
  date = {\today},
}
```

### Page Layout

```latex
\zigmasetup{
  margin.left = 2.5cm,
  margin.right = 2.5cm,
  margin.top = 3cm,
  margin.bottom = 3cm,
  column.sep = 15pt,
}
```

### Fonts

```latex
\zigmasetup{
  fonts.serif = {stix2},
  fonts.sans = {helvet},
  fonts.mono = {lmtt},
}
```

### Colors

```latex
\zigmasetup{
  colors.main = {zigma-main},      % Define with \definecolor
  colors.section = {zigma-section},
  colors.accent = {zigma-accent},
}
```

### Metadata

```latex
\zigmasetup{
  metadata.doi = {10.1234/journal.2024.001},
  metadata.received = {2024-01-15},
  metadata.accepted = {2024-03-20},
  metadata.published = {2024-04-10},
  metadata.keywords = {keyword1, keyword2},
  metadata.license = {CC-BY-4.0},
}
```

### Debug Mode

```latex
\zigmasetup{
  debug = true,  % Enable verbose logging
}
```

This will display:
- All key processing
- Configuration state dump
- Author/affiliation listing

---

## 📖 Documentation

- **[User Guide](USER_GUIDE.md)** - Complete usage guide for end users
- **[CHANGELOG](CHANGELOG.md)** - Version history and changes
- **[AGENTS.md](AGENTS.md)** - AI agent contributions log

### Examples

Check the `test-*.tex` files for working examples:
- `test-auth.tex` - Basic author management
- `test-phase2.tex` - Full configuration example
- `test-phase2-debug.tex` - Debug mode demonstration
- `test-plugin.tex` - Base class renderer system with article rendering 🆕

---

## 🏗️ Architecture

Zigma is built with a modular architecture:

```
zigma.cls                      # Main class file
├── zigma-core.code.tex        # State management and defaults
├── zigma-keys.code.tex        # Key-value configuration system
├── zigma-authors.code.tex     # Author/affiliation management
└── baseclasses/                   # Base class renderer system (NEW)
    └── article/
        └── zigma-render.code.tex  # Article-specific rendering
```

### Key Components

- **State Management** - Global variables with typed registers (skip, dim, tl, bool)
- **Key Processing** - L3's `l3keys` system with regex-based dynamic routing
- **Author System** - Property lists for flexible multi-author handling
- **Debug System** - Unified logging controlled by single flag
- **Plugin System** - Modular rendering with base class abstraction 🆕

---

## 🛠️ Development

### Building from Source

```bash
# Clone repository
git clone https://github.com/exedre/zigma-latex.git
cd zigma-class

# Run tests
make auth phase2

# Clean build artifacts
make klean
```

### Requirements

- **LaTeX Distribution**: TeX Live 2022 or later
- **Engine**: LuaLaTeX recommended
- **Packages**: `expl3`, `xcolor`, `extarticle`

### Testing

```bash
make auth              # Test basic author system
make phase2            # Test full configuration
make phase2-debug      # Test with debug output
make plugin            # Test base class renderer system with article rendering
make validation        # Test author-affiliation validation
make validation-perf   # Run validation performance test
```

---

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow expl3 naming conventions
- Document all public functions
- Add tests for new features
- Update CHANGELOG.md
- Keep commits atomic and well-described

---

## 📝 License

This project is licensed under the LaTeX Project Public License (LPPL) LPPL or later.

See [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **LaTeX3 Team** - For the excellent `expl3` programming layer
- **TeX Community** - For continuous support and feedback
- **AI Agents** - Claude (Anthropic) for development assistance

---

## 📬 Contact & Support

- **Issues**: [https://github.com/exedre/zigma-latex/issues](https://github.com/exedre/zigma-latex/issues)
- **Repository**: [https://github.com/exedre/zigma-latex](https://github.com/exedre/zigma-latex)
- **Maintainer**: [exedre](https://githuv.com/exedre)

---

## 🗺️ Roadmap

### Current Version (v1.0.0)

- [x] CTAN official release


## 📊 Project Status

- ✅ **Core System**: Fully functional
- ✅ **Author Management**: Complete
- ✅ **Debug System**: Implemented
- ✅ **Documentation**: Comprehensive (2,000+ lines)
- ✅ **Validation**: Fully working (0.752s execution time)
- ✅ **Plugin System**: Implemented with article plugin
- ✅ **Rendering**: Article plugin complete with \maketitle, abstract, keywords
- ⚠️ **Additional Plugins**: In planning (memoir, KOMA-Script)
- ⚠️ **CTAN Package**: Not yet submitted


---

**Made with ❤️ using LaTeX3 and expl3**
