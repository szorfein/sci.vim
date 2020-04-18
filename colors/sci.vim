" Sci Theme: {{{
"
" https://github.com/szorfein/sci.vim
"
scriptencoding utf8
" }}}

" Configuration: {{{

if v:version > 580
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'sci'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" Palette: {{{2

let s:fg        = g:sci#palette.fg

let s:bglighter = g:sci#palette.bglighter
let s:bglight   = g:sci#palette.bglight
let s:bg        = g:sci#palette.bg
let s:bgdark    = g:sci#palette.bgdark
let s:bgdarker  = g:sci#palette.bgdarker

let s:comment   = g:sci#palette.comment
let s:selection = g:sci#palette.selection
let s:subtle    = g:sci#palette.subtle

let s:cyan      = g:sci#palette.cyan
let s:green     = g:sci#palette.green
let s:orange    = g:sci#palette.orange
let s:pink      = g:sci#palette.pink
let s:purple    = g:sci#palette.purple
let s:red       = g:sci#palette.red
let s:yellow    = g:sci#palette.yellow

let s:none      = ['NONE', 'NONE']

if has('nvim')
  for s:i in range(16)
    let g:terminal_color_{s:i} = g:sci#palette['color_' . s:i]
  endfor
endif

if has('terminal')
  let g:terminal_ansi_colors = []
  for s:i in range(16)
    call add(g:terminal_ansi_colors, g:sci#palette['color_' . s:i])
  endfor
endif

" }}}2
" User Configuration: {{{2

if !exists('g:sci_bold')
  let g:sci_bold = 1
endif

if !exists('g:sci_italic')
  let g:sci_italic = 1
endif

if !exists('g:sci_underline')
  let g:sci_underline = 1
endif

if !exists('g:sci_undercurl') && g:sci_underline != 0
  let g:sci_undercurl = 1
endif

if !exists('g:sci_inverse')
  let g:sci_inverse = 1
endif

if !exists('g:sci_colorterm')
  let g:sci_colorterm = 1
endif

"}}}2
" Script Helpers: {{{2

let s:attrs = {
      \ 'bold': g:sci_bold == 1 ? 'bold' : 0,
      \ 'italic': g:sci_italic == 1 ? 'italic' : 0,
      \ 'underline': g:sci_underline == 1 ? 'underline' : 0,
      \ 'undercurl': g:sci_undercurl == 1 ? 'undercurl' : 0,
      \ 'inverse': g:sci_inverse == 1 ? 'inverse' : 0,
      \}

function! s:h(scope, fg, ...) " bg, attr_list, special
  let l:fg = copy(a:fg)
  let l:bg = get(a:, 1, ['NONE', 'NONE'])

  let l:attr_list = filter(get(a:, 2, ['NONE']), 'type(v:val) == 1')
  let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

  " Falls back to coloring foreground group on terminals because
  " nearly all do not support undercurl
  let l:special = get(a:, 3, ['NONE', 'NONE'])
  if l:special[0] !=# 'NONE' && l:fg[0] ==# 'NONE' && !has('gui_running')
    let l:fg[0] = l:special[0]
    let l:fg[1] = l:special[1]
  endif

  let l:hl_string = [
        \ 'highlight', a:scope,
        \ 'guifg=' . l:fg[0], 'ctermfg=' . l:fg[1],
        \ 'guibg=' . l:bg[0], 'ctermbg=' . l:bg[1],
        \ 'gui=' . l:attrs, 'cterm=' . l:attrs,
        \ 'guisp=' . l:special[0],
        \]

  execute join(l:hl_string, ' ')
endfunction

"}}}2
" Sci Highlight Groups: {{{2

call s:h('SciBgLight', s:none, s:bglight)
call s:h('SciBgLighter', s:none, s:bglighter)
call s:h('SciBgDark', s:none, s:bgdark)
call s:h('SciBgDarker', s:none, s:bgdarker)

call s:h('SciFg', s:fg)
call s:h('SciFgUnderline', s:fg, s:none, [s:attrs.underline])
call s:h('SciFgBold', s:fg, s:none, [s:attrs.bold])

call s:h('SciComment', s:comment)
call s:h('SciCommentBold', s:comment, s:none, [s:attrs.bold])

call s:h('SciSelection', s:none, s:selection)

call s:h('SciSubtle', s:subtle)

call s:h('SciCyan', s:cyan)
call s:h('SciCyanItalic', s:cyan, s:none, [s:attrs.italic])

call s:h('SciGreen', s:green)
call s:h('SciGreenBold', s:green, s:none, [s:attrs.bold])
call s:h('SciGreenItalic', s:green, s:none, [s:attrs.italic])
call s:h('SciGreenItalicUnderline', s:green, s:none, [s:attrs.italic, s:attrs.underline])

call s:h('SciOrange', s:orange)
call s:h('SciOrangeBold', s:orange, s:none, [s:attrs.bold])
call s:h('SciOrangeItalic', s:orange, s:none, [s:attrs.italic])
call s:h('SciOrangeBoldItalic', s:orange, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('SciOrangeInverse', s:bg, s:orange)

call s:h('SciPink', s:pink)
call s:h('SciPinkItalic', s:pink, s:none, [s:attrs.italic])

call s:h('SciPurple', s:purple)
call s:h('SciPurpleBold', s:purple, s:none, [s:attrs.bold])
call s:h('SciPurpleItalic', s:purple, s:none, [s:attrs.italic])

call s:h('SciRed', s:red)
call s:h('SciRedInverse', s:fg, s:red)

call s:h('SciYellow', s:yellow)
call s:h('SciYellowItalic', s:yellow, s:none, [s:attrs.italic])

call s:h('SciError', s:red, s:none, [], s:red)

call s:h('SciErrorLine', s:none, s:none, [s:attrs.undercurl], s:red)
call s:h('SciWarnLine', s:none, s:none, [s:attrs.undercurl], s:orange)
call s:h('SciInfoLine', s:none, s:none, [s:attrs.undercurl], s:cyan)

call s:h('SciTodo', s:cyan, s:none, [s:attrs.bold, s:attrs.inverse])
call s:h('SciSearch', s:green, s:none, [s:attrs.inverse])
call s:h('SciBoundary', s:comment, s:bgdark)
call s:h('SciLink', s:cyan, s:none, [s:attrs.underline])

call s:h('SciDiffChange', s:orange, s:none)
call s:h('SciDiffText', s:bg, s:orange)
call s:h('SciDiffDelete', s:red, s:bgdark)

" }}}2

" }}}
" User Interface: {{{

set background=dark

" Required as some plugins will overwrite
call s:h('Normal', s:fg, g:sci_colorterm || has('gui_running') ? s:bg : s:none )
call s:h('StatusLine', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineNC', s:none, s:bglight)
call s:h('StatusLineTerm', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineTermNC', s:none, s:bglight)
call s:h('WildMenu', s:bg, s:purple, [s:attrs.bold])
call s:h('CursorLine', s:none, s:subtle)

hi! link ColorColumn  SciBgDark
hi! link CursorColumn CursorLine
hi! link CursorLineNr SciYellow
hi! link DiffAdd      SciGreen
hi! link DiffAdded    DiffAdd
hi! link DiffChange   SciDiffChange
hi! link DiffDelete   SciDiffDelete
hi! link DiffRemoved  DiffDelete
hi! link DiffText     SciDiffText
hi! link Directory    SciPurpleBold
hi! link ErrorMsg     SciRedInverse
hi! link FoldColumn   SciSubtle
hi! link Folded       SciBoundary
hi! link IncSearch    SciOrangeInverse
hi! link LineNr       SciComment
hi! link MoreMsg      SciFgBold
hi! link NonText      SciSubtle
hi! link Pmenu        SciBgDark
hi! link PmenuSbar    SciBgDark
hi! link PmenuSel     SciSelection
hi! link PmenuThumb   SciSelection
hi! link Question     SciFgBold
hi! link Search       SciSearch
hi! link SignColumn   SciComment
hi! link TabLine      SciBoundary
hi! link TabLineFill  SciBgDarker
hi! link TabLineSel   Normal
hi! link Title        SciGreenBold
hi! link VertSplit    SciBoundary
hi! link Visual       SciSelection
hi! link VisualNOS    Visual
hi! link WarningMsg   SciOrangeInverse

" }}}
" Syntax: {{{

" Required as some plugins will overwrite
call s:h('MatchParen', s:green, s:none, [s:attrs.underline])
call s:h('Conceal', s:cyan, s:none)

" Neovim uses SpecialKey for escape characters only. Vim uses it for that, plus whitespace.
if has('nvim')
  hi! link SpecialKey SciRed
  hi! link LspDiagnosticsUnderline SciFgUnderline
  hi! link LspDiagnosticsInformation SciCyan
  hi! link LspDiagnosticsHint SciCyan
  hi! link LspDiagnosticsError SciError
  hi! link LspDiagnosticsWarning SciOrange
  hi! link LspDiagnosticsUnderlineError SciErrorLine
  hi! link LspDiagnosticsUnderlineHint SciInfoLine
  hi! link LspDiagnosticsUnderlineInformation SciInfoLine
  hi! link LspDiagnosticsUnderlineWarning SciWarnLine
else
  hi! link SpecialKey SciSubtle
endif

hi! link Comment SciComment
hi! link Underlined SciFgUnderline
hi! link Todo SciTodo

hi! link Error SciError
hi! link SpellBad SciErrorLine
hi! link SpellLocal SciWarnLine
hi! link SpellCap SciInfoLine
hi! link SpellRare SciInfoLine

hi! link Constant SciPurple
hi! link String SciYellow
hi! link Character SciPink
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant

hi! link Identifier SciFg
hi! link Function SciGreen

hi! link Statement SciPink
hi! link Conditional SciPink
hi! link Repeat SciPink
hi! link Label SciPink
hi! link Operator SciPink
hi! link Keyword SciPink
hi! link Exception SciPink

hi! link PreProc SciPink
hi! link Include SciPink
hi! link Define SciPink
hi! link Macro SciPink
hi! link PreCondit SciPink
hi! link StorageClass SciPink
hi! link Structure SciPink
hi! link Typedef SciPink

hi! link Type SciCyanItalic

hi! link Delimiter SciFg

hi! link Special SciPink
hi! link SpecialComment SciCyanItalic
hi! link Tag SciCyan
hi! link helpHyperTextJump SciLink
hi! link helpCommand SciPurple
hi! link helpExample SciGreen
hi! link helpBacktick Special

"}}}

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0 et:
