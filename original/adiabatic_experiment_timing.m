function [Ts, Ps, Qs] = adiabatic_experiment_timing(qubit_min, qubit_max, T, iter, ninstal)

% test of the scaling of the adiabatic computaiton with the number of qubit

len = qubit_max - qubit_min + 1;
Qs = zeros(1, len);
Ps = zeros(1, len);

parfor k = 1:len
    len-k
    Qs(k) = k + qubit_min - 1;
    H_i = zero_time_Hamiltonian(Qs(k));
    H_f = random_Ising(Qs(k));
    tic; 
    [Ps(k), ~] = P_installments(H_i, H_f, T, iter, ninstal); 
    Ts(k) = toc;
end

