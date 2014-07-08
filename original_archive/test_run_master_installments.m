function P = test_run_master_installments(runs, N, T, iter, ninstal)


H_i = zero_time_Hamiltonian(N);
L = .01*make_Lindblad_operator(N);
P = zeros(1,runs);

parfor k=1:runs
H_f = random_Ising(N);
[P(k), ~] = P_master_installments(H_i, H_f, L, T, iter, ninstal);
end

%hist(P,32)
hist(P.*(P<1), 1/64:1/64:1-1/64) % this plots all histograms on a uniform distr of 32 bins
%condition P<1 sorts out all divergent cases
title('Histogram: success probability for 8 qubits, T=10 (6 steps), L=.02*a, 10,000 runs')
%title('Histogram: success probability for 6 qubits, T=2.5, 50,000 runs, either method')