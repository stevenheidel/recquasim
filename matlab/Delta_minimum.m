function Delta = Delta_minimum(H_i, H_f, N)

% finds the minimal gap for s in a mesh of N points in [0,1]

s = linspace(0,1,N);
Deltas = zeros(1,N);

for k = 1:N
    H_s = (1-s(k))*H_i + s(k)*H_f;
    E = eig(H_s);
    Deltas(k) = E(2) - E(1);
end

Delta = min(Deltas);

    
% Copyright (c) Artur Sowa, November 2013   