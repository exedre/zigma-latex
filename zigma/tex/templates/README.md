# Zigma Templates

This directory contains pre-configured templates for common document types and publisher styles.

## What is a Template?

A template pre-configures Zigma with sensible defaults for a specific use case (e.g., IEEE conference paper, Nature article, thesis). Templates set:
- Base class and layout options (margins, columns)
- Default headers/footers
- Bibliography style
- Other style-specific settings

## Using Templates

```latex
% Simple usage
\documentclass[ztemplate=ieee-conference]{zigma}

% Override template defaults
\documentclass[ztemplate=ieee-conference,zmarginleft=1in]{zigma}

% With bibliography
\documentclass[ztemplate=ieee-conference,zbibfile=refs.bib]{zigma}
```

## Available Templates

### ieee-conference
IEEE conference paper (two-column format)
- **Base class**: article
- **Layout**: Two-column, 0.75in margins
- **Bibliography**: IEEE numeric style
- **Headers**: Title (left), Page number (right)

### nature
Nature journal article style
- **Base class**: article  
- **Layout**: Single column, compact
- **Bibliography**: Nature numeric compact style
- **Headers**: Minimal

### thesis-simple
Simple thesis template
- **Base class**: memoir
- **Layout**: Single column, standard margins
- **Bibliography**: Numeric sorted
- **Features**: Chapter support

## Template Behavior

**Priority (highest to lowest)**:
1. User-specified class options (always win)
2. Template defaults
3. Zigma defaults

**Override examples**:
```latex
% Template sets zmarginleft=0.75in, but user overrides:
\documentclass[ztemplate=ieee-conference,zmarginleft=1in]{zigma}
% Result: zmarginleft=1in (user wins)

% Template sets zbaseclass=article, but user overrides:
\documentclass[ztemplate=ieee-conference,zbaseclass=memoir]{zigma}
% Result: Warning in log + uses memoir (user wins)
```

## Creating Custom Templates

Template files are located in `zigma-class/plugins/templates/` and named `zigma-template-<label>.code.tex`.

**Example template structure**:
```latex
%% My Custom Template
\ExplSyntaxOn

% Set class options (only if not already set by user)
\tl_if_empty:NT \zigma@baseclass
  { \renewcommand{\zigma@baseclass}{article} }

\tl_if_empty:NT \zigma@marginleft
  { \renewcommand{\zigma@marginleft}{1in} }

% Define post-setup hook for zigmasetup defaults
\cs_new_protected:Npn \zigma_template_postsetup:
  {
    % Only set if user didn't specify
    \tl_if_empty:NT \g_zigma_header_left_tl
      { \tl_gset:Nn \g_zigma_header_left_tl { My~Header } }
  }

\ExplSyntaxOff
```

## Contributing Templates

We welcome community contributions! To add a template:

1. Research the official style guide
2. Create `zigma-template-<label>.code.tex`
3. Add test file `test-template-<label>.tex`
4. Document in this README
5. Submit pull request

## Notes

- Templates are **suggestions**, not strict enforcement
- Users can always override any template setting
- Templates should NOT define new commands (use standard Zigma API)
- Templates are NOT official publisher tools (use with discretion)

---

**Last Updated**: 2025-11-07
