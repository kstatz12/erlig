-module(filter_ra).
-behaviour(ra_machine).
-export([init/1, apply/3]).
-export([start/0, start/1, start/2]).
-export([add/2, check/2]).
-include("sbf_records.hrl").
%% ra types
-opaque state() :: #sbf{}.

-type erlig_command() :: {add, Key :: term()} | {check, Key :: term()}.

-export_type([
              state/0,
              erlig_command/0
             ]).

%% start with default name and one node
start() ->
    start(filter_ra).
    
%% start with custom name and one node
start(Name) ->
    start(Name, [node()]).

%% start with name and provided nodes
start(Name, Nodes) when is_list(Nodes) ->
    Servers = [{Name, N} || N <- Nodes],
    application:ensure_all_started(ra),
    ra:start_cluster(Name, {module, ?MODULE, #{}}, Servers).
%public
add(Server, Key) ->
    case ra:process_command(Server, {add, Key}) of
        {ok, _, _} -> ok;
        Err -> Err
    end.

check(Server, Key) ->
    case ra:process_command(Server, {check, Key}) of
        {ok, Value, _} -> {ok, Value};
        Err -> Err
    end.

%%ra_machine callbacks
init(_) ->
    sbf:sbf(100000).

apply(_Meta, {add, Key}, State) ->
    sbf:add(Key, State),
    {State, ok, []};
apply(_Meta, {check, Key}, State) ->
    Reply = sbf:member(Key, State),
    {State, Reply, []}.





