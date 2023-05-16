" This main file is created to import the 
" whole files and mantain an order.
" Function to insert links from files in a file
"
function! InsertZettelLink()
  let selected_file = fzf#run({'source': 'find ' . g:zettelvim_dir . ' -type f -maxdepth 1 -printf "%f\n"'})
  if !empty(selected_file)
    let selected_file_str = join(selected_file, "\n")
    execute "normal i[[" . selected_file_str . "]]"
  endif
endfunction

function! InsertZettelLinktag(args)
  let joined=join(args)
  echo joined
  let selected_file = fzf#run({'source': 'rg ' . g:zettelvim_dir . '--column '})
" -l -N \-H \-\-only-matching \| cut -z -d/ -f3- \| cut -z -d\/ -f2- \| sed "s\|Abuwiki\/Orgtests\/\|\|"
  if !empty(selected_file)
    let selected_file_str = join(selected_file, "\n")
    execute "normal i[[" . selected_file_str . "]]"
  endif
endfunction

function! SearchTesis()
  let command = "rg :tesis Abuwiki/Orgtests --column -l -N -H --only-matching | cut -z -d/ -f3- | cut -z -d/ -f2- | sed 's|Abuwiki/Orgtests/||'"
  let search = systemlist(command)
  call fzf#run({
        \ 'source': search,
        \ 'sink': 'e',
        \ })
endfunction


function! FzfRG(search)
    let command = "rg " . a:search . " Abuwiki/Orgtests --column -l -N -H --only-matching | cut -z -d/ -f3- | cut -z -d/ -f2- | sed 's|Abuwiki/Orgtests/||'"
    let files = system(command)
    call fzf#vim#with_preview({'source': files, 'sink': 'e', 'options': '--ansi'})
endfunction

command! -nargs=1 FzfRG call FzfRG(<q-args>)
