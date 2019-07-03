-module(str).

-export([string_format/2]).

string_format(Pattern, Value) ->
    lists:flatten(io_lib:format(Pattern, [Value])).



