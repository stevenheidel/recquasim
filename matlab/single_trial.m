% Parameters

N = 3;
T = 3;
ninstal = 1;
epsilon = eps(1);

% Experiment

H_i = InitialHamiltonian(N);
H_f = RandomIsing(N);

tic;
P = P_distribute(H_i, H_f, T, ninstal, epsilon);
toc

P