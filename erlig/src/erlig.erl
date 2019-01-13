-module(erlig).
-include("sbf_records.hrl").

-export([init/1]).
-export([add/2, generate/2]).
-behavior(gen_server).

init(Config = #sbf{}) ->
    Config.


start_link(Config = #sbf{}) -
    gen_server:start_link(?MODULE, [], Config).

add(Pid, Key) ->
    gen_server:cast(Pid, {add, Key}).

generate(Pid, Type) ->
    gen_server:call(Pid, {gen, Type}).

handle_cast({add, Key}, State) ->
    sbf:add(Key, State),
    {noreply, State}.


handle_call({gen, Type}, _From, State) ->
    Id = get_id(Type),
    case sbf:member(Id, State) of
        true ->
            {reply, exists, State};
        false ->
            Servers = pg2:get_members(sbf),
            lists:map(fun(X) -> erlig:add(X, Id) end, Servers),
            {reply, Id, State}
    end.

get_id(Type) ->
    case Type of
        stamp ->
            id_server:get_id(stamp);
        uuid ->
            id_server:get_id(uuid);
        KeyParts ->
            id_server:get_id(KeyParts)
    end.
