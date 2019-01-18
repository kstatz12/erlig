-module(erlig).
-include("sbf_records.hrl").

-export([init/1, start_link/0]).
-export([add/2,generate/2]).
-behavior(gen_server).

init(_Config) ->
    Sbf = sbf:sbf(100000),
    %% when the genserver starts hydrate the sbf from mnesia
    storage:hydrate(Sbf),
    {ok, Sbf}.


start_link() ->
    gen_server:start_link(?MODULE, [], []).

add(Pid, Id) ->
    gen_server:call(Pid, {add, Id}).

generate(Pid, Type) ->
    gen_server:call(Pid, {gen, Type}).

handle_call({add, Id}, _From, State) ->
    sbf:add(Id, State),
    storage:add(Id),
    {reply, ok, state};

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
