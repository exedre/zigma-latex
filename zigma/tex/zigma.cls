%% Zigma LaTeX Class - Pure expl3 Implementation
%% Modular rendering system with pluggable baseclasses and templates
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\RequirePackage{expl3}[2022-06-01]
\ProvidesExplClass
  {zigma-class/zigma}
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
%% Class Options Processing
%% 
%% Zigma supports options in \documentclass[...]{zigma} that control:
%% - Baseclass selection (base=, baseclass=)
%% - Layout configuration (margins, column separation)
%% - Bibliography setup (bib=, bibpreset=, etc.)
%% - Template selection (template=)
%%
%% All other configuration (title, authors, metadata, colors) is done
%% via \zigmasetup{...} after \begin{document}.
%% ========================================================================

% Load key-value option processing
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=zigma,
  prefix=zigma@
}

% Baseclass selection (deprecated: baseclass=, prefer: base=)
\DeclareStringOption[extarticle]{baseclass}
\DeclareStringOption[rho]{base}

% Layout configuration (used by baseclass renderers in maketitle)
% Default: 1.25cm left/right margins, 2cm top/bottom, 15pt column separation
% Usage: \documentclass[marginleft=3cm,margintop=2.5cm]{zigma}
\DeclareStringOption[1.25cm]{marginleft}
\DeclareStringOption[1.25cm]{marginright}
\DeclareStringOption[2cm]{margintop}
\DeclareStringOption[2cm]{marginbottom}
\DeclareStringOption[15pt]{columnsep}

% Bibliography configuration (processed in preamble before \begin{document})
% Enables bibliography system when bib=true
% bibpreset: select predefined style (ieee, apa, chicago, nature, etc.)
% bibfile: specify .bib file(s) - comma-separated for multiple files
% bibbackend: backend engine (default: biblatex, alternative: bibtex)
% bibstyle: override bibliography style
\DeclareBoolOption[false]{bib}
\DeclareStringOption{bibpreset}
\DeclareStringOption{bibfile}
\DeclareStringOption[biblatex]{bibbackend}
\DeclareStringOption{bibstyle}

% Template selection (loads pre-configured template)
% Available: ilcibernetico, ieee, apa, nature, thesis
\DeclareStringOption{template}

% Process all declared class options
\ProcessKeyvalOptions*

%% ========================================================================
%% Load Template (if specified)
%% ========================================================================

% Templates can override class options for margin and layout settings.
% Template priority: User-specified options > Template defaults > Zigma defaults
% Templates can customize: marginleft, marginright, margintop, marginbottom, columnsep
% Templates can also configure: base= (if not explicitly set), bib= options

\ExplSyntaxOn
\tl_if_empty:NF \zigma@template
  {
    % Load template file
    \file_if_exist:nTF {zigma-class/templates/zigma-template-\zigma@template.code.tex}
      {
        \file_input:n {zigma-class/templates/zigma-template-\zigma@template.code.tex}
        \zigma_log:x { [ZIGMA]~Template~loaded:~\zigma@template }
      }
      {
        \msg_error:nnxxx { zigma } { template-not-found }
          { \zigma@template }
          { ieee-conference,~nature,~thesis-simple }
          { See~zigma-class/templates/README.md }
      }
  }
\ExplSyntaxOff

%% Pass unknown options to the baseclass (e.g., fontsize=12pt, etc.)
%% This allows users to pass baseclass-specific options through Zigma
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\zigma@baseclass}}
\ProcessOptions\relax

%% Load selected base class with twocolumn by default
%% Users can override with base=article (single column), base=memoir, etc.
\LoadClass[twocolumn]{\zigma@baseclass}

%% Additional packages (loaded after base class to avoid conflicts)
\RequirePackage{hyperref}
\RequirePackage{marvosym}
\RequirePackage{academicons}

%% Store the baseclass in expl3 variable
\ExplSyntaxOn

\tl_new:N \g_zigma_baseclass_tl
\tl_gset:Nx \g_zigma_baseclass_tl { \zigma@baseclass }
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
\InputIfFileExists{zigma-class/zigma-core.code.tex}{}
  {\ClassError{zigma}{Missing~zigma-core.code.tex}{}}
\InputIfFileExists{zigma-class/zigma-keys.code.tex}{}
  {\ClassError{zigma}{Missing~zigma-keys.code.tex}{}}
\InputIfFileExists{zigma-class/zigma-authors.code.tex}{}
  {\ClassError{zigma}{Missing~zigma-authors.code.tex}{}}
\InputIfFileExists{zigma-class/zigma-bib.code.tex}{}
  {\ClassError{zigma}{Missing~zigma-bib.code.tex}{}}
\InputIfFileExists{zigma-class/zigma-crossref.code.tex}{}
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
%% Load Base Class Renderer
%% ========================================================================

\ExplSyntaxOn

% Map base class to renderer name
\tl_new:N \l_zigma_renderer_name_tl

% Define renderer error message
\msg_new:nnn { zigma } { renderer-not-found }
  { Renderer~file~not~found:~baseclasses/#1/zigma-render.code.tex }

% Check if user specified explicit base= option
\tl_if_empty:NTF \zigma@base
  {
    % No explicit renderer, map from baseclass
    \str_case:Vn \g_zigma_baseclass_tl
      {
        { article }     { \tl_set:Nn \l_zigma_renderer_name_tl { article } }
        { extarticle }  { \tl_set:Nn \l_zigma_renderer_name_tl { article } }
        { scrartcl }    { \tl_set:Nn \l_zigma_renderer_name_tl { koma } }
        { scrreprt }    { \tl_set:Nn \l_zigma_renderer_name_tl { koma } }
        { scrbook }     { \tl_set:Nn \l_zigma_renderer_name_tl { koma } }
        { memoir }      { \tl_set:Nn \l_zigma_renderer_name_tl { memoir } }
      }
    
    % Default to rho renderer if not mapped
    \tl_if_empty:NT \l_zigma_renderer_name_tl
      {
        \zigma_log:n { [ZIGMA]~Base~class~'\g_zigma_baseclass_tl'~not~mapped,~using~rho~renderer }
        \tl_set:Nn \l_zigma_renderer_name_tl { rho }
      }
  }
  {
    % User specified explicit base= option
    \tl_set:NV \l_zigma_renderer_name_tl \zigma@base
    \zigma_log:x { [ZIGMA]~Using~explicit~renderer:~\l_zigma_renderer_name_tl }
  }

% Load the renderer
\zigma_log:x { [ZIGMA]~Loading~renderer:~\l_zigma_renderer_name_tl }

\exp_args:Nx \file_if_exist:nTF { zigma-class/baseclasses/\l_zigma_renderer_name_tl /zigma-render.code.tex }
  {
    \exp_args:Nx \file_input:n { zigma-class/baseclasses/\l_zigma_renderer_name_tl /zigma-render.code.tex }
  }
  {
    \msg_error:nnx { zigma } { renderer-not-found } { \l_zigma_renderer_name_tl }
  }

\ExplSyntaxOff


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
