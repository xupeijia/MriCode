% 按照1/3倍频程频带进行计算分析
clc; clear; close all;

% 加载数据
filename = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-HEAD.txt'; 
dataset = importdata(filename);%only data loaded
x = dataset.data;
t = x(:,1);
y1 = x(:,2);

fs = round(length(x)/(t(end) - t(1)));
[B, A] = adsgn(fs);
y = filter(B, A, y1);
% 计算各频带振级Lv
fc = [100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
fcd = (0.5*sqrt(3))*fc;
% wdelta = [-36 ]
[Lv,ggg,gg] = calOneThirdLv(y,fs,fc);
[Lvold,ggg,gg] = calOneThirdLv(y1, fs, fc);

% 计算各频带声功率级Lws
% Lws = Lv + Ls + Ldelta + Lc;

% 按照A计权计算各频带加权振级Lwva
% wa = [-19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1.0 0.5 -0.1 -1.1 -2.5 -4.3 -6.6 -9.3];
% sum = 0.1*(Lv+wa);
% Lwva = 10*log10(10.^(sum));

% 输出结果
figure(1)
plot(t,y)
xlabel('time/s');ylabel('velocity/m/s');
title('OriginalVelocityData');
set(gcf,'color','w');

figure(2);
bar(Lvold(1:end),'c'); %绘制1/3倍频程Z振级图谱  1-400Hz直方图
set(gca,'xtick',ggg);grid;
set(gca,'xticklabel',gg); %横坐标
xlabel('1/3倍频程中心频率/Hz');ylabel('振级/dB');
title('未计权1/3倍频程振级');
set(gcf,'color','w');

figure(3);
bar(Lv(1:end),'c'); %绘制1/3倍频程Z振级图谱  1-400Hz直方图
set(gca,'xtick',ggg);grid;
set(gca,'xticklabel',gg); %横坐标
xlabel('1/3倍频程中心频率/Hz');ylabel('振级/dB');
title('计权后1/3倍频程振级');
set(gcf,'color','w');