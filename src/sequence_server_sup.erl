-module(sequence_server_sup).
-behavior(supervisor).

-export([init/1]).

-export([start_link/0]).


start_link() ->
    supervisor:start_link(?MODULE, []).

init(_) ->
    SupFlags = #{strategy => one_for_one, intensity => 1, period => 5},
    Child = [#{
               id => sequence_server,
               start => {sequence_server, start_link, []},
               shutdown => brutal_kill,
               type => worker,
               modules => [sequence_server]
              }
            ],
    {ok, {SupFlags, Child}}.

    
