clc; clear; close all;

% 加载文件
% filename = 'act-001-time.txt';
filename = 'Siemens-MAGNETOM-HEAD.txt';
% filename = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-HEAD.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-1.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-2.txt';
% filename = 'outer30.csv';
dataset = importdata(filename);%此方式只加载数据，不加载开头的文字信息
originalData = dataset.data;
t = originalData(:,1);
d = originalData(:,2);

% d = readmatrix(filename);

% 计算采样频率
fs = round(length(t)/(t(end)-t(1)));
% fs = 438;

% 求导
x = diff(d)/(1/fs);
% x2 = diff(x)/(1/fs);
% 
% % 计算频谱
[tt, yy] = ftf(d, fs);
% [tt2, yy2] = ftf(x, fs);
% [tt3, yy3] = ftf(x2, fs);
figure(1)
plot(tt, yy);
% figure(2)
% plot( tt2, yy2);
% figure(3)
% plot(tt3, yy3);

% legend('yy', 'yy2', 'yy3');


[v1, p1] = max(yy);
% [v2, p2] = max(yy2);
% [v3, p3] = max(yy3);