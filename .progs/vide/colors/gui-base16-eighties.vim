" vi:syntax=vim

" base16-vim (https://github.com/chriskempson/base16-vim)
" by Chris Kempson (http://chriskempson.com)
" Eighties scheme by Chris Kempson (http://chriskempson.com)

" This enables the coresponding base16-shell script to run so that
" :colorscheme works in terminals supported by base16-shell scripts
" User must set this variable in .vimrc
"   let g:shell_path=base16-builder/output/shell/

" GUI color definitions {{{1
let g:hi00 = '#2d2d2d'
let g:hi01 = '#393939'
let g:hi02 = '#515151'
let g:hi03 = '#747369'
let g:hi04 = '#a09f93'
let g:hi05 = '#d3d0c8'
let g:hi06 = '#e8e6df'
let g:hi07 = '#f2f0ec'
let g:hi08 = '#f2777a'
let g:hi09 = '#f99157'
let g:hi0A = '#ffcc66'
let g:hi0B = '#99cc99'
let g:hi0C = '#66cccc'
let g:hi0D = '#6699cc'
let g:hi0E = '#cc99cc'
let g:hi0F = '#d27b53'

" Theme setup {{{1
hi clear
syntax reset
let g:colors_name = "gui-base16-eighties"

fun! Hi(group, ...)
  let l:guifg = get(a:000,0,'none')
  let l:guibg = get(a:000,1,'none')
  let l:gui   = get(a:000,2,'none')
  let l:guisp = get(a:000,3,'none')

  exe 'hi '.a:group.
  \' guifg='.(l:guifg==''?'none':l:guifg).
  \' guibg='.(l:guibg==''?'none':l:guibg).
  \' gui='.(l:gui==''?'none':l:gui).
  \' guisp='.(l:guisp==''?'none':l:guisp)
endfun

" Vim editor colors {{{1
cal Hi('Normal',                   g:hi05, g:hi00, '',          '')
cal Hi('Bold',                     '',     '',     'bold',      '')
cal Hi('Debug',                    g:hi08, '',     '',          '')
cal Hi('Directory',                g:hi0D, '',     '',          '')
cal Hi('Error',                    g:hi00, g:hi08, '',          '')
cal Hi('ErrorMsg',                 g:hi08, g:hi00, '',          '')
cal Hi('Exception',                g:hi08, '',     '',          '')
cal Hi('FoldColumn',               g:hi0C, g:hi01, '',          '')
cal Hi('Folded',                   g:hi03, g:hi01, '',          '')
cal Hi('IncSearch',                g:hi01, g:hi09, 'none',      '')
cal Hi('Italic',                   '',     '',     'none',      '')
cal Hi('Macro',                    g:hi08, '',     '',          '')
cal Hi('MatchParen',               '',     '',     'underline', '')
cal Hi('ModeMsg',                  g:hi0B, '',     '',          '')
cal Hi('MoreMsg',                  g:hi0B, '',     '',          '')
cal Hi('Question',                 g:hi0D, '',     '',          '')
cal Hi('Search',                   g:hi01, g:hi0A, '',          '')
cal Hi('Substitute',               g:hi01, g:hi0A, 'none',      '')
cal Hi('SpecialKey',               g:hi03, '',     '',          '')
cal Hi('TooLong',                  g:hi08, '',     '',          '')
cal Hi('Underlined',               g:hi08, '',     '',          '')
cal Hi('Visual',                   '',     g:hi02, '',          '')
cal Hi('VisualNOS',                g:hi08, '',     '',          '')
cal Hi('WarningMsg',               g:hi08, '',     '',          '')
cal Hi('WildMenu',                 g:hi08, g:hi0A, '',          '')
cal Hi('Title',                    g:hi0D, '',     'none',      '')
cal Hi('Conceal',                  g:hi0D, g:hi00, '',          '')
cal Hi('Cursor',                   g:hi00, g:hi05, '',          '')
cal Hi('NonText',                  g:hi03, '',     'none',      '')
cal Hi('LineNr',                   g:hi03, g:hi01, '',          '')
cal Hi('SignColumn',               g:hi03, g:hi01, '',          '')
cal Hi('StatusLine',               g:hi0B, g:hi01, 'none',      'none')
cal Hi('StatusLineNC',               g:hi0B, g:hi01, 'none',      'none')
cal Hi('StatusLineS0',             g:hi09, g:hi01, '',          '')
cal Hi('StatusLineS1',             g:hi0E, g:hi01, '',          '')
cal Hi('StatusLineS2',             g:hi03, g:hi01, 'none',      '')
cal Hi('VertSplit',                g:hi02, g:hi02, 'none',      '')
cal Hi('ColorColumn',              '',     g:hi01, 'none',      '')
cal Hi('CursorColumn',             '',     g:hi01, 'none',      '')
cal Hi('CursorLine',               '',     g:hi01, 'none',      '')
cal Hi('CursorLineNr',             g:hi04, g:hi01, '',          '')
cal Hi('QuickFixLine',             '',     g:hi01, 'none',      '')
cal Hi('PMenu',                    g:hi05, g:hi01, 'none',      '')
cal Hi('PMenuSel',                 g:hi01, g:hi05, '',          '')
cal Hi('TabLine',                  g:hi03, g:hi01, 'none',      'none')
cal Hi('TabLineFill',              g:hi03, g:hi01, 'none',      'none')
cal Hi('TabLineSel',               g:hi0B, g:hi01, 'none',      '')
cal Hi('NormalFloat',              'none', 'none', 'none',      '')

" Standard syntax highlighting {{{1
cal Hi('Boolean',                  g:hi09, '',     '',          '')
cal Hi('Character',                g:hi08, '',     '',          '')
cal Hi('Comment',                  g:hi03, '',     '',          '')
cal Hi('Conditional',              g:hi0E, '',     '',          '')
cal Hi('Constant',                 g:hi09, '',     '',          '')
cal Hi('Define',                   g:hi0E, '',     'none',      '')
cal Hi('Delimiter',                g:hi0F, '',     '',          '')
cal Hi('Float',                    g:hi09, '',     '',          '')
cal Hi('Function',                 g:hi0D, '',     '',          '')
cal Hi('Identifier',               g:hi08, '',     'none',      '')
cal Hi('Include',                  g:hi0D, '',     '',          '')
cal Hi('Keyword',                  g:hi0E, '',     '',          '')
cal Hi('Label',                    g:hi0A, '',     '',          '')
cal Hi('Number',                   g:hi09, '',     '',          '')
cal Hi('Operator',                 g:hi05, '',     'none',      '')
cal Hi('PreProc',                  g:hi0A, '',     '',          '')
cal Hi('Repeat',                   g:hi0A, '',     '',          '')
cal Hi('Special',                  g:hi0C, '',     '',          '')
cal Hi('SpecialChar',              g:hi0F, '',     '',          '')
cal Hi('Statement',                g:hi08, '',     '',          '')
cal Hi('StorageClass',             g:hi0A, '',     '',          '')
cal Hi('String',                   g:hi0B, '',     '',          '')
cal Hi('Structure',                g:hi0E, '',     '',          '')
cal Hi('Tag',                      g:hi0A, '',     '',          '')
cal Hi('Todo',                     g:hi0A, g:hi01, '',          '')
cal Hi('Type',                     g:hi0A, '',     'none',      '')
cal Hi('Typedef',                  g:hi0A, '',     '',          '')

" Diff highlighting {{{1
cal Hi('DiffAdd',                  g:hi0B, g:hi01, '',          '')
cal Hi('DiffChange',               g:hi03, g:hi01, '',          '')
cal Hi('DiffDelete',               g:hi08, g:hi01, '',          '')
cal Hi('DiffText',                 g:hi0D, g:hi01, '',          '')
cal Hi('DiffAdded',                g:hi0B, g:hi00, '',          '')
cal Hi('DiffFile',                 g:hi08, g:hi00, '',          '')
cal Hi('DiffNewFile',              g:hi0B, g:hi00, '',          '')
cal Hi('DiffLine',                 g:hi0D, g:hi00, '',          '')
cal Hi('DiffRemoved',              g:hi08, g:hi00, '',          '')

" Git highlighting {{{1
cal Hi('gitcommitOverflow',        g:hi08, '',     '',          '')
cal Hi('gitcommitSummary',         g:hi0B, '',     '',          '')
cal Hi('gitcommitComment',         g:hi03, '',     '',          '')
cal Hi('gitcommitUntracked',       g:hi03, '',     '',          '')
cal Hi('gitcommitDiscarded',       g:hi03, '',     '',          '')
cal Hi('gitcommitSelected',        g:hi03, '',     '',          '')
cal Hi('gitcommitHeader',          g:hi0E, '',     '',          '')
cal Hi('gitcommitSelectedType',    g:hi0D, '',     '',          '')
cal Hi('gitcommitUnmergedType',    g:hi0D, '',     '',          '')
cal Hi('gitcommitDiscardedType',   g:hi0D, '',     '',          '')
cal Hi('gitcommitBranch',          g:hi09, '',     'bold',      '')
cal Hi('gitcommitUntrackedFile',   g:hi0A, '',     '',          '')
cal Hi('gitcommitUnmergedFile',    g:hi08, '',     'bold',      '')
cal Hi('gitcommitDiscardedFile',   g:hi08, '',     'bold',      '')
cal Hi('gitcommitSelectedFile',    g:hi0B, '',     'bold',      '')

" GitGutter highlighting {{{1
cal Hi('GitGutterAdd',             g:hi0B, g:hi01, '',          '')
cal Hi('GitGutterChange',          g:hi0D, g:hi01, '',          '')
cal Hi('GitGutterDelete',          g:hi08, g:hi01, '',          '')
cal Hi('GitGutterChangeDelete',    g:hi0E, g:hi01, '',          '')

" HTML highlighting {{{1
cal Hi('htmlBold',                 g:hi0A, '',     '',          '')
cal Hi('htmlItalic',               g:hi0E, '',     '',          '')
cal Hi('htmlEndTag',               g:hi05, '',     '',          '')
cal Hi('htmlTag',                  g:hi05, '',     '',          '')

" JavaScript highlighting {{{1
cal Hi('javaScript',               g:hi05, '',     '',          '')
cal Hi('javaScriptBraces',         g:hi05, '',     '',          '')
cal Hi('javaScriptNumber',         g:hi09, '',     '',          '')

" pangloss/vim-javascript highlighting {{{1
cal Hi('jsOperator',               g:hi0D, '',     '',          '')
cal Hi('jsStatement',              g:hi0E, '',     '',          '')
cal Hi('jsReturn',                 g:hi0E, '',     '',          '')
cal Hi('jsThis',                   g:hi08, '',     '',          '')
cal Hi('jsClassDefinition',        g:hi0A, '',     '',          '')
cal Hi('jsFunction',               g:hi0E, '',     '',          '')
cal Hi('jsFuncName',               g:hi0D, '',     '',          '')
cal Hi('jsFuncCall',               g:hi0D, '',     '',          '')
cal Hi('jsClassFuncName',          g:hi0D, '',     '',          '')
cal Hi('jsClassMethodType',        g:hi0E, '',     '',          '')
cal Hi('jsRegexpString',           g:hi0C, '',     '',          '')
cal Hi('jsGlobalObjects',          g:hi0A, '',     '',          '')
cal Hi('jsGlobalNodeObjects',      g:hi0A, '',     '',          '')
cal Hi('jsExceptions',             g:hi0A, '',     '',          '')
cal Hi('jsBuiltins',               g:hi0A, '',     '',          '')

" Markdown highlighting {{{1
cal Hi('markdownCode',             g:hi0B, '',     '',          '')
cal Hi('markdownError',            g:hi05, g:hi00, '',          '')
cal Hi('markdownCodeBlock',        g:hi0B, '',     '',          '')
cal Hi('markdownHeadingDelimiter', g:hi0D, '',     '',          '')

" NERDTree highlighting {{{1
cal Hi('NERDTreeDirSlash',         g:hi0D, '',     '',          '')
cal Hi('NERDTreeExecFile',         g:hi05, '',     '',          '')

" PHP highlighting {{{1
cal Hi('phpMemberSelector',        g:hi05, '',     '',          '')
cal Hi('phpComparison',            g:hi05, '',     '',          '')
cal Hi('phpParent',                g:hi05, '',     '',          '')
cal Hi('phpMethodsVar',            g:hi0C, '',     '',          '')

" SASS highlighting {{{1
cal Hi('sassidChar',               g:hi08, '',     '',          '')
cal Hi('sassClassChar',            g:hi09, '',     '',          '')
cal Hi('sassInclude',              g:hi0E, '',     '',          '')
cal Hi('sassMixing',               g:hi0E, '',     '',          '')
cal Hi('sassMixinName',            g:hi0D, '',     '',          '')

" Spelling highlighting {{{1
cal Hi('SpellBad',                 '',     '',     'undercurl', g:hi08)
cal Hi('SpellLocal',               '',     '',     'undercurl', g:hi0C)
cal Hi('SpellCap',                 '',     '',     'undercurl', g:hi0D)
cal Hi('SpellRare',                '',     '',     'undercurl', g:hi0E)
