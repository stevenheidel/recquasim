function plotP_vs_Delta(N_points, N_delta, iter, pt_sz)

% plot point (Delta, P) colored by abs(J3) N_poins times
% rand Js
% Example
%N_points = 1000;
% N_delta = 100;
%iter = 100;
% pt_sz = 10;

H_i = [0 -1 -1 0; -1 0 0 -1;-1 0 0 -1; 0 -1 -1 0];
pointsize = pt_sz;

for  t = 1:N_points
  J = rand(1,3);
  J1 = J(1); J2 = J(2); J3 = J(3);
  H_f = [J1+J2+J3 0 0 0; 0 -J1+J2-J3 0 0; 0 0 J1-J2-J3 0; 0 0 0 -J1-J2+J3];
  Delta = Delta_minimum(H_i,H_f, N_delta);
  P = P_success(H_i, H_f, 5, iter);
  scatter(Delta, P, pointsize, abs(J3));axis([0 2 0 1.15 ]);hold on;
  drawnow
end



    
% Copyright (c) Artur Sowa, November 2013   
    