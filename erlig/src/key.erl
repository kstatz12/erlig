-module(key)
.
create() ->
    NodeName = atom_to_list(node()),
    TS = {_, _, Micro} = os:time_stamp(),
    
    ok.
