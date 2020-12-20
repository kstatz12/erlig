-module(key_gen_worker).

-behavior(gen_server).

-export([
         start_link/0, 
         init/1,
         handle_call/3,
         handle_cast/2
]).
-export([create/0, create/1]).
-define(SERVER, ?MODULE).


start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

init(_) ->
    {ok, []}.


create() ->
    gen_server:call(?MODULE, create).

create(Args) ->
    gen_server:call(?MODULE, {create, Args}).

handle_call({create, Args}, _From, State) ->
    case key_gen:create(Args) of
        invalid_input ->
            {reply, invalid_input, State};
        Key ->
            check_for_duplicate(Key, State)
    end;
handle_call(create, _From, State) ->
    Key = key_gen:create(),
    check_for_duplicate(Key, State).

handle_cast(_, State) ->
    {noreply, State}.

check_for_duplicate(Key, State) ->
    case key_storage_serv:put(Key) of
        ok ->
            {reply, {ok, Key}, State};
        _ ->
            {reply, key_exists, State}
    end.
