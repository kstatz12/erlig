-module(id_server).
-behaviour(gen_server).

-export([init/1, start_link/1]).
-export([get_id/1]).

init(Config) ->
    ok.

start_link(Config) ->
    gen_server:start_link({global, ?MODULE}, ?MODULE, [], Config).

get_id(stamp) ->
    get_server:call({global, ?MODULE}, {get, stamp});
get_id(uuid) ->
    get_server:call({global, ?MODULE}, {get, uuid});
get_id(KeyParts) ->
    gen_server:call({global, ?MODULE}, {get, KeyParts}).


handle_cast({get, stamp}, _From, State) ->
    ok;
handle_cast({get, uuid}, _From, State) ->
    ok;
handle_cast({get, KeyParts}, _From, State) ->
    ok.









