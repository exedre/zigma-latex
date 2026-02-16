# Zigma LaTeX Class - Installation Guide

This guide provides detailed instructions for installing the Zigma LaTeX class on various systems and TeX distributions.

---

## Table of Contents

1. [Quick Installation](#quick-installation)
2. [System Requirements](#system-requirements)
3. [Installation Methods](#installation-methods)
   - [Method 1: Package Manager (Recommended)](#method-1-package-manager-recommended)
   - [Method 2: Manual TDS Installation](#method-2-manual-tds-installation)
   - [Method 3: Local Directory](#method-3-local-directory)
4. [Verification](#verification)
5. [Troubleshooting](#troubleshooting)
6. [Uninstallation](#uninstallation)

---

## Quick Installation

**For TeX Live users:**
```bash
tlmgr install zigma
```

**For MiKTeX users:**
```bash
mpm --install=zigma
```

**For development/testing:**
```bash
git clone https://github.com/exedre/zigma-latex.git
cd zigma-class
```

Then use: `\documentclass{zigma-class/zigma}`

---

## System Requirements

### Required

- **TeX Distribution**: TeX Live 2022 or later, MiKTeX 2022 or later
- **LaTeX Engine**: LuaLaTeX (recommended), XeLaTeX, or pdfLaTeX
- **Packages**:
  - `expl3` (LaTeX3 programming layer)
  - `xparse` (command parsing)
  - `hyperref` (hyperlinks and metadata)
  - `xcolor` (color support)

### Optional (for specific features)

- `biblatex` + `biber` - For bibliography support
- `academicons` - For ORCID icons
- `marvosym` - For symbols (corresponding author markers)
- `fancyhdr` - For custom headers/footers (rho base class)
- `geometry` - For layout configuration (rho base class)
- `memoir` - For memoir base class
- `KOMA-Script` - For scrartcl/scrreprt/scrbook base classes

### Disk Space

- Runtime files: ~230 KB
- Documentation: ~680 KB
- Total: ~900 KB

---

## Installation Methods

### Method 1: Package Manager (Recommended)

Once Zigma is available on CTAN, this is the easiest method.

#### TeX Live

```bash
# Update package database
tlmgr update --self

# Install Zigma
tlmgr install zigma

# Verify installation
tlmgr info zigma
```

#### MiKTeX

```bash
# Update package database
mpm --update-db

# Install Zigma
mpm --install=zigma

# Verify installation
mpm --list | grep zigma
```

### Method 2: Manual TDS Installation

For manual installation following the TeX Directory Structure.

#### Step 1: Determine Your texmf Directory

**Linux/Mac:**
```bash
kpsewhich -var-value=TEXMFHOME
# Usually: ~/texmf
```

**Windows:**
```cmd
kpsewhich -var-value=TEXMFHOME
# Usually: C:\Users\<username>\texmf
```

#### Step 2: Extract and Copy Files

Download the TDS-compliant archive and extract it:

```bash
# Download (replace URL with actual CTAN URL when available)
wget https://mirrors.ctan.org/install/macros/latex/contrib/zigma.tds.zip

# Extract to your texmf directory
unzip zigma.tds.zip -d $(kpsewhich -var-value=TEXMFHOME)
```

Or manually copy the TDS structure:

**Linux/Mac:**
```bash
cp -r TDS/tex/latex/zigma ~/texmf/tex/latex/
cp -r TDS/doc/latex/zigma ~/texmf/doc/latex/
cp -r TDS/source/latex/zigma ~/texmf/source/latex/
```

**Windows:**
```cmd
xcopy /E /I TDS\tex\latex\zigma %USERPROFILE%\texmf\tex\latex\zigma
xcopy /E /I TDS\doc\latex\zigma %USERPROFILE%\texmf\doc\latex\zigma
xcopy /E /I TDS\source\latex\zigma %USERPROFILE%\texmf\source\latex\zigma
```

#### Step 3: Update Filename Database

```bash
# TeX Live
texhash

# or
mktexlsr

# MiKTeX
initexmf --update-fndb
```

### Method 3: Local Directory

For testing or development without system installation.

#### Step 1: Clone or Download

```bash
git clone https://github.com/exedre/zigma-latex.git
```

Or download and extract the archive.

#### Step 2: Use Relative Path

In your LaTeX document:

```latex
\documentclass{zigma-class/zigma}
```

Or add to your project:

```latex
\documentclass{./zigma}
```

After copying `zigma-class/` contents to your project directory.

---

## Verification

### Test Installation

Create a test file `test-zigma.tex`:

```latex
\documentclass{zigma}

\zigmasetup{
  title = {Installation Test},
  
  affiliations.0 = {Test University},
  
  authors.0.name = {Test Author},
  authors.0.email = {test@example.edu},
  authors.0.affiliation = {0},
  
  abstract = {This is a test document to verify Zigma installation.},
  keywords = {test, installation, verification},
}

\begin{document}

\maketitle

\section{Introduction}

If you can compile this document successfully, Zigma is correctly installed!

\section{Features Test}

Testing smart cross-references: see \zigmaref{sec:introduction} for context.

\end{document}
```

### Compile Test

```bash
lualatex test-zigma.tex
lualatex test-zigma.tex  # Run twice for cross-references
```

### Expected Output

- No compilation errors
- PDF with title, author, affiliation
- Abstract and keywords displayed
- Sections numbered and cross-referenced

### Verify Package Files

**TeX Live:**
```bash
kpsewhich zigma.cls
# Should output: /path/to/texmf/tex/latex/zigma/zigma.cls
```

**MiKTeX:**
```cmd
kpsewhich zigma.cls
```

### Check Documentation

```bash
# TeX Live
texdoc zigma

# Or manually open:
# Linux/Mac: ~/texmf/doc/latex/zigma/zigma.pdf
# Windows: %USERPROFILE%\texmf\doc\latex\zigma\zigma.pdf
```

---

## Troubleshooting

### Class File Not Found

**Error:** `LaTeX Error: File 'zigma.cls' not found.`

**Solutions:**

1. **Update filename database:**
   ```bash
   texhash
   # or
   mktexlsr
   ```

2. **Check installation path:**
   ```bash
   kpsewhich zigma.cls
   ```
   
   If no output, files not in correct location.

3. **Verify TEXMFHOME:**
   ```bash
   echo $TEXMFHOME
   # Should be set and accessible
   ```

4. **Manual path specification:**
   ```latex
   \documentclass{/full/path/to/zigma}
   ```

### Missing Dependencies

**Error:** `Package expl3 not found` or similar.

**Solution:** Install required packages:

**TeX Live:**
```bash
tlmgr install expl3 xparse hyperref xcolor
# Optional:
tlmgr install biblatex biber academicons marvosym
```

**MiKTeX:**
```bash
mpm --install=l3kernel --install=l3packages --install=hyperref --install=xcolor
```

### ORCID Icons Not Showing

**Problem:** ORCID identifiers display but no icon.

**Solution:** Install academicons package:

```bash
# TeX Live
tlmgr install academicons

# MiKTeX (usually auto-installed on first use)
# Or manually:
mpm --install=academicons
```

### Permission Denied

**Error:** Permission denied when copying to texmf directory.

**Solution:** 

**Option 1:** Use sudo (Linux/Mac):
```bash
sudo cp -r TDS/tex/latex/zigma /usr/local/texlive/texmf-local/tex/latex/
sudo texhash
```

**Option 2:** Use local texmf (recommended):
```bash
cp -r TDS/tex/latex/zigma ~/texmf/tex/latex/
texhash ~/texmf
```

### Bibliography Not Working

**Problem:** Bibliography not appearing.

**Solutions:**

1. **Ensure biblatex installed:**
   ```bash
   tlmgr install biblatex biber
   ```

2. **Full compilation sequence:**
   ```bash
   lualatex document.tex
   biber document
   lualatex document.tex
   lualatex document.tex
   ```

3. **Or use latexmk:**
   ```bash
   latexmk -lualatex document.tex
   ```

### Headers/Footers Not Customizable

**Problem:** Custom headers/footers ignored.

**Solution:** 

Header/footer customization fully supported only in rho base class:

```latex
\documentclass[base=rho]{zigma}

\zigmasetup{
  header.left = {Custom Header},
  footer.center = {\thepage},
}
```

For other base classes, use their native mechanisms.

---

## Uninstallation

### TeX Live / MiKTeX (Package Manager)

```bash
# TeX Live
tlmgr remove zigma

# MiKTeX
mpm --uninstall=zigma
```

### Manual Installation

Remove the directories:

**Linux/Mac:**
```bash
rm -rf ~/texmf/tex/latex/zigma
rm -rf ~/texmf/doc/latex/zigma
rm -rf ~/texmf/source/latex/zigma
texhash ~/texmf
```

**Windows:**
```cmd
rmdir /S /Q %USERPROFILE%\texmf\tex\latex\zigma
rmdir /S /Q %USERPROFILE%\texmf\doc\latex\zigma
rmdir /S /Q %USERPROFILE%\texmf\source\latex\zigma
initexmf --update-fndb
```

### Verification

```bash
kpsewhich zigma.cls
# Should return nothing
```

---

## Platform-Specific Notes

### Linux

- **TeX Live:** Standard installation locations work well
- **Local texmf:** Usually `~/texmf`
- **System-wide:** `/usr/local/texlive/texmf-local` (requires sudo)

### macOS

- **MacTeX:** Based on TeX Live, same instructions apply
- **Local texmf:** `~/Library/texmf`
- **Editor:** TeXShop, TeXstudio, VS Code with LaTeX Workshop

### Windows

- **MiKTeX:** Automatic package installation often works
- **TeX Live on Windows:** Same as Linux instructions
- **Local texmf:** `C:\Users\<username>\texmf`
- **Editor:** TeXstudio, TeXmaker, VS Code

---

## Getting Help

If installation problems persist:

1. **Check version compatibility:**
   ```bash
   lualatex --version
   # Should be 2022 or later
   ```

2. **Read the manual:**
   - See `zigma.pdf` for complete documentation
   - 65 pages covering all features

3. **Community support:**
   - **Repository:** https://github.com/exedre/zigma-latex
   - **Issues:** https://github.com/exedre/zigma-latex/issues
   - **Email:** emmanuele@exedre.org

4. **Check logs:**
   - LaTeX log file: `document.log`
   - Look for "file not found" errors
   - Check package loading messages

---

## Update Instructions

### Package Manager

```bash
# TeX Live
tlmgr update zigma

# MiKTeX (usually automatic)
mpm --update=zigma
```

### Manual Installation

Download new version and repeat installation steps, overwriting existing files.

---

## Version Information

- **Current Version:** 0.9.0
- **Released:** 2025-11-07
- **License:** LPPL 1.3c
- **Maintainer:** Emmanuele Somma

For version history, see `CHANGELOG.md`.

---

## Quick Reference

```bash
# Install (package manager)
tlmgr install zigma

# Verify
kpsewhich zigma.cls

# Update filename database
texhash

# Test
lualatex test.tex

# Documentation
texdoc zigma

# Uninstall
tlmgr remove zigma
```

---

**Installation complete!** See `zigma.pdf` for usage instructions.
