% Optimized (Pure Sparse Version)

% Returns a sparse matrix
function H = InitialHamiltonian(N)
    
    % Construct the Hamiltonan on N qubits
    % H = - sum_k sigma^x_k

    % Initialize a matrix of all zeros
    dim = 2^N;
    H = sparse([], [], [], dim, dim);

    % Sparse Pauli matrix
    p0 = sparse([1 0; 0 1]);
    p1 = sparse([0 1; 1 0]);

    % update H
    for k = 1:N
        % initiate
        if (k==1)
            H_k = p1;
        else
            H_k = p0;
        end
        % iterate tensor product of matrices
        for j = 2:N
            if (j==k)
                sigma = p1;
            else
                sigma = p0;
            end
            H_k = kron(H_k, sigma);
        end
        H = H + H_k;
    end

    %change sign
    H = -H;
end