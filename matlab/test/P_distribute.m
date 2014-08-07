function [P, psi] = P_distributed(H_i, H_f, T, ninstal, epsilon)

% Calculate the probability of success for an adiabatic process
% using the method of analytic series expansion in ninstal steps

% Find the initial state -- the ground state of H_i

% In the special case of H_i = - sum sigma^x_k the ground state is known
% (numerical observation)

[m, ~] = size(H_i);
psi_0 = (1/sqrt(m))*ones(m,1);

% Find the desired final ground state SPACE of H_f (degenerate ground state)

h_f = diag(H_f); % H_f is diagonal so all eigenvecotrs are e_n where n \in ind
ind = (h_f == min(h_f)); % this is a sufficient description of the projector 
                         % -- see last lines of this code

% initialize variables
step = 1/ninstal;
psi_in = psi_0;

% run recurrence
for k = 1:ninstal
    psi_in = Taylor_installment_distributed(H_i, H_f, T, psi_in, step, epsilon, k);
end
psi = psi_in;
P = norm(psi(ind))^2;

end

function psi_fin = Taylor_installment_distributed(H_i, H_f, T, psi_in, step, tol, installment)

% self-evaluating and self-stopping version of Taylor_installment
% Calculate Taylor series of the solution of d psi/ds = (A+ sB)psi, 
% with the initial condition psi(0) = psi_in 
% at the point $s_fin$, specifically psi_fin = psi(s_fin)

% initialize recurrence

% A = A + step * B
% A + step_factor * step * B
% A + d * B
% c * H_i + d * (c * (H_f - H_i))
% c * H_i + d * c * H_f - d * c * H_i
% c * (H_i + d * H_f - d * H_i)
% H_i + d * H_f - d * H_i

c = -1i * T;
% The amount of (+ step * B) to add to A
step_factor = installment - 1;
d = step_factor * step;

i_by_psi_in = H_i * psi_in;
f_by_psi_in = H_f * psi_in;

psi_n_min_2 = psi_in;
psi_n_min_1 = c * ((1-d) * i_by_psi_in + d * f_by_psi_in);
psi = psi_n_min_1 * step + psi_n_min_2;

nrm_cor = 1;
n = 1;

i_by_min_2 = i_by_psi_in;
f_by_min_2 = f_by_psi_in;

while (nrm_cor > tol)
    n = n+1;

    % Calculation of H_i and H_f by the vectors just once
    i_by_min_1 = H_i * psi_n_min_1;
    f_by_min_1 = H_f * psi_n_min_1;

    % Calculation of A * psi_n_min_1
    %A_by_psi_n_min_1 = c * ((1-d) * i_by_min_1 + d * f_by_min_1);

    % Calculation of B * psi_n_min_2
    %B_by_psi_n_min_2 = c * (f_by_min_2 - i_by_min_2);

    % Normal calculation
    psi_n = (c/n)*((1-d) * i_by_min_1 + d * f_by_min_1 + f_by_min_2 - i_by_min_2);

    cor = psi_n*step^n;
    nrm_cor = norm(cor);
    psi = psi + cor;

    psi_n_min_2 = psi_n_min_1;
    psi_n_min_1 = psi_n;

    i_by_min_2 = i_by_min_1;
    f_by_min_2 = f_by_min_1;
end

psi_fin = psi;

end