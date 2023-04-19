function! ZettelDeleteEmptyBuffers()
    let [i, n; empty] = [1, bufnr('$')]
    while i <= n
        if bufexists(i) && bufname(i) == ''
            call add(empty, i)
        endif
        let i += 1
    endwhile
    if len(empty) > 0
        exe 'bdelete' join(empty)
    endif
endfunction


fun! ZettelSaveas(nombre)
  let nameprev=expand('%')
  let g:zettel_prevdir=getcwd()
  let filedir=expand('%:h')
  let nombre=split(a:nombre, ' ')
  execute 'w ' . filedir . '/' . nombre[0]
  execute 'bd ' . nameprev
  execute '!rm ' . nameprev
  execute 'e ' . filedir . '/' . nombre[0]
  call ZettelDeleteEmptyBuffers()
endf

command! -nargs=+ ZettelChangeName call ZettelSaveas(<q-args>)
