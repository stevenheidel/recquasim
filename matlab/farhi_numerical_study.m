% Parameters

runs = 50;
N_min = 7;
N_max = 15;

T_min = 0;
T_max = 20;
T_step = 0.01;

pointsize = 10;

epsilon = eps(1);

% Experiment

for N = N_min:N_max
    H_i = InitialHamiltonian(N);

    Ts = [];

    tic;

    for k = 1:runs
        H_f = RandomIsing(N);

        lo = T_min;
        hi = T_max;

        while hi - lo > T_step
            T = lo + (hi - lo) / 2;
            ninstal = 2 * ceil(T);

            P = P_distribute(H_i, H_f, T, ninstal, epsilon);

            if P < 0.12
                lo = T;
            elseif P > 0.13
                hi = T;
            else
                break;
            end
        end

        Ts(k) = T;
    end

    toc
    fflush(stdout);

    scatter(N, median(Ts), pointsize);
    axis([N_min N_max T_min T_max]);
    hold on; drawnow
end