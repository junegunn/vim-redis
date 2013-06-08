if exists("g:loaded_vim_redis")
  finish
endif
let g:loaded_vim_redis = 1

let s:result_win = 0

function! vim_redis#quit()
  if bufexists("[vim-redis]")
    execute s:result_win . "wincmd w"
    execute ":q"
  endif
endfunction

function! vim_redis#open()
  if !bufexists("[vim-redis]")
    if get(g:, 'vim_redis_output_position', 'r') == 'r'
      vertical rightbelow new
    else
      botright new
    end
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap nonu
    setf redis
    silent! f \[vim-redis\]
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

function! vim_redis#execute(vis, ...) range
  let temp = tempname()
  let command = '!grep -v "^$" ' .temp. ' | FAKETTY=1 redis-cli'

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

  let auth = exists('a:3') ? a:3 : get(g:, 'vim_redis_auth', '')
  if !empty(auth)
    silent! echo 'auth ' . auth
    let command = command . " | tail -n+2"
  endif

  let win = winnr()
  if a:vis
    let prev_a = getreg('a')
    silent! normal! gv"ay
    let lines = split(getreg('a'), '\n')
    call setreg('a', prev_a)
  else
    let lines = []
    for line in range(a:firstline, a:lastline)
      call add(lines, getline(line))
    endfor
  endif

  silent! execute 'redir! > '.temp
  for line in lines
    let cmd = substitute(line, '^\s*redis.\{-}>\s*', '', '')
    if cmd !~ '^OK' && cmd =~ '^\s*[a-zA-Z]'
      silent! echo cmd
    endif
  endfor
  silent! redir END

  call vim_redis#open()
  execute s:result_win . "wincmd w"
  setlocal modifiable

  if get(g:, 'vim_redis_paste_command', 0)
    let line = line('$')
    normal! G
    let paste_cmd = line - 1."read !grep -v '^$' ".temp
    if exists("g:vim_redis_paste_command_prefix")
      let paste_cmd = paste_cmd . " | sed 's|^|".g:vim_redis_paste_command_prefix."|'"
      if !empty(auth)
        let paste_cmd = paste_cmd . " | tail -n+2"
      endif
    endif
    silent! execute paste_cmd

    syntax clear redisHighlight
    " contains=ALLBUT,redisErrorMessage
    execute 'syntax region redisHighlight start=/\%' . line . 'l/ end=/\%' . line('$') . 'l/'
  endif
  let line = line('$') - 1
  silent! execute line."read ".command

  normal G
  setlocal nomodifiable
  execute win . "wincmd w"
endfunction
