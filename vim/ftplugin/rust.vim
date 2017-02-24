setlocal omnifunc=RacerComplete

setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

nnoremap <buffer> <Leader>t :call VimuxSendText("cargo test\n")<CR>
