% Parameters

% Testing how ninstal scales with choice of T and N

runs_each = 100;
standard_of_convergence = 95;

N_range = 17;
T_range = 1:7;
ninstal_min = 1;
ninstal_max = 50;

processors = 2;
epsilon = eps(1);

% Experiment

load('scaling_ninstal.mat', 'X');

tic;
for N = N_range
    H_i = InitialHamiltonian(N);
    ninstal = ninstal_min;

    for T = T_range
        % Go back 1 in case got unlucky
        ninstal = max(1, ninstal-1);

        while ninstal < ninstal_max
            fprintf('Trying N=%i, T=%i with ninstal=%i\n', N, T, ninstal);
            P = pararrayfun(processors, @(x) P_distribute(H_i, RandomIsing(N), T, ninstal, epsilon)(1), 1:runs_each);

            num_converge = sum(P <= 1);
            if num_converge > standard_of_convergence
              X(N, T) = ninstal;
              save('scaling_ninstal.mat', 'X');

              break;
            end

            ninstal = ninstal + 1;
        end % while
    end % for T
end % for N
toc