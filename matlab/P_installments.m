function [P, psi] = P_installments(H_i, H_f, T, ninstal, epsilon)

% Calculate the probability of success for an adiabatic process
% using the method of analytic series expansion in ninstal steps

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
    psi_in = Taylor_installment_stopper(A, B, psi_in, step, epsilon);
    A = A + step*B;
end
psi = psi_in;
P = norm(psi(ind))^2;

end

function psi_fin = Taylor_installment_stopper(A, B, psi_in, step, tol)

% self-evaluating and self-stopping version of Taylor_installment
% Calculate Taylor series of the solution of d psi/ds = (A+ sB)psi, 
% with the initial condition psi(0) = psi_in 
% at the point $s_fin$, specifically psi_fin = psi(s_fin)

% initialize recurrence

psi_n_min_2 =  psi_in;
psi_n_min_1 = A*psi_in;
psi = psi_n_min_1*step + psi_n_min_2;

% recurrence
nrm_cor = 1;
n = 1;

while (nrm_cor > tol)
    n = n+1;
    psi_n = (1/n)*(A*psi_n_min_1 + B*psi_n_min_2);
    cor = psi_n*step^n;
    nrm_cor = norm(cor);
    psi = psi + cor; 
    psi_n_min_2 = psi_n_min_1;
    psi_n_min_1 = psi_n;
end

psi_fin = psi;

end
    
% Copyright (c) Artur Sowa, December 2013    