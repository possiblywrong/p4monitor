" vim: set fdm=marker fdc=2:

" File:			p4mon.vim
" Description:	Perforce History Browser
" Author:		Declan Conlon (dconlon(at)riverbed.com)
" Version:		0.1

	" Must we load? {{{1
	if (exists("g:p4mon_loaded") && g:p4mon_loaded)
		|| &cp 
		|| has("python") == 0
		finish
	endif
	let g:p4mon_loaded = 1 "}}}

"" Default Settings: {{{1
""
if !exists('g:p4mon_window_height')
	let g:p4mon_window_height = 30
endif
if !exists('g:p4mon_num_changes')
	let g:p4mon_num_changes = 50
endif

" Base: {{{1
   python<<EOF
import vim, sys
sys.path.append(vim.eval("expand('<sfile>:p:h')"))
import lib
EOF

"" Commands: {{{1
command! PrintChange call p4mon#PrintChange()
command! -nargs=? ListChanges call p4mon#ListChanges('<args>')

"" Key Mappings: {{{1
""
noremap <silent> <unique> <Plug>ListChanges <esc>:ListChanges<CR>

function s:CreateMapping(key, action, modename)
  let mode = a:modename == "normal" ? "nmap" : "imap"

  try
    execute mode . " <unique> " . a:key . " <Plug>" . a:action
  catch /E227/
    echom "[vim-pad] " . a:key . " in " . a:modename . " mode is already mapped."
  endtry
endfunction

call s:CreateMapping("<leader>p", "ListChanges", "normal")
