-module(generator).
-export([generate/0]).
-record(gen_result, {
                     time_stamp,
                     time_stamp_str,
                     hash
                    }).
generate() ->
    Stamp = os:system_time(),
    StampStr = lists:flatten(io_lib:format("~p", [Stamp])),
    <<Hash:64/integer, _/binary>> = murmur:murmur3_x64_128(<<Stamp>>),
    #gen_result{time_stamp = Stamp, time_stamp_str = StampStr, hash = Hash}.
   
