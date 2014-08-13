% Parameters

N = 25;
T = 3;
ninstal = 5;
epsilon = eps(1);

% Experiment

tic;
H_i = sparse([], [], [], 2^N, 2^N);%InitialHamiltonian(N);
H_f = RandomIsing(N);

P = P_distribute(H_i, H_f, T, ninstal, epsilon)
toc