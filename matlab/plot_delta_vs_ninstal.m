% Parameters

N = 4;
T = 36;
ninstal_min = 4;
ninstal_max = 6;

N_points = 10000;
N_delta = 100;
pointsize = 10;

epsilon = eps(1);

% Experiment

H_i = InitialHamiltonian(N);

deltas = cell(ninstal_max, 1);

k = 1;
while k <= N_points
    [H_f, J, num_solutions] = RandomIsing(N);

    if num_solutions == 1
        delta = Delta_minimum(H_i, H_f, N_delta);
        
        ninstal = ninstal_min-1;
        P = 1;
        while P >= 1
            ninstal = ninstal + 1;
            P = P_distribute(H_i, H_f, T, ninstal, epsilon);
        end

        if ninstal <= ninstal_max
            deltas{ninstal} = [deltas{ninstal}; delta];
            subplot(ninstal_max-ninstal_min+1, 1, ninstal-ninstal_min+1);
            title(sprintf('ninstal=%i', ninstal));
            xlabel('minimum gap delta');
            hist(deltas{ninstal}, 1/16:1/16:2-1/16);
        else
            fprintf('Found a %i\n', ninstal);
        end

        % scatter(delta, ninstal, pointsize);
        % axis([0 2 0 1]);
        hold on; drawnow

        k = k + 1;
    end
end    