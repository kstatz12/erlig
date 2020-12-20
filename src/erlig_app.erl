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
    
    application:ensure_all_started(cowboy),

    key_storage_sup:start_link(),
    sequence_server_sup:start_link(),
    key_gen_worker_sup:start_link(),

	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", key_handler, []}
		]}
	]),
	{ok, _} = cowboy:start_clear(http, [{port, 8080}], #{
		env => #{dispatch => Dispatch}
	}),
    erlig_sup:start_link().


%%--------------------------------------------------------------------
stop(_State) ->
    ok = cowboy:stop_listener(http).

    
    
    

%%====================================================================
%% Internal functions
%%====================================================================
