% 采样定理的验证
% By J.T.Feng 08/07/2019
% 
%
%

close; clc; clear;zoom on;    % 缩放打开
shading flat;   % 平滑

% Step.1 生成正弦波

w = 100; % 正弦信号频率
ws_1 = 3*w;  % 采样频率1,ws_1>=2w
ws_2 = w;  % 采样频率2,ws_2<2w
N = 256;
n = 0:N-1;
t_1 = n/ws_1;   % 采样序列ws_1
t_2 = n/ws_2;   % 采样序列ws_1
x_1 = sin(w*t_1);
x_2 = sin(w*t_2);

% Step.2 正弦波波形图绘制
figure(1);
subplot(231);
plot(t_1, x_1); % 作正弦波波形图
xlabel('时间/ s');
ylabel('幅值');
title('时域图');
grid;

% Step.3 FFT变换并绘制图像 ws_1>=2w
y_1 = fft(x_1,N);   % FFT
f_1 = (0:length(y_1)-1)'*ws_1/length(y_1);
subplot(232);
plot(f_1, abs(y_1));
axis([0,100,0,100]);
xlabel('频率/ rad^-1');
ylabel('幅值');
title('FFT 后的频域图(ws_1>=2w)');
grid;

% Step.4 FFT变换并绘制图像 ws_1<2w
y_2 = fft(x_2,N);   % FFT
f_2 = (0:length(y_2)-1)'*ws_2/length(y_2);
subplot(233);
plot(f_2, abs(y_2));
axis([0,100,0,100]);
xlabel('频率/ rad^-1');
ylabel('幅值');
title('FFT 后的频域图(ws_1<2w)');
grid;

% Step.5 IFFT ws_1>=2w
xifft_1 = ifft(y_1);
ti_1 = [0:length(xifft_1)-1] / ws_1;
subplot(234);
plot(ti_1,real(xifft_1));
xlabel('时间/ s');
ylabel('幅值');
title('IFFT 后的信号波形(ws>=2w)');
grid;

% Step.6 IFFT ws_1<2w
xifft_2 = ifft(y_2);
ti_2 = [0:length(xifft_2)-1] / ws_2;
subplot(235);
plot(ti_2,real(xifft_2));
axis([0,1,0,1]);
xlabel('时间/ s');
ylabel('幅值');
title('IFFT 后的信号波形(ws<2w)');
grid;

% Step.7 同坐标下的对比
subplot(236);
plot(t_1, x_1,ti_1,real(xifft_1),'r',ti_2,real(xifft_2),'g');
axis([0,1,0,1]);
xlabel('时间/ s');
ylabel('幅值');
title('同坐标系下原始图像与重构图像的对比');
grid;
