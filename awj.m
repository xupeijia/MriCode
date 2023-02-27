%pr_act01
clc; clear; close all;

%加载文件
filename = 'act-001-time.txt';
dataset = importdata(filename);%此方式只加载数据，不加载开头的文字信息
x = dataset.data;

% [x,fs] = audioread('m_noise.wav');

%求导
x = deriva(x);

%采样频率
fs = 48000;

%wj计权
y = isofilwk(x(:,2),fs);
% y = isofilwj(x(:,2),fs);

%RMSend
arms = sqrt(var(y(1:end)));
arms1 = arms(y);

%求波峰因子
[m, p] = max(y);
crestFactor = abs(m/arms);


%MTVV
tvv = zeros(1,length(y) - fs); 
for i = 1:length(y)-fs
    tvv(i) = rms(y(i:fs+i-1));
end

mtvv = max(tvv);

%VDV
vdv = (trapz(x(:,1),y.^(4)))^(1/4);
vdv2 = (trapz(y.^(4)))^(1/4);

VL = 20*log10(arms/1e-5);

% %绘图
% figure(1)
% t = x(:,1);
% val = x(:,2);
% plot(t,val,'k');
% xlabel('时间/s');ylabel('加速度/m/s^2');
% title('原始数据');
% set(gcf,'color','w');
% 
% 
% figure(2)
% t = x(:,1);
% val = y(:,1);
% plot(t,val,'k');
% xlabel('时间/s');ylabel('加速度/m/s^2');
% title('计权数据');
% set(gcf,'color','w');