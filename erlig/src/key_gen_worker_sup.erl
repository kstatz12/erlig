-module(key_gen_worker_sup).

-behavior(supervisor).

-export([init/1]).

-export([start_link/0]).


init(_) ->
    SupFlags = #{strategy => one_for_one, intensity => 1, period => 5},
    Children = [
                #{
                  id => key_gen_worker,
                  start => {key_gen_worker, start_link, []},
                  shutdown => brutal_kill,
                  type=> worker,
                  modules => [key_gen_worker]
                 }
               ],
    {ok, {SupFlags, Children}}.

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).
