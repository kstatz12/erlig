-module(id).

-export([get_id/1]).

-spec get_timestamp() -> integer().

get_id(stamp) ->
    Stamp = get_timestamp(),
    {ok, hash(Stamp)};
get_id(uuid) ->
    UUID = uuid:get_v4_urandom(),
    {ok, hash(UUID)};
get_id(KeyParts = #{}) ->
    case gen(KeyParts) of
        {badmap, _} -> {error, badmap};
        Val -> {ok, Val}
    end.


gen(Map) ->
    Comp = maps:fold(fun (_Key, Value, Acc) ->
                             Acc ++ lists:flatten(io_lib:format("~p", [Value])) 
                     end, "", Map),
    hash(Comp).

hash(Val) ->
    <<X:256/big-unsigned-integer>> = crypto:hash(sha256, Val),
    lists:flatten(io_lib:format("~64.16.0b", [X])).

get_timestamp() ->
    {Mega, Sec, Micro} = os:timestamp(),
    Val = (Mega*1000000 + Sec)*1000 + round(Micro/1000),
    lists:flatten(io_lib:format("~p", [Val])).
    
