% Optimized

% Parameters
N = 10;
T = 3;
iter = 1000;
ninstal = 1000;

% Sparse Hamiltonians
tic;
H_i = InitialHamiltonian(N);
toc
tic;
H_f = RandomIsing(N);
toc

% Get probability
tic;
[P, ~] = P_installments(H_i, H_f, T, iter, ninstal);
toc

% Print answer
P

% Timings/Memory:
% 8  - 0:52.29 - 23656 bytes
% 9  - 1:50.73 - 23896 bytes
% 10 - 4:07.82 - 24948 bytes