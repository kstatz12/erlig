-module(log2).
-import(math, [log/1, pow/2]).
-export([log2/1]).

log2(X) ->
    log(X) / log(2).
