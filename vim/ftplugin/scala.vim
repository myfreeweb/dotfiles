setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" sbt repl for fast testing!
nnoremap <buffer> <Leader>t :call VimuxSendText("test\r")<CR>
