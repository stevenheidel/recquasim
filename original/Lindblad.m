function rho_out = Lindblad(L, rho_in)

% computaiton of the Lindblad part of the master equation

M = L'*L;
rho_out = L*rho_in*L' -.5*M*rho_in - .5*rho_in*M;


% Copyright (c) Artur Sowa, December 2013    