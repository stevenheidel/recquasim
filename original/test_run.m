function P = test_run(runs, N, T, iter)

% for 8 qubits T= 3 seems to be more or less the 
% longest time for which there stillis convergence

H_i = zero_time_Hamiltonian(N);
P = zeros(1,runs);

parfor k=1:runs
H_f = random_Ising(N);
P(k) = P_success_DWave_test(sparse(H_i), sparse(H_f), T, iter);
end

%hist(P,32)
%hist(P, 1/32:1/32:1-1/32) % this plots all histograms on a uniform distr of 32 bins
%title('Histogram: success probability for 8 qubits, T=3, 500,000 runs')
%title('Histogram: success probability for 6 qubits, T=2.5, 50,000 runs, either method')