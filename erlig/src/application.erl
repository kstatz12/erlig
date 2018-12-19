-module(application).
-behavior(application).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', 
         [
            {"/keys/get", key_handler, [{op,get}]}
         ]}
        ]),
    {ok, _} = cowboy:start_clear(erlig_http_listener, 100, 
                                 [{port, 8002}],
                                 #{env => #{dispatch => Dispatch}}).

stop(_State) ->
    ok.
