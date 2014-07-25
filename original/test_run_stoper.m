function P = test_run_stoper(runs, N, T, tol, ninstal)

% self-stopping version

H_i = zero_time_Hamiltonian(N);
P = zeros(1,runs);

parfor k=1:runs
H_f = random_Ising(N);
[P(k), ~] = P_installments_stoper(H_i, H_f, T, tol, ninstal);
end

%hist(P,32)
%hist(P.*(P<1), 1/64:1/64:1-1/64) % this plots all histograms on a uniform distr of 32 bins
%condition P<1 sorts out all divergent cases
hist(P.*(P<1), 1/32:1/32:1-1/32) 
title('Histogram: success probability for pure Schrodinger 8 qubits, T=4, ~100,000 runs')
%title('Histogram: success probability for 6 qubits, T=2.5, 50,000 runs, either method')