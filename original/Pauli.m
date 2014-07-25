function sigma = Pauli(n)

% Construct Puli matrices

if n==0              % sigma_0
    sigma = [1, 0; 0, 1];
elseif n == 1        % sigma_1 = sigma_x
    sigma = [0, 1; 1, 0]; 
elseif n ==2         % sigma_2 = sigma_y
    sigma = [0, -1i; 1i, 0]; 
elseif n ==3         % sigma_3 = sigma_z
    sigma = [1, 0; 0, -1]; 
end



% Copyright (c) Artur Sowa, December 2013  