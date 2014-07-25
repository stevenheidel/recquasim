function P = P_success(H_i, H_f, T, iter)

% Calculate the probability of success for an adiabatic process
% using the method of analytic series expansion

% Example of input:

% H_i = [0 -1 -1 0; -1 0 0 -1;-1 0 0 -1; 0 -1 -1 0];
% J1=1;J2=2.1;J3=.4; 
% H_f = [J1+J2+J3 0 0 0; 0 -J1+J2-J3 0 0; 0 0 J1-J2-J3 0; 0 0 0 -J1-J2+J3];
% T = 5;
% iter = 100

% Find the initial state -- the ground state of H_i

[V,~] =  eig(H_i);
psi_0 = V(:,1);   %always normalized and corresponding to the lowest eigenvalue (?)

% Find the desired final state -- the ground state of H_f

[V,~] =  eig(H_f);
psi_des = V(:,1);  

% simplify notation
A = -1i*T*H_i;
B = -1i*T*(H_f - H_i);

% initialize recurrence

psi_n_min_2 =  psi_0;
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
    
P =  abs(sum(psi_des'*psi))^2;

    
% Copyright (c) Artur Sowa, November 2013    
    
    
    
    
    
    
