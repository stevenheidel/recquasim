% Optimized

% Returns a sparse matrix
function H = InitialHamiltonian(N)
    
    % Construct the Hamiltonan on N qubits
    % H = - sum_k sigma^x_k

    dim=2^N;
    rows=[1 2];
    cols=[2 1];

    for k=1:N-1
        rows=[rows rows+2^k];
        cols=[cols cols+2^k];
        p=1:2^k;
        rows=[rows p p+2^k];
        cols=[cols p+2^k p];
    end

    vals=-ones(1,size(rows,2));
    H = sparse(rows, cols, vals, dim, dim);

end