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
    %% TODO move to app.config and load via env
    Nodes = [node()],
    init_pg2(Nodes),
    storage:init(Nodes),
    erlig_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
init_pg2(Nodes) ->
    R = lists:map(fun(X) -> rpc:call(X, erlig, start_link, []) end, Nodes),
    pg2:create(sbf),
    P = [PIDS || {_, PIDS} <- R],
    lists:map(fun(X) -> pg2:join(sbf, X) end, P),
    ok.
