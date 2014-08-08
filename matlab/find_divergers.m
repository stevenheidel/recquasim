% Parameters

runs = 100;
N = 5;
T = 20;
ninstal = 3;

N_delta = 100;

%processors = 8;
epsilon = eps(1);

% Experiment

H_i = InitialHamiltonian(N);

Js = zeros(N, N, runs);
P = zeros(runs, 1);

for k = 1:runs
    [H_f, Js(:,:,k)] = RandomIsing(N);
    P(k) = P_distribute(H_i, H_f, T, ninstal, epsilon);
end

num_divergers = sum(P > 1)
num_convergers = sum(P < 1);

divergers = Js(:, :, P>1);
convergers = Js(:, :, P<1);

% Analysis

diverger_deltas = zeros(num_divergers, 1);
for k = 1:num_divergers
    H_f = RandomIsing(N, divergers(:,:,k));
    diverger_deltas(k) = Delta_minimum(H_i, H_f, N_delta);
end

converger_deltas = zeros(num_convergers, 1);
for k = 1:num_convergers
    H_f = RandomIsing(N, convergers(:,:,k));
    converger_deltas(k) = Delta_minimum(H_i, H_f, N_delta);
end

mean(diverger_deltas)
mean(converger_deltas)