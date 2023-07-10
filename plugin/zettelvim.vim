" vim: set fdm=marker:
" This main file is created to import the 
" whole files and mantain an order.
" Function to insert links from files in a file
"

" Declare variables {{{1
let g:zettelfiletype = get(g:, 'zettelvim_filetype', 'markdown')
let g:zetteldir      = get(g:, 'zettelvim_dir', '~/Zettelkasten')
let g:zetteltag      = get(g:, 'zettelvim_tag_delimiter', '#')

" Detect if python3 is enabled {{{1
if !has('python3')
  echo 'Vim must be compiled with +python3 feature'
  finish
endif

" Detect if plugin has been called properly {{{1

if exists('g:pluginexamplepy_loaded')
  finish
endif

let s:zettelvimpath = fnamemodify(resolve(expand('<sfile>:p')), ':h')
" Start the plugin {{{1

python3 << EOF

# Libraries to import {{{2
import sys
from os.path import normpath, join
import vim

# Load python files {{{2
plugin_root_dir = vim.eval('s:zettelvimpath')
python_root_dir = normpath(join(plugin_root_dir, 'python'))
# print(python_root_dir)
sys.path.insert(0, python_root_dir)


from zettelvim import *
# }}}

EOF
" Zettelvim functions {{{1
" Insert link to a specific file {{{2
function! InsertZettelLink()
  let selected_file = fzf#run({'source': 'find ' . g:zettelvim_dir . ' -type f -maxdepth 1 -printf "%f\n"'})
  if !empty(selected_file)
    let selected_file_str = join(selected_file, "\n")
    execute "normal i[[" . selected_file_str . "]]"
  endif
endfunction

" Insert zettelkasten tag {{{2
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

" Custom functions {{{2
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


" Python commands {{{1
python3 from zettelvim import Loadzettel
python3 Loadzettel()

command! -nargs=+ ZettelCreateFile python3 createzettel(<q-args>,'new')
command! -nargs=+ ZettelCreateFileSplit python3 createzettel(<q-args>,'split')
command! -nargs=+ ZettelCreateFileVSplit python3 createzettel(<q-args>,'vsplit')
command! -nargs=+ ZettelCreateFileTab python3 createzettel(<q-args>,'tab')
command! -nargs=1 FzfRG call FzfRG(<q-args>)
