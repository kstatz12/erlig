-module(key_handler).

-export([init/2]).

init(Req0, Opts) ->
    {ok, Body} = key_gen_worker:create(),
	Req = cowboy_req:reply(200, #{
		<<"content-type">> => <<"text/plain">>
	}, str:string_format("~p", Body), Req0),
	{ok, Req, Opts}.
