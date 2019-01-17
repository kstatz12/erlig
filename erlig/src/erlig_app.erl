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
    PIDS = lists:map(fun(X) -> rpc:call(X, erlig, start_link, []) end, Nodes),
    pg2:create(sbf),
    lists:map(fun(X) -> pg2:join(sbf, X) end, PIDS),
    erlig_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
