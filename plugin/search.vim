
command! -bang -nargs=* FindTags
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case -- :'.shellescape(<q-args>)." ".g:zettelvim_dir, 1,
      \   fzf#vim#with_preview(), <bang>0)

