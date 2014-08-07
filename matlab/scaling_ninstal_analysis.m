% Start by loading the matrix
load('scaling_ninstal.mat', 'X');

% N = [];
% T = [];
% ninstal = [];

% for n = 1:20
%     for t = 1:20
%         N = [N n];
%         T = [T t];
%         ninstal = [ninstal X(n, t)];
%     end
% end

% scatter(N, T, ninstal)

figure

% for n=1:16
%     x_axis = 1:20;
%     y_axis = X(n, :);

%     [p,ErrorEst] = polyfit(x_axis, y_axis, 2);
%     p_fit = polyval(p,x_axis,ErrorEst);

%     subplot(4,4,n);
%     plot(x_axis,p_fit,'-',x_axis,y_axis,'+');
%     title(sprintf('N=%i', n);
% end

for t=1:20
    x_axis = 1:14;
    y_axis = X(:, t)'(1:14);

    [p,ErrorEst] = polyfit(x_axis, y_axis, 2);
    p_fit = polyval(p,x_axis,ErrorEst);

    subplot(5,4,t);
    plot(x_axis,p_fit,'-',x_axis,y_axis,'+');
    title(sprintf('T=%i', t));
end