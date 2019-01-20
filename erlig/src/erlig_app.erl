%%%-------------------------------------------------------------------
%% @doc erlig public API
%% @end
%%%-------------------------------------------------------------------

-module(erlig_app).

-behaviour(application).
-include("storage.hrl").
%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Nodes = [node(), node(), node(), node(), node()],
    remote_management:init(Nodes),
    StorageNodes = [node(), node(), node()],
    storage:init(StorageNodes),
    %%a global process, probably a bad idea
    id_server:start_link(),
    mnesia:wait_for_tables([erlig_hash], 5000),
    erlig_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    StorageNodes = application:gen_env(erlig, storage_nodes),
    storage:stop_mnesia(StorageNodes),
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
