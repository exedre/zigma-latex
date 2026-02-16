%% Zigma LaTeX Class - Pure expl3 Implementation
%% Modular rendering system with pluggable baseclasses and templates
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\RequirePackage{expl3}[2022-06-01]
\ProvidesExplClass
  {zigma}
  {2025-11-09}
  {1.0.0}
  {Zigma class — base class rendering}

%% Essential packages (loaded before base class)
\RequirePackage{xcolor}

\ExplSyntaxOn

%% ========================================================================
%% Basic Logging (needed early)
%% ========================================================================

\cs_new_protected:Npn \zigma_log:n #1 { \iow_now:Nn \c_term_iow {#1} }
\cs_new_protected:Npn \zigma_log:x #1 { \iow_now:Nx \c_term_iow {#1} }

\ExplSyntaxOff

%% ========================================================================
%% Class Options Processing with expl3
%% 
%% Zigma supports z-prefixed options in \documentclass[...]{zigma}:
%% - zbaseclass  : LaTeX class name (article, scrbook, memoir, etc.)
%% - zbase       : Renderer name (article, memoir, koma, rho)
%% - zmargin*    : Layout margins (left, right, top, bottom)
%% - zcolumnsep  : Column separation
%% - zbib*       : Bibliography options
%% - ztemplate   : Template selection
%%
%% Unknown options are automatically passed to the baseclass.
%% All other configuration (title, authors, metadata) is done via
%% \zigmasetup{...} after \begin{document}.
%% ========================================================================

%% Load the option parser module (expl3-based)
\InputIfFileExists{zigma-options.code.tex}
  { }
  { \ClassError{zigma}{Missing~zigma-options.code.tex}{} }

%% ========================================================================
%% Collect All Class Options (LaTeX2e level)
%% ========================================================================

% Token list to collect all options (plain TeX register, LaTeX2e-safe name)
\newtoks\gzigmaalloptionstoks

% Capture all unknown options into the token list
\DeclareOption*{%
  \begingroup
  \edef\zigmatmp{\the\gzigmaalloptionstoks}%
  \if\relax\detokenize\expandafter{\zigmatmp}\relax
    \global\gzigmaalloptionstoks=\expandafter{\CurrentOption}%
  \else
    \global\gzigmaalloptionstoks=\expandafter{\zigmatmp,\CurrentOption}%
  \fi
  \endgroup
}

% Process options at LaTeX2e level (does nothing except trigger \DeclareOption*)
\ProcessOptions\relax

%% ========================================================================
%% Parse Options with expl3 and Determine Baseclass
%% ========================================================================

\ExplSyntaxOn

% Parse all collected options using the custom parser
\zigma_parse_all_options:

% ------------------------------------------------------------------------
% Compatibility bridge for existing renderer/modules expecting \zigma@... vars
% ------------------------------------------------------------------------
\cs_set:cpx { zigma@marginleft } { \tl_use:N \g_zigma_zmarginleft_tl }
\cs_set:cpx { zigma@marginright } { \tl_use:N \g_zigma_zmarginright_tl }
\cs_set:cpx { zigma@margintop } { \tl_use:N \g_zigma_zmargintop_tl }
\cs_set:cpx { zigma@marginbottom } { \tl_use:N \g_zigma_zmarginbottom_tl }
\cs_set:cpx { zigma@columnsep } { \tl_use:N \g_zigma_zcolumnsep_tl }
\cs_set:cpx { zigma@base } { \tl_use:N \g_zigma_zbase_tl }
\cs_set:cpx { zigma@baseclass } { \tl_use:N \g_zigma_zbaseclass_tl }
\cs_set:cpx { zigma@plugin } { \tl_use:N \g_zigma_zbase_tl }
\cs_set:cpx { zigma@bibpreset } { \tl_use:N \g_zigma_zbibpreset_tl }
\cs_set:cpx { zigma@bibfile } { \tl_use:N \g_zigma_zbibfile_tl }
\cs_set:cpx { zigma@bibbackend } { \tl_use:N \g_zigma_zbibbackend_tl }
\cs_set:cpx { zigma@bibstyle } { \tl_use:N \g_zigma_zbibstyle_tl }
\cs_set:cpx { zigma@template } { \tl_use:N \g_zigma_ztemplate_tl }

% kvoptions-style boolean used later in this class
\newif\ifzigma@bib
\bool_if:NTF \g_zigma_zbib_bool { \zigma@bibtrue } { \zigma@bibfalse }

% Now we have:
% - \l_zigma_final_baseclass_tl = the class to load
% - \l_zigma_baseclass_options_tl = options to pass to it
% - All \g_zigma_z* variables set with values

\ExplSyntaxOff

%% ========================================================================
%% Load the Base Class with All Options
%% ========================================================================

% Bridge expl3 option vars to LaTeX2e-safe macros for \LoadClass.
\ExplSyntaxOn
\cs_set:Npx \zigmabaseclassoptions { \l_zigma_baseclass_options_tl }
\cs_set:Npx \zigmabaseclassname { \l_zigma_final_baseclass_tl }
\str_if_eq:VnT \zigmabaseclassname { memoir }
  {
    % memoir defines \@namelet with \newcommand and can clash in this load order
    \cs_undefine:c { @namelet }
  }
\ExplSyntaxOff
\LoadClass[\zigmabaseclassoptions]{\zigmabaseclassname}

%% ========================================================================
%% Additional Packages (loaded after base class to avoid conflicts)
%% ========================================================================

% Allow URL line breaks (especially important in two-column bibliography)
\PassOptionsToPackage{hyphens}{url}
\RequirePackage{hyperref}
\RequirePackage{xurl}
\RequirePackage{marvosym}
\RequirePackage{academicons}

% Encourage URL breaks at many punctuation points.
\Urlmuskip=0mu plus 2mu\relax

%% ========================================================================
%% Load Baseclass Renderer and Template
%% ========================================================================

% Load the loader module (handles baseclass renderers and templates)
\InputIfFileExists{zigma-loader.code.tex}
  { }
  { \ClassError{zigma}{Missing~zigma-loader.code.tex}{} }

\ExplSyntaxOn

% Load baseclass renderer and template (if specified)
\zigma_load_baseclass_and_template:
\ExplSyntaxOn

% Store the baseclass in expl3 variable
\tl_new:N \g_zigma_baseclass_tl
\tl_gset:Nn \g_zigma_baseclass_tl { \l_zigma_final_baseclass_tl }
\zigma_log:x { [ZIGMA]~Base~class~loaded:~\g_zigma_baseclass_tl }

%% ========================================================================
%% Color Definitions
%% ========================================================================

% Predicate: does a color with this name already exist?
\prg_new_conditional:Npnn \zigma_color_if_exist:n #1 { T, F, TF }
  { \cs_if_exist:cTF { color@#1 } { \prg_return_true: } { \prg_return_false: } }

% Define color if it doesn't exist
\cs_new_protected:Npn \zigma_define_color_if_absent:nnn #1#2#3
  {
    \zigma_color_if_exist:nF {#1} { \definecolor{#1}{#2}{#3} }
  }

% Default color palette
\cs_new_protected:Npn \zigma_define_default_colors:
  {
    % main: dark blue
    \zigma_define_color_if_absent:nnn { zigma-main }    { rgb } { 0.08, 0.26, 0.52 }
    % section: medium blue
    \zigma_define_color_if_absent:nnn { zigma-section } { rgb } { 0.10, 0.35, 0.65 }
    % accent: bright red
    \zigma_define_color_if_absent:nnn { zigma-accent }  { rgb } { 0.85, 0.20, 0.20 }
    % box-bg: light gray
    \zigma_define_color_if_absent:nnn { zigma-box-bg }  { rgb } { 0.95, 0.95, 0.95 }
    % box-line: dark gray
    \zigma_define_color_if_absent:nnn { zigma-box-line }{ rgb } { 0.60, 0.60, 0.60 }
  }

\zigma_define_default_colors:

%% ========================================================================
%% Load Core Modules (DO NOT MODIFY THESE)
%% ========================================================================
\InputIfFileExists{zigma-core.code.tex}{}
  {\ClassError{zigma}{Missing~zigma-core.code.tex}{}}
\InputIfFileExists{zigma-keys.code.tex}{}
  {\ClassError{zigma}{Missing~zigma-keys.code.tex}{}}
\InputIfFileExists{zigma-authors.code.tex}{}
  {\ClassError{zigma}{Missing~zigma-authors.code.tex}{}}
\InputIfFileExists{zigma-bib.code.tex}{}
  {\ClassError{zigma}{Missing~zigma-bib.code.tex}{}}
\InputIfFileExists{zigma-crossref.code.tex}{}
  {\ClassError{zigma}{Missing~zigma-crossref.code.tex}{}}

\ExplSyntaxOff

%% ========================================================================
%% Bibliography Setup (must be in preamble, before \begin{document})
%% ========================================================================

\ifzigma@bib
  \ExplSyntaxOn
  \zigma_log:n { [ZIGMA]~Bibliography~enabled~via~class~option }
  
  % Enable bibliography
  \bool_gset_true:N \g_zigma_bib_enable_bool
  
  % Apply preset if specified
  \tl_set:Nx \l_tmpa_tl { \zigma@bibpreset }
  \tl_trim_spaces:N \l_tmpa_tl
  \tl_if_empty:NF \l_tmpa_tl
    {
      \zigma_bib_apply_preset:V \l_tmpa_tl
    }
  
  % Override backend if specified
  \tl_set:Nx \l_tmpa_tl { \zigma@bibbackend }
  \tl_trim_spaces:N \l_tmpa_tl
  \tl_if_empty:NF \l_tmpa_tl
    {
      \tl_gset:NV \g_zigma_bib_backend_tl \l_tmpa_tl
    }
  
  % Override style if specified
  \tl_set:Nx \l_tmpa_tl { \zigma@bibstyle }
  \tl_trim_spaces:N \l_tmpa_tl
  \tl_if_empty:NF \l_tmpa_tl
    {
      \tl_gset:NV \g_zigma_bib_style_tl \l_tmpa_tl
    }
  
  % Load bibliography package
  \zigma_bib_load:
  
  % Add bibliography file(s) if specified
  \tl_set:Nx \l_tmpa_tl { \zigma@bibfile }
  \tl_trim_spaces:N \l_tmpa_tl
  \tl_if_empty:NF \l_tmpa_tl
    {
      % Check if comma-separated list (multiple files)
      \tl_if_in:NnTF \l_tmpa_tl { , }
        {
          % Multiple files: split and load each
          \clist_set:NV \l_tmpa_clist \l_tmpa_tl
          \clist_map_inline:Nn \l_tmpa_clist
            {
              \tl_set:Nn \l_tmpb_tl { #1 }
              \tl_trim_spaces:N \l_tmpb_tl
              \zigma_bib_add_resource:V \l_tmpb_tl
            }
        }
        {
          % Single file
          \zigma_bib_add_resource:V \l_tmpa_tl
        }
    }
  \ExplSyntaxOff
\fi

\ExplSyntaxOn

%% ========================================================================
%% Document Commands
%% ========================================================================

\cs_new_protected:Npn \zigmaApplySetup { \zigma_apply_setup: }

%% ========================================================================
%% Override base class \maketitle 
%% ========================================================================

% Save original \maketitle from base class and redefine it
\ExplSyntaxOff
\let\zigma@original@maketitle\maketitle
\ExplSyntaxOn

\RenewDocumentCommand{\maketitle}{}
  {
    \cs_if_exist:NTF \zigma_render_maketitle:
      {
        \zigma_render_maketitle:
      }
      {
        \ClassWarning { zigma } { No~\string\maketitle~implementation~in~plugin }
        \zigma@original@maketitle
      }
  }

\ExplSyntaxOff

\AddToHook{begindocument}{\zigmaApplySetup}

\endinput
