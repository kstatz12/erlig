-module(key_gen_tests).

-include_lib("eunit/include/eunit.hrl").

-ifdef(EUNIT_TEST).
-compile(export_all).
-endif.

list_tests() ->
    First = key_gen:create(["test", atom, 1]),
    Second = key_gen:create(["test", atom, 1]),
    ?assertEqual(First, Second).

    
    

    
