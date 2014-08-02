% Optimized (Recursive Version)

% Returns a sparse matrix
function H = InitialHamiltonian(N)
    dim = 2^N;
    sparseDim = nNonZero(N);
    rows = zeros(sparseDim, 1);
    cols = zeros(sparseDim, 1);
    vals = ones(sparseDim, 1) * -1;

%H = sparse([], [], [], dim, dim);

    count = 1;
    for i = 1:dim
        for j = 1:dim
            % -1 needed to account for 1-based-indexing
            if isValue(dim, i-1, j-1)
                rows(count) = i;
                cols(count) = j;
                count = count + 1;
%H(i, j) = -1;
            end
        end
    end

    H = sparse(rows, cols, vals, dim, dim);

    % Check correctness
    % U = unoptimized(N);    
    % isequal(H, U)
end

% How many non-zero elements are there in the sparse matrix?
function result = nNonZero(N)
    if N == 1
        result = 2;
    else
        prev = nNonZero(N-1);
        result = 2 * prev + 2 * 2^(N-1);
    end
end

% Is there a value at this (i, j) 0-indexed location in H_i?
function result = isValue(dim, i, j)
    if dim == 2
      % Pauli(1) Matrix
      result = ~(i == j);
    else
        half = dim / 2;

        % What part of the matrix are we in?
        uppe = i >= 0 && i < half;
        left = j >= 0 && j < half;

        if uppe && left
            result = isValue(half, i, j);
        elseif ~uppe && ~left
            result = isValue(half, i - half, j - half);
        else
            % On the diagonal
            result = (i - half == j || i == j - half);
        end
    end
end

% Used to test that matrices match in new version
function H = unoptimized(N)

    % Construct the Hamiltonan on N qubits
    % H = - sum_k sigma^x_k

    % initiate H
    H = zeros(2^N);

    % update H
    for k = 1:N
        % initiate
        if (k==1)
            H_k = [0 1; 1 0]; %Pauli(1);
        else
            H_k = [1 0; 0 1];
        end
        % iterate tensor product of matrices
        for j = 2:N
            if (j==k)
                sigma = [0 1; 1 0]; %Pauli(1);
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
end