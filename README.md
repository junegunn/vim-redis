vim-redis (WIP)
===============

(Experimental) Redis plugin for Vim.

- Highlight Redis commands in `.redis` files
- Execute Redis commands from Vim

```vim
  " let g:vim_redis_host = 'localhost'
  " let g:vim_redis_port = '6379'
  " let g:vim_redis_auth = 'xxx'

  let g:vim_redis_paste_command = 1

  " Execute current line
  noremap <slient> <leader>re :RedisExecute<cr>

  " Execute multiple lines at once while in visual mode
  vnoremap <slient> <leader>re :RedisExecute<cr>gv

  " Close output window
  noremap <slient> <leader>rq :RedisClose<cr>
```
