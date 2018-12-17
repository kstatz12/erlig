-module(erlig_generator).

-export([generate/1]).

generate(NodeId) ->
    Stamp = os:system_time(),
    {key, Stamp}.

