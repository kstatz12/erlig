-module(key_gen).

-export([create/0]).

create() ->
    Str = str:string_format("~p", [node(), sequence_server:next(), os:timestamp()]),
    Binary = murmur:murmur3_x64_128(list_to_binary(Str)),
    [<<"34=",X/binary>>] = [Binary],
    list_to_integer(binary_to_list(X)).


