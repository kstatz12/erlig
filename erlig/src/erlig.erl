-module(erlig).
-include("sbf_records.hrl").

-export([init/1, start_link/0]).
-export([add/2,generate/2]).
-export([handle_call/3, handle_cast/2]).
-behavior(gen_server).

init(_Config) ->
    Sbf = sbf:sbf(30000),
    %% when the genserver starts hydrate the sbf from mnesia
    %% storage:hydrate(Sbf),
    {ok, Sbf}.


start_link() ->
    gen_server:start_link(?MODULE, [], []).

add(Pid, Id) ->
    gen_server:cast(Pid, {add, Id}).

generate(Pid, Type) ->
    gen_server:call(Pid, {gen, Type}).

handle_cast({add, Id}, State) ->
    NewState = sbf:add(Id, State),
    {noreply, NewState}.

handle_call({gen, Type}, _From, State) ->
    Id = get_id(Type),
    case sbf:member(Id, State) of
        true ->
            {reply, exists, State};
        false ->
            Pids = pg2:get_members(sbf),
            lists:foreach(fun(X) -> erlig:add(X, Id) end, Pids),
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
3
