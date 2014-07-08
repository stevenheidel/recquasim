function [P,rho] = P_success_DWave_master(H_i, H_f, Lind, T, iter)

% Calculate the probability of success for an adiabatic process
% using the method of analytic series expansion for the master equation

% N = number of quibits, e.g. N = 8
% Input is as follows (N and T and iter may be adjusted 
% but must ensure convergence):


% H_i = zero_time_Hamiltonian(N);
% H_f = random_Ising(N);
% (for N = 2;)
% L = make_Lindblad_operator(2);
% [P, rho] = P_success_DWave_master(H_i, H_f, .01*L, 3, 4000)

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

% initialize recurrence

rho_n_min_2 =  rho_0;
rho_n_min_1 = A*rho_0 - rho_0*A + T*Lindblad(Lind, rho_0);
rho = rho_n_min_1 + rho_n_min_2;

% recurrence

for n = 2:iter
    rho_n = (1/n)*(A*rho_n_min_1 - rho_n_min_1*A + ...
             B*rho_n_min_2 - rho_n_min_2*B + T*Lindblad(Lind, rho_n_min_1));
    rho_n = .5*(rho_n + rho_n); %to avoid random error desymmetrization     
    rho = rho + rho_n;
    %trace(rho)  
    rho_n_min_2 = rho_n_min_1;
    rho_n_min_1 = rho_n;
end
    
% when the ground state is degenerate probability of success measures how
% much of the density matrix falls into the ground state space

%P = trace(rho(ind,ind));
P = real(trace(rho(ind,ind))); % use real to suppress small imaginary part
    
% Copyright (c) Artur Sowa, December 2013    
    
    
    
    
    
    
