# Changelog

All notable changes to this project are documented in this file.

## [1.0.2] - 2025-11-13

**Baseclass Option Pass-Through Feature**

### Added

- **Transparent Option Pass-Through**: Unknown class options are now passed directly to the selected baseclass
  - Users can now use baseclass-specific options: `\documentclass[base=scrbook,open=right,DIV=12]{zigma}`
  - Works with all supported baseclasses (article, memoir, KOMA, rho)
  - Zero configuration required
  - Backward compatible (no breaking changes)

- **Supported Baseclass Options**:
  - KOMA-Script (scrartcl, scrreprt, scrbook): `open=right|left`, `DIV=<n>`, `fontsize`, `BCOR`, `pagesize`, `twoside`
  - Memoir: `onecolumn|twocolumn`, `openright|openany`, `twoside|oneside`, `showtrims`
  - Article/Extarticle: `fontsize`, `twocolumn|onecolumn`, `twoside|oneside`

- **New Example**: `examples/baseclass-options.tex` (9 chapters, 288 lines)
  - Comprehensive usage guide for all baseclasses
  - Practical examples for common use cases
  - Troubleshooting section
  - Option references

### Technical Changes

- Refactored class option processing in `zigma.cls`
- Added token list for collecting unknown options
- Implemented two-phase option processing:
  1. Zigma-specific options via kvoptions
  2. Unknown options collected and passed to `\LoadClass`

### Examples

```latex
% KOMA-Script book with custom layout
\documentclass[base=scrbook,open=right,DIV=12,fontsize=12pt,twoside]{zigma}

% Large print article
\documentclass[base=extarticle,fontsize=18pt]{zigma}

% European journal format
\documentclass[base=scrartcl,DIV=12,BCOR=1.5cm,twoside]{zigma}

% Memoir thesis
\documentclass[base=memoir,onecolumn,twoside,fontsize=12pt]{zigma}
```

### Benefits

✅ Full access to baseclass feature set  
✅ No "Unused global option(s)" warnings  
✅ Intuitive LaTeX syntax (familiar to all users)  
✅ Minimal performance overhead  
✅ Enables accessibility (large print), professional typography, specialized journals

### Documentation

- AGENTS.md: Detailed session notes (223 lines)
- examples/baseclass-options.tex: Comprehensive guide
- Inline comments updated in zigma.cls

---

## [1.0.0] - 2025-11-09

**Official CTAN Release** 🎉

### Features (100% Complete)

**Core Functionality**:
- Multi-author management with ORCID integration
- Smart cross-reference system with auto-detection (11 label types)
- Bibliography system with 15 citation styles
- Template system with 5 ready-to-use templates
- 4 baseclass renderers (article, memoir, KOMA, rho)
- Configurable headers/footers for all baseclasses
- Metadata footer (DOI, dates, license)
- Clickable titles and author emails
- Corresponding author system with multiple markers

**Citation Styles** (15 total):
IEEE, APA 7th, Chicago, Nature, Harvard, Vancouver, MLA 8th, Philosophy, Numeric, Authoryear, Alphabetic, Authoryear-comp, ACM, Trad-abbrv, Custom

**Cross-Reference Commands** (6):
`\zigmaref`, `\Zigmaref`, `\zigmaref*`, `\zigmarefs`, `\zigmapageref`, `\zigmafullref`

**Templates** (5):
ilcibernetico, ieee, apa, nature, thesis

**Documentation**:
- Complete user manual (65 pages)
- Installation guide
- 4 polished examples
- 100% code documentation

**Quality**:
- 47 tests, 100% passing
- Code quality: 91.6/100
- <5 seconds compile
- LPPL 1.3c License

---

**Repository**: https://github.com/exedre/zigma-latex  
**License**: LPPL 1.3c
