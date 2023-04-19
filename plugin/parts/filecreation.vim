
command! -nargs=+ ZettelCreateFile call ZettelWithName(<q-args>)

function! ZettelWithName(args)
  let argums = split(a:args, ' ')
  echo argums
  let date = strftime("%Y%m%d%H%M")
  let filename = a:args
  if len(argums)==1
    execute 'edit ' . g:zettelvim_dir . '/' . date . '-' . argums[0] . '.' . g:zettelvim_filetype
  elseif len(argums)==2
    execute 'edit ' . g:zettelvim_dir . '/' . argums[1] . '.' . argums[0]
  else
    echo 'error'
  endif
endfunction



command! ZettelTimestamped call CreateTimestampedFile()

function! CreateTimestampedFile()
  let date = strftime("%Y%m%d%H%M")
  let extension = g:zettelvim_filetype
  execute 'edit ' . g:zettelvim_dir . '/' .  date . '.' . extension
endfunction

