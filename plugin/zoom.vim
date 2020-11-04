if exists('g:loaded_zoom') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=0 Zoom lua require'zoom'.zoom()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_zoom = 1
