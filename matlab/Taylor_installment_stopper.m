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

n 
psi_fin = psi;
    
% Copyright (c) Artur Sowa, December 2013    