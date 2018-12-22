-module(sbf).
-import(math, [log/1, pow/2]).
-import(log2, [log2/1]).
-record(bloom, {
    error_probability,
    max_size,
    slice,
    size,
    bit_vectors
}).

-record(sbf, {
    error_probability, 
    error_probability_r, 
    growth_ratio, 
    size, 
    filters
}).


%%fixed size bloom init
bloom(Mode, Dimmensions, ErrorProb) ->
    K = 1 + trunc(log2(1/ErrorProb)),
    P = pow(ErrorProb, 1/K),
    case Mode of
        size ->
            MB = 1 + trunc(-log2(1 - pow(1 - P, 1 / Dimmensions)));
        bits ->
            MB = Dimmensions
    end,
    M = 1 bsl MB,
    N = trunc(log(1 - P) / log(1-1/M)),
    #bloom{error_probability = ErrorProb, max_size = N, slice = MB, size = 0, bit_vectors = [bitarray:new(1 bsl MB) || _ <- lists:seq(1, K)]}.
