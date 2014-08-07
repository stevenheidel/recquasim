% Parameters

% Figure 1
runs = 500%0000;
N = 8;
T = 4;
ninstal = 4;
epsilon = eps(1);

% Experiment

H_i = InitialHamiltonian(N);

P = pararrayfun(4, @(x) P_distribute(H_i, RandomIsing(N), T, ninstal, epsilon, N), 1:runs);

non_divergers = sum(P > 1)
hist(P.*(P<1), 1/32:1/32:1-1/32)
title(sprintf('Histogram: success probability for Schrodinger %i qubits, T=%i, ~%i runs', N, T, runs))