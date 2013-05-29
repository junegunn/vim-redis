if exists("g:vim_redis_loaded")
  finish
endif
let g:vim_redis_loaded = 1

let s:result_win = 0

function! vim_redis#quit()
  if bufexists("[vim-redis]")
    execute s:result_win . "wincmd w"
    execute ":q"
  endif
endfunction

function! vim_redis#open()
  if !bufexists("[vim-redis]")
    if exists("g:vim_redis_output_position") && g:vim_redis_output_position == 'b'
      botright new
    else
      vertical rightbelow new
    end
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap nonu
    setf redis
    silent f \[vim-redis\]
    let s:result_win = winnr()
  endif
endfunction

function! vim_redis#wipe()
  if bufexists("[vim-redis]")
    let win = winnr()
    call vim_redis#quit()
    call vim_redis#open()
    execute win . "wincmd w"
  endif
endfunction

function! vim_redis#execute(...) range
  let temp = tempname()
  let command = '!cat '. temp .' | grep -v "^$" | FAKETTY=1 redis-cli'

  if exists('a:1')
    let command = command . ' -h ' . a:1
  elseif exists('g:vim_redis_host')
    let command = command . ' -h ' . g:vim_redis_host
  endif

  if exists('a:2')
    let command = command . ' -p ' . a:2
  elseif exists('g:vim_redis_port')
    let command = command . ' -p ' . g:vim_redis_port
  endif

  execute "silent redir! > ".temp
  let auth = exists('a:3') ? a:3 : (exists('g:vim_redis_auth') ? g:vim_redis_auth : '')
  if !empty(auth)
    silent echo 'auth ' . auth
    let command = command . " | tail -n+2"
  endif

  let win = winnr()
  for line in range(a:firstline, a:lastline)
    let cmd = substitute(getline(line), '^\s*redis.\{-}>\s*', '', '')
    if cmd !~ '^OK' && cmd =~ '^\s*[a-zA-Z]'
      silent echo cmd
    endif
  endfor
  silent redir END

  call vim_redis#open()
  execute s:result_win . "wincmd w"
  setlocal modifiable

  if exists("g:vim_redis_paste_command") && g:vim_redis_paste_command
    let line = line('$')
    let paste_cmd = "silent ".line - 1."read !cat ".temp." | grep -v '^$'"
    if exists("g:vim_redis_paste_command_prefix")
      let paste_cmd = paste_cmd . " | sed 's|^|".g:vim_redis_paste_command_prefix."|'"
    endif
    execute paste_cmd

    syntax clear redisHighlight
    " contains=ALLBUT,redisErrorMessage
    execute 'syntax region redisHighlight start=/\%' . line . 'l/ end=/\%' . line('$') . 'l/'
  endif
  let line = line('$') - 1
  execute "silent ".line."read ".command

  normal G
  setlocal nomodifiable
  execute win . "wincmd w"
endfunction
