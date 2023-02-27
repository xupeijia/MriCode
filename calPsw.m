clc; clear; close all;

% 加载数据
% filename = 'Siemens-MAGNETOM-HEAD.txt';
% filename = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-HEAD.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-1.txt';
filename = 'GE-Verio-SZGNA-PIONEER-Waist-2.txt';
dataset1 = importdata(filename,'	',6);%导入数据
% dataset = importdata(filename);%导入数据
x1 = dataset1.data;% 只加载数字部分
t1 = x1(:,1);
y1 = x1(:,2);

dataset2 = load('e_cont.mat');
y2 = dataset2.e_cont;
t2 = dataset2.t;
x2 = [t2, y2'];
% x = dataset.data;% 只加载数字部分
% t = x(:,1);
% y = x(:,2);
% 定义参数
% 采样率
fs = round(length(x2)/(t2(end) - t2(1)));

% window = length(x2)/fs;
window = 500;
noverlap = 165;
nfft = window;

[pxx1,f1] = pwelch(y1,window,noverlap,nfft,fs);
[pxx2,f2] = pwelch(y2',window,noverlap,nfft,fs);
psd1 = 10*log10(pxx1);
psd2 = 10*log10(pxx2);
plot(f1,psd1,f2,psd2);
% title('Siemens-HEAD');
% title('GE-MPR');
% title('GE-HEAD');
% title('GE-Waist-1');
title('GE-Waist-2');
xlabel('频率 (Hz)');
ylabel('功率谱密度 (dB/Hz)');
legend('噪声信号', '降噪后信号');