function H = random_Ising(N)

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
            H_kl = Pauli(3);
        else
            H_kl = [1 0; 0 1];
        end
        % iterate tensor product of matrices
        for j = 2:N
            if (j==k || j==l)
                sigma = Pauli(3);
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