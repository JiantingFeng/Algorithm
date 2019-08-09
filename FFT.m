% �����������֤
% By J.T.Feng 08/07/2019
% 
%
%

close; clc; clear;zoom on;    % ���Ŵ�
shading flat;   % ƽ��

% Step.1 �������Ҳ�

w = 100; % �����ź�Ƶ��
ws_1 = 3*w;  % ����Ƶ��1,ws_1>=2w
ws_2 = w;  % ����Ƶ��2,ws_2<2w
N = 256;
n = 0:N-1;
t_1 = n/ws_1;   % ��������ws_1
t_2 = n/ws_2;   % ��������ws_1
x_1 = sin(w*t_1);
x_2 = sin(w*t_2);

% Step.2 ���Ҳ�����ͼ����
figure(1);
subplot(231);
plot(t_1, x_1); % �����Ҳ�����ͼ
xlabel('ʱ��/ s');
ylabel('��ֵ');
title('ʱ��ͼ');
grid;

% Step.3 FFT�任������ͼ�� ws_1>=2w
y_1 = fft(x_1,N);   % FFT
f_1 = (0:length(y_1)-1)'*ws_1/length(y_1);
subplot(232);
plot(f_1, abs(y_1));
axis([0,100,0,100]);
xlabel('Ƶ��/ rad^-1');
ylabel('��ֵ');
title('FFT ���Ƶ��ͼ(ws_1>=2w)');
grid;

% Step.4 FFT�任������ͼ�� ws_1<2w
y_2 = fft(x_2,N);   % FFT
f_2 = (0:length(y_2)-1)'*ws_2/length(y_2);
subplot(233);
plot(f_2, abs(y_2));
axis([0,100,0,100]);
xlabel('Ƶ��/ rad^-1');
ylabel('��ֵ');
title('FFT ���Ƶ��ͼ(ws_1<2w)');
grid;

% Step.5 IFFT ws_1>=2w
xifft_1 = ifft(y_1);
ti_1 = [0:length(xifft_1)-1] / ws_1;
subplot(234);
plot(ti_1,real(xifft_1));
xlabel('ʱ��/ s');
ylabel('��ֵ');
title('IFFT ����źŲ���(ws>=2w)');
grid;

% Step.6 IFFT ws_1<2w
xifft_2 = ifft(y_2);
ti_2 = [0:length(xifft_2)-1] / ws_2;
subplot(235);
plot(ti_2,real(xifft_2));
axis([0,1,0,1]);
xlabel('ʱ��/ s');
ylabel('��ֵ');
title('IFFT ����źŲ���(ws<2w)');
grid;

% Step.7 ͬ�����µĶԱ�
subplot(236);
plot(t_1, x_1,ti_1,real(xifft_1),'r',ti_2,real(xifft_2),'g');
axis([0,1,0,1]);
xlabel('ʱ��/ s');
ylabel('��ֵ');
title('ͬ����ϵ��ԭʼͼ�����ع�ͼ��ĶԱ�');
grid;
