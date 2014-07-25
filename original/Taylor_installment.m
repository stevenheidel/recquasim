function psi_fin = Taylor_installment(A, B, iter, psi_in, step)

% Calculate Taylor series of the solution of d psi/ds = (A+ sB)psi, 
% with the initial condition psi(0) = psi_in 
% at the point $s_fin$, specifically psi_fin = psi(s_fin)

% initialize recurrence

psi_n_min_2 =  psi_in;
psi_n_min_1 = A*psi_in;
psi = psi_n_min_1*step + psi_n_min_2;

% recurrence

for n = 2:iter
    psi_n = (1/n)*(A*psi_n_min_1 + B*psi_n_min_2);
    psi = psi + psi_n*step^n; 
    psi_n_min_2 = psi_n_min_1;
    psi_n_min_1 = psi_n;
end
    
psi_fin = psi;
    
% Copyright (c) Artur Sowa, December 2013    
    
    
    
    
    
    
