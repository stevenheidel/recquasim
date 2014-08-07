% Optimized

% Parameters
N = 12;
T = 3;
iter = 1000;
ninstal = 5;

% Sparse Hamiltonians
H_i = InitialHamiltonian(N);
H_f = RandomIsing(N);

% Get probability
[P, ~] = P_installments(H_i, H_f, T, iter, ninstal);

% Print answer
P