% Optimized (Recursive Version)

% Returns a sparse matrix
function H = InitialHamiltonian(N)
    dim = 2^N;
    H = sparse([], [], [], dim, dim);

    for k = 1:dim
        H = recurse(H3, k, k-1, 1, N);
    end
end

function H = recurse(H, global_row, row, col_offset, n)
    dim = 2 ^ n;

    if n == 1
        if mod(row, 2) == 0
            H(global_row, col_offset + 1) = -1;
        else
            H(global_row, col_offset) = -1;
        end
    else
        half = dim / 2;
        ident_col = mod(row, half);

        if row < half
            H = recurse(H, global_row, row, col_offset, n-1);
            H(global_row, col_offset + ident_col + half) = -1;
        else
            H(global_row, col_offset + ident_col) = -1;
            H = recurse(H, global_row, ident_col, col_offset + half, n-1);
        end
    end
end