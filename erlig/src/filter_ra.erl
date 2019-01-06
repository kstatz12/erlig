-module(filter_ra).
-behaviour(ra_machine).
-export([init/1, apply/3]).
-export([start/0, start/1, start/2]).
-include("sbf_records.hrl").

-opaque state() :: #sbf{}.
-type filter_ra_command() :: {write, Key :: term()} | {check, Key :: term()}.
-export_type([state/0, filter_ra_command/0]).

%% start with default name and one node
start() ->
    start(?MODULE).
%% start with custom name and one node
start(Name) ->
    start(Name, [{filter_ra0, node()}, {filter_ra1, node()}, {fitler_ra2, node()}]).
start(Name, Nodes) when is_list(Nodes) ->
    Config = #{},
    Machine = {module, ?MODULE, Config},
    application:ensure_all_started(ra),
    ra:start_cluster(Name, Machine, Nodes).
init(_Config) ->
    sbf:sbf(1000000).


apply(_Meta, {write, Key}, State) ->
    {State, ok, []};
apply(_Meta, {check, Key}, State) ->
    Exists = sbf:member(Key, State),
    {State, Exists, []}.
    





