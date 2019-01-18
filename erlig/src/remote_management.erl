-module(remote_management).
-export([connect_node/1, init/1]).


connect_node(Node) ->
    Members = pg2:get_members(sbf),
    case lists:member(Node, Members) of
        false ->
            PID = rpc:call(Node, erlig, start_link, []),
            pg2:join(sbf, PID);
        _ ->
            exists
    end.
    

init(Nodes) ->
    R = lists:map(fun(X) -> rpc:call(X, erlig, start_link, []) end, Nodes),
    pg2:create(sbf),
    P = [PIDS || {_, PIDS} <- R],
    lists:map(fun(X) -> pg2:join(sbf, X) end, P),
    ok.
