% Parameters

% Figure 6
runs = 20000;
N = 12;
T = 14;
ninstal = 14;
epsilon = eps(1);

% Experiment

H_i = InitialHamiltonian(N);

tic;
P = pararrayfun(8, @(x) P_distribute(H_i, RandomIsing(N), T, ninstal, epsilon)(1), 1:runs);
toc

num_divergers = sum(P > 1)
hist(P.*(P<1), 1/32:1/32:1-1/32)
title(sprintf('Histogram: success probability for Schrodinger %i qubits, T=%i, ~%i runs', N, T, runs))