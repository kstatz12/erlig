-module(key_gen).

-export([create/0]).

create() ->
    Str = str:string_format("~p", [node(), sequence_server:next(), os:timestamp()]),
    <<Int:64/integer, _/binary>> = murmur:murmur3_x64_128(list_to_binary(Str)),
    Int.



