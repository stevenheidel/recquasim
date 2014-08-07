% Parameters

% Figure 1
runs = 500000;
N = 8;
T = 4;
ninstal = 4;
epsilon = eps(1);

% Experiment

H_i = InitialHamiltonian(N);

function p = runner(H_i, T, ninstal, epsilon, N)
    H_f = RandomIsing(N);
    [p, ~] = P_installments(H_i, H_f, T, ninstal, epsilon);
end

P = pararrayfun(4, @(x) runner(H_i, T, ninstal, epsilon, N), 1:runs);

non_divergers = sum(P > 1)
hist(P.*(P<1), 1/32:1/32:1-1/32)
title(sprintf('Histogram: success probability for Schrodinger %i qubits, T=%i, ~%i runs', N, T, runs))