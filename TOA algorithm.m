clc; clear; close;
shading flat;
grid on;
% Position of base stations
a = 5;
b = 5;
% Motion track
t = linspace(0,100,1000);
% helix track
% x = sin(t);
% y = cos(t);
% z = t;
% Parabola track
x = t;
y = t;
z = t.^2;
plot3(x, y, z, 'b');
hold on;
% Variance of position
d = 0.5;      
r = zeros(4, 1000);
for k = 1:1:1000
    r(1, k) = (x(k) - a)^2 + (y(k) + b)^2 + z(k)^2;
    r(2, k) = (x(k) - a)^2 + (y(k) - b)^2 + z(k)^2;
    r(3, k) = (x(k) + a)^2 + (y(k) + b)^2 + z(k)^2;
    r(4, k) = (x(k) + a)^2 + (y(k) - b)^2 + z(k)^2;
end
% Gaussian noise
r = r + d * randn(4, 1000);
x_obs = zeros(1, 1000);
y_obs = zeros(1, 1000);
z_obs = zeros(1, 1000);
for k = 1:1:1000
    x_obs(k) = ((r(3, k) - r(1, k)) + r(4, k) - r(2, k)) / (8*a);
    y_obs(k) = ((r(1, k) - r(2, k)) + (r(3, k) - r(4, k))) / (8*a);
    z_obs(k) = real((sqrt(r(1, k) - (x_obs(k) - a)^2 - (y_obs(k) + b)^2) + sqrt(r(2, k) - (x_obs(k) - a)^2 - (y_obs(k) - b)^2) + sqrt(r(3, k) - (x_obs(k) + a)^2 - (y_obs(k) + b)^2) + sqrt(r(4, k) - (x_obs(k) + a)^2 - (y_obs(k) - b)^2)) / 4);
end
plot3(x_obs, y_obs, z_obs, 'r');
title('实际位置-预测位置');
legend('实际位置', '预测位置');
% Error 
e = zeros(1, 1000);
d = zeros(1, 1000);
for k = 1:1:1000
   e(k) =  sqrt((x(k) - x_obs(k))^2 + (y(k) - y_obs(k))^2 + (z(k) - z_obs(k))^2);
   d(k) =  sqrt(x(k)^2 + y(k)^2 + z(k)^2);
end
figure;
subplot(221);
plot(d, e);
title('距离-位置误差');
subplot(222);
plot(d, abs(x-x_obs));
title('距离-x坐标误差');
subplot(223);
plot(d, abs(y-y_obs));
title('距离-y坐标误差');
subplot(224);
plot(d, abs(z-z_obs));
title('距离-z坐标误差');
