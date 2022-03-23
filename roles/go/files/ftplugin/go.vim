function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction

nmap <leader>tf   <Plug>(go-test-func)
nmap <leader>tp   <Plug>(go-test)
nmap <leader>u    :<C-u>call <SID>build_go_files()<CR>
nmap <leader>x    <Plug>(go-coverage-toggle)
nmap <leader>a    <Plug>(go-alternate-vertical)
nmap <leader>i    <Plug>(go-info)
nmap <leader>ff   <Plug>(go-decls)
nmap <leader>fp   <Plug>(go-decls-dir)
nmap <leader>?    <Plug>(go-doc)
nmap <leader>n    <Plug>(go-metalinter)
nmap <leader>r    <Plug>(go-run)
nmap <S-F6>       <Plug>(go-rename)
nmap <leader><F6> <Plug>(go-rename)
