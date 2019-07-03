-module(sequence_server_sup).

-behavior(supervisor).


-export([start_link/0]).

-export([init/1]).

start_link() ->
    supervisor:start_link(?MODULE, []).


init(_) ->
    
