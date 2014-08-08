% Start by loading the matrix
load('scaling_ninstal.mat', 'X');

n_range = 2:15;
t_range = 1:20;

N = [];
T = [];
ninstal = [];

for n = n_range
    for t = t_range
        N = [N; n];
        T = [T; t];
        ninstal = [ninstal; X(n, t)];
    end
end

% scatter(N, T, ninstal)

% addpath('./PolyfitnTools');

% p = polyfitn([N,T], ninstal, 2);
% p.ModelTerms
% p.Coefficients

%%%%%%%%%%%%%%%%%%%%%%%%

% figure
% coef = [];

% for n=n_range
%     x_axis = t_range;
%     y_axis = X(n, t_range);

%     [p,ErrorEst] = polyfit(x_axis, y_axis, 2);
%     coef = [coef; p];
%     p_fit = polyval(p,x_axis,ErrorEst);

%     subplot(4,5,n-1);
%     plot(x_axis,p_fit,'-',x_axis,y_axis,'+');
%     title(sprintf('N=%i', n));
%     xlabel('T');
%     ylabel('ninstal');
% end

% % figure
% % plot(coef)

% figure
% coef = [];

% for t=t_range
%     x_axis = n_range;
%     y_axis = X(n_range, t)' / t;

%     [p,ErrorEst] = polyfit(x_axis, y_axis, 2);
%     coef = [coef; p];
%     p_fit = polyval(p,x_axis,ErrorEst);

%     subplot(4,5,t);
%     plot(x_axis,p_fit,'-',x_axis,y_axis,'+');
%     title(sprintf('T=%i', t));
%     xlabel('N');
%     ylabel('ninstal');
% end

% figure
% plot(coef)