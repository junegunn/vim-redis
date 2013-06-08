vim-redis
=========

Redis plugin for Vim. (Why?)

- Highlights Redis commands in `.redis` files
- Allows you to execute Redis commands within Vim

```vim
"" Redis connection information
" let g:vim_redis_host = 'localhost'
" let g:vim_redis_port = '6379'
" let g:vim_redis_auth = 'xxx'

"" Output window on bottom (default: right)
" let g:vim_redis_output_position = 'b'

"" Paste command on output window
let g:vim_redis_paste_command = 1
let g:vim_redis_paste_command_prefix = '> '

" Execute Redis command on the current line
noremap <slient> <leader>re :RedisExecute<cr>

" Execute commands on multiple lines at once while in visual mode
vnoremap <slient> <leader>re :RedisExecuteVisual<cr>gv

" Clear output window
noremap <slient> <leader>rw :RedisWipe<cr>

" Close output window
noremap <slient> <leader>rq :RedisQuit<cr>

"" Mappings with connection info (host, port, auth)
" noremap  <slient> <leader>re :RedisExecute localhost 6379 xxx<cr>
" vnoremap <slient> <leader>re :RedisExecute localhost 6379 xxx<cr>gv
```
