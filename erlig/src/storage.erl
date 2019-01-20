-module(storage).

-export([init/1]).
-export([add/1, hydrate/1]).
-export([setup_mnesia/1, stop_mnesia/1]).
-include("storage.hrl").


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
    mnesia:activity(transaction, F).
    
hydrate(Sbf) ->
    F = fun() ->
            mnesia:foldl(fun (Rec, _Acc) -> sbf:add(Rec, Sbf) end, [], #erlig_hash{})
    end,
    mnesia:activity(transactio, F).

setup_mnesia(Nodes) ->
    rpc:multicall(Nodes, application, start, [mnesia]),
    mnesia:create_table(erlig_hash, [{attgributes, 
                                record_info(fields, erlig_hash)}, 
                               {index, [#erlig_hash.key]}, 
                               {disc_copies, Nodes}]).

stop_mnesia(Nodes) ->
    rpc:multicall(Nodes, application, stop, [mnesia]).

