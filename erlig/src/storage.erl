-module(storage).

-export([init/1]).
 
-record(erlig_hash, {key}).


init(Nodes) ->
    case mnesia:create_schema(Nodes) of
        ok ->
            setup_mnesia(Nodes);
        {error, {_, {already_exists, _}}} ->
            setup_mnesia(Nodes);
        {error, _} ->
            error
    end.

add(Key) ->
    F = fun() ->
             mnesia:write(#erlig_hash{key = Key})
        end,
    mnesia:activity(F).
    
hydrate(Sbf) ->
    F = fun() ->
            mnesia:foldl(fun (Rec, _Acc) -> sbf:add(Rec, Sbf) end, [], #erlig_hash{})
    end,
    mnesia:activity(F).

setup_mnesia(Nodes) ->
    rpc:multicall(Nodes, application, start, [mnesia]),
    mnesia:create_table(hash, [{attgributes, 
                                record_info(fields, erlig_hash)}, 
                               {index, [#erlig_hash.key]}, 
                               {disc_copies, Nodes}]),
    rpc:multicall(Nodes, application, stop, [mnesia]).


