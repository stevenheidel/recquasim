% Optimized (Pure Sparse Version)

% Returns a sparse matrix
function H = RandomIsing(N)

    % Construct the Ising Hamiltonan on N qubits
    % H_I = -sum_{l<k} J_{lk} sigma^z_l tensor sigma^z_k 
    % leave the traditional second component - sum_l h_l sigma^z_l out for now

    % Initialize a matrix of all zeros
    dim = 2^N;
    H = sparse([], [], [], dim, dim);

    % Pauli matrices
    p0 = sparse([1 0; 0 1]);
    p3 = sparse([1 0; 0 -1]);

    % update H
    for l = 2:N
        for k = 1:(l-1)
            
            % construct J_{kl} sigma^z_k tensor sigma^z_l
            
            % initiate
            if (k==1 || l==1)
                H_kl = p3;
            else
                H_kl = p0;
            end
            % iterate tensor product of matrices
            for j = 2:N
                if (j==k || j==l)
                    sigma = p3;
                else
                    sigma = p0;
                end
                H_kl = kron(H_kl, sigma);
            end
            % generate random J_kl
            J_kl = 2*randi(2,1)-3;
            H = H - J_kl*H_kl;
        end
    end
end