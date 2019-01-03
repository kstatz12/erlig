-module(id).

-export([gen/1]).

gen(Map) ->
    Comp = maps:fold(fun (_Key, Value, Acc) ->
                             Acc ++ lists:flatten(io_lib:format("~p", [Value])) 
                     end, "", Map),
    hash(Comp).

hash(Val) ->
    crypto:start(),
    <<X:256/big-unsigned-integer>> = crypto:hash(sha256, Val),
    lists:flatten(io_lib:format("~64.16.0b", [X])).
