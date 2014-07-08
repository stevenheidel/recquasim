function L = make_Lindblad_operator(N)

% construct Lindblad operator for N qubits
% Note that there are many options here and no strict directions
% which is best

% based on the annihilation operator

L = diag(sqrt(1:1:(2^N-1)), 1);


% Copyright (c) Artur Sowa, December 2013  