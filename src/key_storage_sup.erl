-module(key_storage_sup).

-behavior(supervisor).

-export([init/1]).
-export([start_link/0]).



init(_) ->
    SupFlags = #{strategy => one_for_one, intensity => 1, period => 5},
    Children = [
                #{
                  id => key_storage_serv,
                  start => {key_storage_serv, start_link, []},
                  shutdown => brutal_kill,
                  type => worker,
                  modules => [key_storage_serv]
                 },
                #{
                  id => key_storage_mgr,
                  start => {key_storage_mgr, start_link, []},
                  shutdown => brutal_kill,
                  type => worker,
                  modules => [key_storage_mgr]
                 }
               ],
    {ok, {SupFlags, Children}}.

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

