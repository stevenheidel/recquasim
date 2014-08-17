% Parameters

N_range = 2:7;
decimal_places = 5;

T = 3;
ninstal = 3;

processors = 8;
epsilon = eps(1);

for N = N_range
    total = 2 ^ (N * (N-1) / 2);

    H_i = InitialHamiltonian(N);

    tic;
    P = pararrayfun(processors, @(x) P_distribute(H_i, RandomIsing(N, x), T, ninstal, epsilon), 1:total);
    toc

    RP = floor(P * 10 ^ decimal_places) / (10 ^ decimal_places);

    printf('N=%i unique values: %i out of %i\n', N, length(unique(RP)), total);
end