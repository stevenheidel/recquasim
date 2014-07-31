#!/usr/bin/octave -qf

% Optimized

% Parameters
N = str2num(argv(){1});
T = 3;
iter = 1000;
ninstal = 3;

% Sparse Hamiltonians
tic;
H_i = InitialHamiltonian(N);
toc
tic;
H_f = RandomIsing(N);
toc

% Get probability
tic;
[P, ~] = P_installments(H_i, H_f, T, iter, ninstal);
toc

% Print answer
P

% Timings / Memory (kbytes):
% 11 -    0:01.54 -   24208
% 12 -    0:02.35 -   28072
% 13 -    0:05.16 -   36348
% 14 -    0:10.04 -   53800
% 15 -    0:22.26 -   95116
% 16 -    1:01.48 -  173792
% 17 -    1:42.99 -  337056
% 18 -    4:05.15 -  666240
% 19 -   10:53.51 - 1374064
% 20 -   19:53.06 - 2809660