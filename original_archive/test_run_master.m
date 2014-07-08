function P = test_run_master(runs, N, T, iter, ninstal)

% for 8 qubits T= 3 seems to be more or less the 
% longest time for which there stillis convergence

H_i = zero_time_Hamiltonian(N);
%L = .1*a
Lind =  .1*make_Lindblad_operator(N);
%Lind = zeros(2^N); %test of consistency with pure Schroedinger

P = zeros(1,runs);

parfor k=1:runs
    % L = random three-diagonal
%L = diag(randn(1,2^N),0)+ diag(randn(1,2^N-1),1) + diag(randn(1,2^N-1),-1);
%Lind = .1*L;
H_f = random_Ising(N);
%[P(k),~] = P_success_DWave_master(H_i, H_f, Lind, T, iter);
[P(k), ~] = P_master_installments(H_i, H_f, Lind, T,iter, ninstal);
end

%hist(P,32)
hist(P, 1/32:1/32:1-1/32) % this plots all histograms on a uniform distr of 32 bins
title('Histogram: success probability for 8 qubits, T=4, L=.05a, 500,000 runs');
