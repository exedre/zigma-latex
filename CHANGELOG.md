# Changelog

All notable changes to this project are documented in this file.

## [1.1.0] - 2026-02-16

**Refinement & Documentation Enhancement** 🎯

### Changes

**Code Quality**:
- Consolidated `journal.name` variable - removed duplicate `journalname` alias for cleaner API
- Fixed variable synchronization in template system (zigma-template-ilcibernetico)
- Improved consistency across all rendering backends

**Documentation**:
- Rewrote parser rules section from bullet lists to flowing narrative prose
- Expanded "Risoluzione base class e renderer" section with detailed examples
- Added practical step-by-step walkthroughs for common scenarios
- Improved clarity of option descriptions throughout documentation
- Added z-prefix namespace convention documentation

**Developer Tools**:
- Created sync script (`bin/sync-from-github.sh`) for repository synchronization

**Tests**:
- All 31 tests passing ✅
- Verified journal.name functionality

### Fixes
- Resolved journal name variable inconsistency
- Clarified documentation language (removed formal address, improved narrative flow)

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
