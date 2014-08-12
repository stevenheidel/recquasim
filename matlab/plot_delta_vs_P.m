% Parameters

N = 2;
T = 5;
ninstal = 1;

N_points = 1000;
N_delta = 100;
pointsize = 10;

epsilon = eps(1);

% Experiment

H_i = InitialHamiltonian(N);

k = 1;
while k <= N_points
    [H_f, J, num_solutions] = RandomIsing(N);

    if num_solutions == 1
        delta = Delta_minimum(H_i, H_f, N_delta);
        P = P_distribute(H_i, H_f, T, ninstal, epsilon);

        if P < 1
            scatter(delta, P, pointsize, mean(diag(J)));
            axis([0 2 0 1]);
            hold on; drawnow

            k = k + 1;
        end
    end
end    