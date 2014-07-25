function H = zero_time_Hamiltonian(N)

% Construct the Hamiltonan on N qubits
% H = - sum_k sigma^x_k

% initiate H
H = zeros(2^N);

% update H
for k = 1:N
    % initiate
    if (k==1)
        H_k = Pauli(1);
    else
        H_k = [1 0; 0 1];
    end
    % iterate tensor product of matrices
    for j = 2:N
        if (j==k)
            sigma = Pauli(1);
        else
            sigma = [1 0; 0 1];
        end
        H_k = kron(H_k, sigma);
    end
    H = H + H_k;
end

%change sign
H = -H;

% Copyright (c) Artur Sowa, December 2013  