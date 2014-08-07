function psi_fin = Taylor_installment_vectorized(A, B, iter, psi_in, step)

% Calculate Taylor series of the solution of d psi/ds = (A+ sB)psi, 
% with the initial condition psi(0) = psi_in 
% at the point $s_fin$, specifically psi_fin = psi(s_fin)

% initialize recurrence

psi_n = zeros(length(psi_in), iter);
psi_n(:, 1) = psi_in;
psi_n(:, 2) = A*psi_in;

% recurrence

for n = 3:iter
    psi_n(:, n) = (1/(n-1)) * (A * psi_n(:, n-1) + B * psi_n(:, n-2));
end
    
psi_fin = sum(psi_n * step.^(0:iter-1)', 2);
    
% Copyright (c) Artur Sowa, December 2013