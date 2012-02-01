" vim: set fdm=marker fdc=2 :

" Setup P4Monitor Bindings:  {{{1
 
if has("python")

function! p4mon#ListChanges(query)
	execute "python lib.handler.display('".a:query."')"
endfunction

function! p4mon#PrintChange()
	execute "python lib.handler.print_change()"
endfunction

endif
