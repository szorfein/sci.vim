" Palette: {{{

let g:sci#palette           = {}
let g:sci#palette.fg        = ['#E3FAFE', 253]

let g:sci#palette.bglighter = ['#213035', 238] 
let g:sci#palette.bglight   = ['#1B272B', 237]
let g:sci#palette.bg        = ['#161D23', 236]
let g:sci#palette.bgdark    = ['#12171C', 235]
let g:sci#palette.bgdarker  = ['#0D1014', 234]

let g:sci#palette.comment   = ['#355CA5',  61]
let g:sci#palette.selection = ['#192F3A', 239]
let g:sci#palette.subtle    = ['#1A2C3F', 238]

let g:sci#palette.orange    = ['#674EF3', 63]

let g:sci#palette.red       = ['#F3674E', 203]
let g:sci#palette.green     = ['#88F8AB', 121]
let g:sci#palette.yellow    = ['#F2D49D', 228]

let g:sci#palette.purple    = ['#4E88F3', 69]
let g:sci#palette.pink      = ['#4EDAF3', 81]
let g:sci#palette.cyan      = ['#4EF3B9', 85]
"
" ANSI
"
let g:sci#palette.color_0  = '#12171C'
let g:sci#palette.color_1  = '#F36743'
let g:sci#palette.color_2  = '#88F8AB'
let g:sci#palette.color_3  = '#F2D49D'
let g:sci#palette.color_4  = '#4E88F3'
let g:sci#palette.color_5  = '#4EDAF3'
let g:sci#palette.color_6  = '#4EF3B9'
let g:sci#palette.color_7  = '#E3FAFE'

let g:sci#palette.color_8  = '#213035'
let g:sci#palette.color_9  = '#F7A58F'
let g:sci#palette.color_10 = '#A9FAAC'
let g:sci#palette.color_11 = '#FAEED7'
let g:sci#palette.color_12 = '#55A7FF'
let g:sci#palette.color_13 = '#83E5F8'
let g:sci#palette.color_14 = '#4EF3EF'
let g:sci#palette.color_15 = '#FFFFFF' 

" }}}

" Helper function that takes a variadic list of filetypes as args and returns
" whether or not the execution of the ftplugin should be aborted.
func! sci#should_abort(...)
    if ! exists('g:colors_name') || g:colors_name !=# 'sci'
        return 1
    elseif a:0 > 0 && (! exists('b:current_syntax') || index(a:000, b:current_syntax) == -1)
        return 1
    endif
    return 0
endfunction

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0:
