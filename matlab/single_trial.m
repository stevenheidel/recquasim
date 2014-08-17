% Parameters

N = 3;
T = 3;
ninstal = 5;
epsilon = eps(1);

% Experiment

tic;
H_i = InitialHamiltonian(N);
H_f = RandomIsing(N);

P = P_distribute(H_i, H_f, T, ninstal, epsilon)
toc