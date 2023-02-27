% Calculate Amplitude of X(t)
clear;
fs = 50000; % 采样频率为50000Hz
% N = 500000; % 采样点数为500000
% t = (0:N-1) / fs; % 生成时间序列
% 
% f1 = 1000; % 第一个频率分量为1000Hz
% f2 = 5000; % 第二个频率分量为5000Hz
% f3 = 1002;
% s = sin(2*pi*f1*t) + 0.5*sin(2*pi*f2*t) + 2*cos(2*pi*f3*t);% 生成信号
path = 'D:\Study\Projects\MRI\Data\Body\GE\sample50k\a\';
filelist = dir(strcat(path, '*.csv'));
filename = filelist(1).name;
data = readmatrix(strcat(path, filename));
t = data(:,1);
s = data(:,2);
N = length(s);

f1 = 0.4;
f2 = 100;
nyq = 0.5*fs;
[b1, a1] = butter(2, f1/nyq, 'high');
[b2, a2] = butter(2, f2/nyq, 'low');
y1 = filter(b1, a1, s);
s = filter(b2, a2, y1);

figure(3)
plot(t, s)

[f1, y1] = aft(s, fs);
win = hann(N);
s = s.*win;
[f2, y2]=aft(s,fs);

figure(1)
plot(f1, y1)

figure(2)
plot(f2,y2*2) 




