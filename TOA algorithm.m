clc; clear; close;
shading flat;
grid on;
N = 1000;
t0 = 0;
tn = 900;
% Position of base stations
a = 5;
b = 5;
% Motion track
t = linspace(t0,tn,N);
% helix track
% x = 100.* sin(t);
% y = 1000.* cos(t);
% z = 20 .* t .^2;
% Parabola track
x = -t + 100000;
y = t + 100000;
z = t.^2 + 100000;
plot3(x, y, z);
hold on;
% Variance of position
d = 0.5;
err = d * randn(4, N);
r = zeros(4, N);
for k = 1:1:N
    r(1, k) = (x(k) - a)^2 + (y(k) + b)^2 + z(k)^2;
    r(2, k) = (x(k) - a)^2 + (y(k) - b)^2 + z(k)^2;
    r(3, k) = (x(k) + a)^2 + (y(k) + b)^2 + z(k)^2;
    r(4, k) = (x(k) + a)^2 + (y(k) - b)^2 + z(k)^2;
end
% Gaussian noise
r = r + err;
x_obs = zeros(1, N);
y_obs = zeros(1, N);
z_obs = zeros(1, N);
for k = 1:1:N
    x_obs(k) = ((r(3, k) - r(1, k)) + r(4, k) - r(2, k)) / (8*a);
    y_obs(k) = ((r(1, k) - r(2, k)) + (r(3, k) - r(4, k))) / (8*a);
    z_obs(k) = real((sqrt(r(1, k) - (x_obs(k) - a)^2 - (y_obs(k) + b)^2) + sqrt(r(2, k) - (x_obs(k) - a)^2 - (y_obs(k) - b)^2) + sqrt(r(3, k) - (x_obs(k) + a)^2 - (y_obs(k) + b)^2) + sqrt(r(4, k) - (x_obs(k) + a)^2 - (y_obs(k) - b)^2)) / 4);
end
plot3(x_obs, y_obs, z_obs);
title('实际位置-预测位置');
xlabel('观测时间');
ylabel('MSE');
% Error 
e = zeros(1, N);
d = zeros(1, N);
for k = 1:1:N
   e(k) =  sqrt((x(k) - x_obs(k))^2 + (y(k) - y_obs(k))^2 + (z(k) - z_obs(k))^2);
   d(k) =  sqrt(x(k)^2 + y(k)^2 + z(k)^2);
end
figure;
MSE = e./ d;
plot(t, MSE);
title('观测时间-相对误差');
figure;
histogram(e);
title('误差分布');
