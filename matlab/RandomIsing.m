% Optimized

% id is from 1 to total possibilities, and creates signos for that equivalent in binary

function H = RandomIsing(N, id)
    signos = zeros(N, N);

    if exist('id', 'var')
        binary_digits = (N * (N-1) / 2);
        total = 2 ^ binary_digits;

        if id < 1 || id > total
            error('id outside of range')
        end

        B = int8(bitget(id-1, 1:binary_digits));
        B(B == 0) = -1;

        count = 1;
        for k = 1:N
            for r = k+1:N
                signos(k, r) = B(count);
                count += 1;
            end
        end
    else
        signos = 2 * randi(2, N) - 3;
        signos = triu(signos, 1);
    end

    dim = 2^N;
    vals = zeros(1, dim/2);

    for k = 1:N-1
        temp = zeros(1, dim/2^k);

        for r = k+1:N
            mac = [ones(1, dim/2^r) -ones(1, dim/2^r)];

            for p = 1:r-(k+1)
                mac = [mac mac];
            end

            temp = temp + signos(k, r) * mac;
        end

        for p = 1:k-1
            temp = [temp fliplr(temp)];
        end

        vals = vals + temp;
    end

    vals = [vals fliplr(vals)];
    H = sparse(1:dim, 1:dim, vals, dim, dim);
end

% If J not supplied then a random matrix is generated, otherwise use it as a seed

% Returns a sparse matrix
function [H, J, num_solutions] = RandomIsing2(N, J)

    % Construct the Ising Hamiltonan on N qubits
    % H_f = -sum_{l<k} J_{lk} sigma^z_l tensor sigma^z_k - sum_l h_l sigma^z_l

    % Include second term or not
    second_term = false;

    % Initialize a matrix of all zeros
    dim = 2^N;
    H = sparse([], [], [], dim, dim);

    % Pauli matrices
    p0 = sparse([1 0; 0 1]);
    p3 = sparse([1 0; 0 -1]);

    if ~exist('J', 'var')
        % J_kl are integers in {-1, 1}
        J = 2 * randi(2, N) - 3;
        J = triu(J, 1);

        if second_term
            % h are reals in [-1, 1], placed along the unused diagonal of J
            h = 2 * rand(N, 1) - 1;
            J = J + diag(h);
        end
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

        % multiply with random h_l, stored in J's diagonal
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