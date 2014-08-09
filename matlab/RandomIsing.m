% Optimized

% If J not supplied then a random matrix is generated, otherwise use it as a seed

% Returns a sparse matrix
function [H, J, num_solutions] = RandomIsing(N, J)

    % Construct the Ising Hamiltonan on N qubits
    % H_f = -sum_{l<k} J_{lk} sigma^z_l tensor sigma^z_k - sum_l h_l sigma^z_l

    % Initialize a matrix of all zeros
    dim = 2^N;
    H = sparse([], [], [], dim, dim);

    % Pauli matrices
    p0 = sparse([1 0; 0 1]);
    p3 = sparse([1 0; 0 -1]);

    if ~exist('J', 'var')
        J = 2 * rand(N) - 1;
        % J = 2 * randi(2, N) - 3;
        J = triu(J);
    end

    p0_list = cell(N);
    for k = 1:N
        p0_list{k} = p0;
    end

    % -sum_{k<l} J_{kl} sigma^z_k tensor sigma^z_l
    for l = 1:N
        for k = 1:(l-1)
            % construct J_{kl} sigma^z_k tensor sigma^z_l
            op_list = p0_list;
            op_list{k} = p3;
            op_list{l} = p3;

            H_kl = tensor_list(op_list);

            % multiply with random J_kl
            H = H - J(k, l) * H_kl;
        end
    end

    % -sum_l h_l sigma^z_l
    for l = 1:N
        % construct h_l sigma^z_l
        op_list = p0_list;
        op_list{l} = p3;

        H_l = tensor_list(op_list);

        % multiply with random h_l, stored in J down the unused diagonal
        H = H - J(l, l) * H_l;
    end

    h = full(diag(H));
    num_solutions = sum(h == min(h));
end

% iterate tensor product of matrices
function A = tensor_list(op_list)
    A = op_list{1};

    for k = 2:length(op_list)
        A = kron(A, op_list{k});
    end
end