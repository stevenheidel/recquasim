% Parameters

N = 10;
T = 20;
ninstal_min = 6;

N_points = 10;
pointsize = 10;

epsilon = eps(1);

% Experiment

H_i = InitialHamiltonian(N);

k = 1;
while k <= N_points
    [H_f, J, num_solutions] = RandomIsing(N);

    ninstal = ninstal_min;
    P = 1;
    while P >= 1
        P = P_distribute(H_i, H_f, T, ninstal, epsilon);
        ninstal = ninstal + 1;
    end

    scatter(P, ninstal, pointsize);
    % axis([0 1 0 2]);
    hold on; drawnow

    k = k + 1;
end    