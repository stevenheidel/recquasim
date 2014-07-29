% Optimized

% Parameters
N = 8;
T = 3;
iter = 1000;
ninstal = 1000;

% Sparse Hamiltonians
H_i = InitialHamiltonian(N);
H_f = RandomIsing(N);

% Get probability
[P, ~] = PInstallments(H_i, H_f, T, iter, ninstal);

% Print answer
P

% Timings/Memory:
% 8  - 0:03.60 - 23648
% 9  - 0:13.30 - 23872
% 10 - 