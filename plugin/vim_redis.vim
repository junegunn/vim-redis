if exists("g:vim_redis_plugin_loaded")
  finish
endif
let g:vim_redis_plugin_loaded = 1

command! -nargs=* -range RedisExecute <line1>,<line2>call vim_redis#execute(<f-args>)
command! -nargs=* RedisQuit call vim_redis#quit()
