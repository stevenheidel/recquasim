function Par_plotP_vs_Delta(N_points, N_delta, iter, pt_sz, T)

% plot point (Delta, P) colored by abs(J3) N_poins times
% rand Js
% Example
% Par_plotP_vs_Delta(1000000, 300, 300, 1, 5)


H_i = [0 -1 -1 0; -1 0 0 -1;-1 0 0 -1; 0 -1 -1 0];
pointsize = pt_sz;
Ps = zeros(1,N_points);
Deltas = zeros(1, N_points);
Js = zeros(1, N_points);

parfor  t = 1:N_points
  J = rand(1,3);
  J1 = J(1); J2 = J(2); J3 = J(3);
  Js(t) = abs(J3)/3;
  H_f = [J1+J2+J3 0 0 0; 0 -J1+J2-J3 0 0; 0 0 J1-J2-J3 0; 0 0 0 -J1-J2+J3];
  Deltas(t) = Delta_minimum(H_i,H_f, N_delta);
  Ps(t) = P_success(H_i, H_f, T, iter);
end

  scatter(Deltas, Ps, pointsize, Js);axis([0 2 0 1.15 ]);
  drawnow


    
% Copyright (c) Artur Sowa, November 2013   
    