function [P, rho] = P_master_installments(H_i, H_f, L, T, iter, ninstal)

% Calculate the probability of success for an adiabatic process
% with a Lindblad dissipation
% using the method of analytic series expansion in ninstal steps

% N = number of quibits, e.g. N = 8
% Input is as follows (N and T and iter may be adjusted 
% but must ensure convergence):

% H_i = zero_time_Hamiltonian(N);
% H_f = random_Ising(N);
% L = make_Lindblad_operator(N);


% Find the initial state -- the ground state of H_i

% In the special case of H_i = - sum sigma^x_k the ground state is known
% (numerical observation)

[m, ~] = size(H_i);
psi_0 = (1/sqrt(m))*ones(m,1);
rho_0 = psi_0*psi_0';

% Find the desired final ground state SPACE of H_f (degenerate ground state)

h_f = diag(H_f); % H_f is diagonal so all eigenvecotrs are e_n where n \in ind
ind = (h_f == min(h_f)); % this is a sufficient description of the projector 
                         % -- see last lines of this code

% simplify notation, here hbar =1
A = -1i*T*H_i;
B = -1i*T*(H_f - H_i);
step = 1/ninstal;
rho_in = rho_0;

% run recurrence
for k = 1:ninstal
    rho_in = Taylor_master_installment(A, B, L, T, iter, rho_in, step);
    A = A + step*B;
end
rho = rho_in;

% when the ground state is degenerate probability of success measures how
% much of the density matrix falls into the ground state space

P = real(trace(rho(ind,ind))); % use real to suppress small imaginary part

