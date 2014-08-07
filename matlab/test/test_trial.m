% Parameters

N = 18;
T = 3;
ninstal = 3;
epsilon = eps(1);

% Experiment

H_i = InitialHamiltonian(N);
H_f = RandomIsing(N);

tic;
[P, ~] = P_distributed(H_i, H_f, T, ninstal, epsilon);
toc

P

cd ..
tic;
single_trial
toc
cd test