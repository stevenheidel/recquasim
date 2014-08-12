% Parameters

% Figure 3
runs = 20000;
N = 8;
T = 10;
ninstal = 10;

processors = 4;
epsilon = eps(1);

% Experiment

H_i = InitialHamiltonian(N);

tic;
P = pararrayfun(processors, @(x) P_distribute(H_i, RandomIsing(N), T, ninstal, epsilon), 1:runs);
toc

num_divergers = sum(P > 1)
hist(P.*(P<1), 1/32:1/32:1-1/32)
title(sprintf('Histogram: success probability for Schrodinger %i qubits, T=%i, ~%i runs', N, T, runs))