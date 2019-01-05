-module(id_server).
-behaviour(gen_server).

-export([init/1, start_link/1]).
-export([handle_call/3]).
-export([get_id/1]).


init(Config) ->
    quickrand:seed(),
    {ok, []}.

start_link(Config) ->
    gen_server:start_link({global, ?MODULE}, ?MODULE, [], Config).

get_id(stamp) ->
    gen_server:call({global, ?MODULE}, {get, stamp});
get_id(uuid) ->
    gen_server:call({global, ?MODULE}, {get, uuid});
get_id(KeyParts) ->
    gen_server:call({global, ?MODULE}, {get, KeyParts}).


handle_call({get, stamp}, _From, State) ->
    {ok, Hash} = id:get_id(stamp),
    {reply, Hash, State};
handle_call({get, uuid}, _From, State) ->
    {ok, Hash} = id:get_id(uuid),
    {reply, Hash, State};
handle_call({get, KeyParts}, _From, State) ->
    {ok, Hash} = id:get_id(KeyParts),
    {reply, Hash, State}.











