clc;
clear;
close all;
% base stations
a = 5; b = 5;
BS = [-a, -b, 0; -a, b, 0; a, -b, 0; a, b, 0];
BS_NUM = length(BS);
t0 = 0; tn = 10; N = 1000; % 10Hz
delta_T = (tn - t0) / N;
t = linspace(t0, tn, N);
X = zeros(3, N); % actual position
X_hat = zeros(3, N); % predict position
PHI = zeros(BS_NUM, N); % algel of arrival -- Pitch angle
THETA = zeros(BS_NUM, N); % algel of arrival -- Azimuth
% track
X(1, :) = 60 - 0.005 .* t.^2;
X(2, :) = -0.05 .* t + 70;
X(3, :) = -0.01 .* t + 70;
% angle information
for k = 1:N
   for M = 1:BS_NUM
    PHI(M, k) = atan((X(2, k) - BS(M, 2))/(X(1,k) - BS(M, 1)));
    THETA(M, k) = atan(sqrt((X(2, k) - BS(M, 2))^2 + (X(1, k) - BS(M, 1))^2)/(X(3, k) - BS(M, 3)));
   end
end
% add noise
D = 0.00005; % variance of noise
PHI = PHI + D * randn(BS_NUM, N);
THETA = THETA + D * rand(BS_NUM, N);
for k = 1: N
   X_hat(:, k) = AoALocate(BS, THETA(:, k), PHI(:, k));
end
RMSE = zeros(1, N);
for k = 1: N
   RMSE(k) = sqrt((X(1, k) - X_hat(1, k))^2 + (X(2, k) - X_hat(2, k))^2 + (X(3, k) - X_hat(3, k))^2)/sqrt(X(1, k)^2+X(2, k)^2+X(3, k)^2);
end
plot(t, RMSE, t, 5e-4*ones(1, N), 'linewidth', 2);
title('RMSE');
legend('实际RMSE', 'RMSE = 5e-4');
figure;
plot3(X(1, :), X(2, :), X(3, :), 'linewidth', 3);
hold on;
scatter3(X_hat(1, :), X_hat(2, :), X_hat(3, :),'filled');
legend('实际轨迹', '预测位置');
% xlim([0 60]); ylim([0 60]); zlim([0 60]);
% degree
degree = zeros(1, N);
for k = 1 : N
   degree(k) = 2*atan(a/sqrt(X(1, k)^2+X(2, k)^2+X(3, k)^2));
end
figure;
plot(t, degree, t, 0.0873*ones(1, N), 'linewidth', 2);
legend('实际角度', '短基线条件');