-module(key_storage_serv).

-behavior(gen_server).

-export([put/1]).

-export([init/1]).
-export([start_link/0]).
-export([handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {init = true, table_id}).

put(Key) ->
    gen_server:call(?MODULE, {put, Key}).


start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

init(_) ->
    io:format("Starting Key Storage Server at PID ~p ~n", [self()]),
    {ok, #state{}}.

handle_call({put, Key}, _From, State) ->
    TableId = State#state.table_id,
    case ets:lookup(TableId, Key) of
        [] ->
            {reply, exists, State};
        _ ->
            ets:insert(TableId, {Key, os:timestamp()}),
            {reply, ok, State}
    end.

handle_cast(_Request, State) ->
    {noreply, State}.

handle_info({'ETS_TRANSFER', TableId, _Pid, _Data}, State) ->
    {noreply, State#state{table_id = TableId}};
handle_info(_Info, State) ->
    {noreply, State}.


terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.








