% Parameters

N = 1;
T = 3;
ninstal = 3;
epsilon = eps(1);

% Experiment

H_i = InitialHamiltonian(N);
H_f = RandomIsing(N);

tic;
[P, ~] = P_distribute(H_i, H_f, T, ninstal, epsilon);
toc

P