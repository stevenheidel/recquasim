function rho_fin = Taylor_master_installment(A, B, Lind, T, iter, rho_in, step)

% Calculate Taylor series of the solution of d rho/ds = (L_A+ s*L_B)[rho], 
% with the initial condition rho(0) = rho_in 
% at the point $s_fin$, specifically rho_fin = psi(rho_fin)


% initialize recurrence
rho_0 = rho_in;
rho_n_min_2 =  rho_0;
rho_n_min_1 = A*rho_0 - rho_0*A + T*Lindblad(Lind, rho_0);
rho = rho_n_min_1*step + rho_n_min_2;

% recurrence

for n = 2:iter
    rho_n = (1/n)*(A*rho_n_min_1 - rho_n_min_1*A + ...
             B*rho_n_min_2 - rho_n_min_2*B + T*Lindblad(Lind, rho_n_min_1));
    rho_n = .5*(rho_n + rho_n); %to avoid random error desymmetrization     
    rho = rho + rho_n*step^n; 
    rho_n_min_2 = rho_n_min_1;
    rho_n_min_1 = rho_n;
end
    
rho_fin = rho;
    
% Copyright (c) Artur Sowa, December 2013    
    
    
    
    
    
    
