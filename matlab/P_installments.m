function [P, psi] = P_installments(H_i, H_f, T, iter, ninstal)

% Calculate the probability of success for an adiabatic process
% using the method of analytic series expansion in ninstal steps

% N = number of quibits, e.g. N = 8
% Input is as follows (N and T and iter may be adjusted 
% but must ensure convergence):

% H_i = zero_time_Hamiltonian(N);
% H_f = random_Ising(N);
% T = 3;
% iter = 1000

% Find the initial state -- the ground state of H_i

% In the special case of H_i = - sum sigma^x_k the ground state is known
% (numerical observation)

[m, ~] = size(H_i);
psi_0 = (1/sqrt(m))*ones(m,1);

% Find the desired final ground state SPACE of H_f (degenerate ground state)

h_f = diag(H_f); % H_f is diagonal so all eigenvecotrs are e_n where n \in ind
ind = (h_f == min(h_f)); % this is a sufficient description of the projector 
                         % -- see last lines of this code

% initialize variables
step = 1/ninstal;
A = -1i*T*H_i;
B = -1i*T*(H_f - H_i);
psi_in = psi_0;

% run recurrence
for k = 1:ninstal
    psi_in = Taylor_installment(A, B, iter, psi_in, step);
    A = A + step*B;
end
psi = psi_in;
P = norm(psi(ind))^2;