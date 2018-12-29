-module(filter_ra).
-behavior(ra_machine).
-export([init/1, apply/4]).

%%probably restrict this to a sbf type or something
-opaque state() :: term().

-type erlig_command() :: {add, Key :: term()} | {check, Key :: term()}.

init(Config) ->
    Val = maps:find(init_size, Config),
    sbf:sbf(Val).

apply(_Meta, {add, Key}, Effects, State) ->
    sbf:add(Key, State),
    {State, ok, Effects};
apply(_Meta, {check, Key}, Effects, State) ->
    Reply = sbf:member(Key, State),
    {State, Reply, Effects}.

    




