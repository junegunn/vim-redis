if exists("g:loaded_vim_redis_plugin")
  finish
endif
let g:loaded_vim_redis_plugin = 1

command! -nargs=* -range RedisExecute <line1>,<line2>call vim_redis#execute(0, <f-args>)
command! -nargs=* -range RedisExecuteVisual <line1>,<line2>call vim_redis#execute(1, <f-args>)
command! -nargs=* RedisQuit call vim_redis#quit()
command! -nargs=* RedisWipe call vim_redis#wipe()
