%% records for bloom filters
-record(bloom, {
                e,    % error probability
                n,    % maximum number of elements
                mb,   % 2^mb = m, the size of each slice (bitvector)
                size, % number of elements
                a     % list of bitvectors
               }).

-record(sbf, {
              e,    % error probability
              r,    % error probability ratio
              s,    % log 2 of growth ratio
              size, % number of elements
              b     % list of plain bloom filters
             }).

