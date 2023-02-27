% 按照1/3倍频程频带进行计算分析
clc; clear; close all;

% 加载数据
% filename = 'Siemens-MAGNETOM-HEAD.txt';
% filename = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-HEAD.txt'; 
filename = 'GE-Verio-SZGNA-PIONEER-Waist-1-降采样.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-2.txt';
dataset = importdata(filename);%导入数据
oldX = dataset.data;% 只加载数字部分

% 定义参数
% 采样率
oldT = oldX(:,1);
oldY = oldX(:,2);
oldFs = round(length(oldX)/(oldT(end) - oldT(1)));
x = resample(oldX,20000,oldFs);

t = x(:,1);
y = x(:,2);
fs = round(length(x)/t(end)-t(1));
% 速度基准
v0 = 5e-8;

% 输出结果
figure(1)
plot(t,y)
xlabel('s');ylabel('m/s');
title('时域图');
set(gcf,'color','w');

figure(2)
[ff,yy]=ftf(y,fs);
plot(ff,yy)
xlabel('Hz');ylabel('幅值');
title('频域图');
set(gcf,'color','w');