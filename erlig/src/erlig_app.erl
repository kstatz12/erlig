%%%-------------------------------------------------------------------
%% @doc erlig public API
%% @end
%%%-------------------------------------------------------------------

-module(erlig_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    %% TODO move to app.config and load
    Nodes = [node()],
    remote_management:init(Nodes),
    %% TODO move to app.config and load
    StorageNodes = [node()],
    storage:init(StorageNodes),
    erlig_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
