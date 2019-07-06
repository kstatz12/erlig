-module(key_storage_mgr).

-behavior(gen_server).

-export([init/1]).

-export([start_link/0]).

-export([terminate/2,
         code_change/3,
         handle_call/3,
         handle_cast/2,
         handle_info/2]).

-define(SERVER, ?MODULE).

-record(state, {table_id}).


give_away() ->
    gen_server:cast(?MODULE, give_away).

init(_) ->
    io:format("Starting Key Storage Manager at PID ~p ~n", [self()]),
    process_flag(trap_exit, true),
    give_away(),
    {ok, #state{}}.

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(give_away, State) ->
    Server = wait_for_srv(),
    link(Server),
    TableId = ets:new(?MODULE, [bag]),
    ets:setopts(TableId, {heir, self()}, [bag]),
    ets:give_away(TableId, Server, [bag]),
    {noreply, State#state{table_id = TableId}};

handle_cast(_Msg, State) ->
    {noreply, State}.


handle_info({'EXIT', _Pid, killed}, State) ->
    {noreply, State};

handle_info({'ETS-TRANSFER', TableId, _Pid, Data}, State) ->
    Server = wait_for_srv(),
    link(Server),
    ets:give_away(TableId, Server, Data),
    {noreply, State#state{table_id = TableId}}.

wait_for_srv() ->
    case whereis(key_storage_serv) of
        undefined ->
            timer:sleep(1),
            wait_for_srv();
        Pid -> Pid
   end.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
