% Position of base stations
a = 0.5;
b = 0.5;
bs = [-a, -b; -a, b; a, -b; a, b];
% Motion curve
t = linspace(0,100,1000);
x = t;
y = 10 - t;
z = t.^2;
subplot(121);
plot3(x, y, z, 'b');
% Variance of position
d = 0.05;
r = zeros(4, 1000);
for k = 1:1:1000
    r(1) = (x(k) - a)^2 + (y(k) + b)^2 + z(k)^2;
    r(2) = (x(k) - a)^2 + (y(k) - b)^2 + z(k)^2;
    r(3) = (x(k) + a)^2 + (y(k) + b)^2 + z(k)^2;
    r(4) = (x(k) + a)^2 + (y(k) - b)^2 + z(k)^2;
end
% Gaussian noise
r = r + d^2 * randn(4, 1000);
x_obs = zeros(1000);
y_obs = zeros(1000);
z_obs = zeros(1000);
for k = 1:1:1000
    x_obs(k) = ((r(3, k) - r(1, k)) + r(4, k) - r(2, k))/(8*a);
    y_obs(k) = ((r(1, k) - r(2, k)) + (r(3, k) - r(4, k)))/(8*a);
    z_obs(k) = real((sqrt(r(1, k) - (x_obs(k) - a)^2 - (y_obs(k) + b)^2) + sqrt(r(2, k) - (x_obs(k) - a)^2 - (y_obs(k) - b)^2)  + sqrt(r(3, k) - (x_obs(k) + a)^2 - (y_obs(k) + b)^2) + sqrt(r(4, k) - (x_obs(k) + a)^2 - (y_obs(k) - b)^2)) / 4);
end
subplot(122);
plot3(x_obs, y_obs, z_obs, 'r--o');
