" Redis syntax file
" Language:    Redis
" Maintainer:  Junegunn Choi
" Version:     0
" Last Change: 2013 May

if exists('b:current_syntax') && b:current_syntax == 'redis'
  finish
endif

syn include @LUA syntax/lua.vim

syn case ignore
syn match redisStringCommand      /\<\%(append\|bitcount\|bitop\|decr\|decrby\|get\|getbit\|getrange\|getset\|incr\|incrby\|incrbyfloat\|mget\|mset\|msetnx\|psetex\|set\|setbit\|setex\|setnx\|setrange\|strlen\)\>/
syn match redisHashCommand        /\<\%(hdel\|hexists\|hget\|hgetall\|hincrby\|hincrbyfloat\|hkeys\|hlen\|hmget\|hmset\|hset\|hsetnx\|hvals\)\>/
syn match redisListCommand        /\<\%(blpop\|brpop\|brpoplpush\|lindex\|linsert\|llen\|lpop\|lpush\|lpushx\|lrange\|lrem\|lset\|ltrim\|rpop\|rpoplpush\|rpush\|rpushx\)\>/
syn match redisSetCommand         /\<\%(sadd\|scard\|sdiff\|sdiffstore\|sinter\|sinterstore\|sismember\|sunion\|sunionstore\|spop\|smembers\|srandmember\|smove\|srem\)\>/
syn match redisSortedSetCommand   /\<\%(zadd\|zcard\|zcount\|zincrby\|zinterstore\|zrange\|zrangebyscore\|zrank\|zrem\|zremrangebyrank\|zremrangebyscore\|zrevrange\|zrevrangebyscore\|zrevrank\|zscore\|zunionstore\)\>/
syn match redisPubSubCommand      /\<\%(publish\|subscribe\|unsubscribe\|psubscribe\|punsubscribe\)\>/
syn match redisTransactionCommand /\<\%(discard\|exec\|multi\|unwatch\|watch\)\>/
syn match redisScriptingCommand   /\<\%(eval\|evalsha\|script \+exists\|script \+flush\|script \+kill\|script \+load\)\>/
syn match redisConnectionCommand  /\<\%(auth\|ping\|echo\|quit\|select\)\>/
syn match redisServerCommand      /\<\%(bgrewriteaof\|bgsave\|client \+kill\|client \+list\|client \+getname\|client \+setname\|config \+get\|config \+set\|config \+resetstat\|dbsize\|debug \+object\|debug \+segfault\|flushall\|flushdb\|info\|lastsave\|shutdown\|slaveof\|slowlog\|sync\|time\|monitor\|save\)\>/
syn match redisKeyCommand         /\<\%(del\|dump\|exists\|expire\|expireat\|keys\|migrate\|move\|object\|persist\|pexpire\|pexpireat\|pttl\|randomkey\|rename\|renamenx\|restore\|sort\|ttl\|type\)\>/
syn match redisKeyword /\<\%(withscores\|weights\|ok\|aggregate \+\%(min\|sum\|max\)\|save\|no \+save\|\)\>/

syn match redisPrompt /^redis.\{-}>/
syn match redisResponseType /^\s*([^)]\{-})/
syn match redisResponseType /([^)]\{-})/ contained
syn match redisNumber /\<-\?[0-9.]\+\>/

syn region redisString start='"' skip='\\"' end='"' oneline contains=redisScript
syn region redisString start="'" skip="\\'" end="'" oneline contains=redisScript
syn region redisScript matchGroup=redisLuaScript start=/\<\%(eval\|script \+exists\|script \+load\)\s\s\{-}"/ end='"' oneline contains=@LUA
syn region redisResponseNumbered start='^[0-9]\+)' end='$' contains=redisString,redisResponseType,redisNumber

syn region redisError matchGroup=redisResponseError start='(error)\s*' end='$' contains=redisErrorMessage display
syn match redisErrorMessage /.*/ contained

" hell yeah
hi def link redisKeyword            Keyword
hi def link redisPrompt             Comment
hi def link redisResponseType       Type
hi def link redisResponseError      Todo
hi def link redisErrorMessage       Error
hi def link redisNumber             Number
hi def link redisString             String
hi def link redisStringCommand      Function
hi def link redisListCommand        Type
hi def link redisSetCommand         Tag
hi def link redisHashCommand        Identifier
hi def link redisSortedSetCommand   Character
hi def link redisPubSubCommand      Define
hi def link redisTransactionCommand Conditional
hi def link redisScriptingCommand   PreProc
hi def link redisLuaScript          PreProc
hi def link redisConnectionCommand  Exception
hi def link redisServerCommand      Debug
hi def link redisKeyCommand         Statement
hi def link redisHighlight          Todo

let b:current_syntax = 'redis'
