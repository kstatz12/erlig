-module(sequence_server).

-behavior(gen_server).

-export([start_link/0]).

-export([init/1, handle_call/3, handle_cast/2]).

-export([next/0, reset/0]).

-define(SEQUENCE_MAX, 1024 * 100).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

next() ->
    gen_server:call(?MODULE, next).

reset() ->
    gen_server:cast(?MODULE, reset).

init(_) ->
    io:format("Starting Sequence Server at PID ~p ~n", [self()]),
    {ok, 0}.

handle_call(next, _From, State) ->
    case State of
        ?SEQUENCE_MAX ->
            {reply, State, 1};
        _ ->
            {reply, State, State + 1}
    end.

handle_cast(reset, _State) ->
    {noreply, 0}.
