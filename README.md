vim-redis (WIP)
===============

(Experimental) Redis plugin for Vim.

- Highlighting redis commands in `.redis` files
- Execute redis commands in Vim

```vim
  " let g:vim_redis_host = 'localhost'
  " let g:vim_redis_port = '6379'
  " let g:vim_redis_auth = 'xxx'

  " Execute current line
  noremap <slient> <leader>rr :RedisExecute<cr>

  " Execute multiple lines at once while in visual mode
  vnoremap <slient> <leader>rr :RedisExecute<cr>gv

  " Close output window
  noremap <slient> <leader>rq :RedisClose<cr>
```
