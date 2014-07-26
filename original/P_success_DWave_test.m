function P = P_success_DWave_test(H_i, H_f, T, iter)

% Calculate the probability of success for an adiabatic process
% using the method of analytic series expansion

% N = number of quibits, e.g. N = 8
% Input is as follows (N and T and iter may be adjusted 
% but must ensure convergence):

% H_i = zero_time_Hamiltonian(8);
% H_f = random_Ising();
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
 
%[V,~] =  eig(H_f);
%psi_des = V(:,1);  

% simplify notation
A = -1i*T*H_i;
B = -1i*T*(H_f - H_i);

% initialize recurrence

psi_n_min_2 = psi_0;
psi_n_min_1 = A*psi_0;
psi = psi_n_min_1 + psi_n_min_2;
%psi_n = zeros(size(psi_n_min_1));

% recurrence

for n = 2:iter
    psi_n = (1/n)*(A*psi_n_min_1 + B*psi_n_min_2);
    psi = psi + psi_n;
    %norm(psi) % norm converges to 1 for iter large, which is amazing 
    psi_n_min_2 = psi_n_min_1;
    psi_n_min_1 = psi_n;
end
    
% when the ground state is degenerate probability of success measures how
% much of the wavefunction falls into the ground state space

P = norm(psi(ind))^2;
    
% Copyright (c) Artur Sowa, November 2013    
    
    
    
    
    
    
