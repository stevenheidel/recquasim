% Optimized (Recursive Version)

% Returns a sparse matrix
function H = RandomIsing(N)
    dim = 2^N;
    B = getDiagonal(N);
    d = [0];

    H = spdiags(B, d, dim, dim);
end

% Just the diagonal
function diagonal = getDiagonal(N)
    dim = 2^N;
    diagonal = zeros(dim, 1);

    for i = 2:N
        for j = 1:(i-1)
            diagonal -= j_kl() * h_kl(N, i, j);
        end
    end

    % Check correctness
    % isequal(diagonal, diag(unoptimized(N)))
end

% Return either -1 or 1
function random = j_kl()
    random = 2*randi(2,1)-3;
end

% Returns a vector with the offset relationship
function vector = h_kl(n, l, k)
    half = recurse(n, l, k);

    vector = [half; flipud(half)];
end

function vector = recurse(n, l, k)
    if l == 2 && k == 1
        quarter = 2^(n-2);

        vector = [ones(quarter, 1); ones(quarter, 1) * -1];
    elseif k == 1
        sub = recurse(n-1, l-1, k);

        vector = [sub; sub];
    else
        sub = recurse(n-1, l-1, k-1);

        vector = [sub; flipud(sub)];
    end
end

function H = unoptimized(N)

    % Construct the Ising Hamiltonan on N qubits
    % H_I = -sum_{l<k} J_{lk} sigma^z_l tensor sigma^z_k 
    % leave the traditional second component - sum_l h_l sigma^z_l out for now

    % initiate H
    H = -zeros(2^N);

    % update H
    for l = 2:N
        for k = 1:(l-1)
            
            % construct J_{kl} sigma^z_k tensor sigma^z_l
            
            % initiate
            if (k==1 || l==1)
                H_kl = [1 0; 0 -1];%Pauli(3);
            else
                H_kl = [1 0; 0 1];
            end
            % iterate tensor product of matrices
            for j = 2:N
                if (j==k || j==l)
                    sigma = [1 0; 0 -1];%Pauli(3);
                else
                    sigma = [1 0; 0 1];
                end
                H_kl = kron(H_kl, sigma);
            end
            % generate random J_kl
            J_kl = 2*randi(2,1)-3;
            H = H - J_kl*H_kl;
        end
    end


    % Copyright (c) Artur Sowa, December 2013
end