setlocal fileencoding=utf-8
setlocal cursorline
setlocal buftype=nofile
setlocal noswapfile
setlocal nowrap
setlocal nomodified
setlocal conceallevel=2
setlocal concealcursor=ncvi
setlocal nocp
noremap <buffer> <silent> <enter> :call p4mon#PrintChange()<cr>
noremap <buffer> <silent> <leader>p :bw<cr>
