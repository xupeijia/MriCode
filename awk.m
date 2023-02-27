%pr_act01
clc; clear; close all;

%loading data
filename = 'act-001-time.txt';
dataset = importdata(filename);%only data loaded
x = dataset.data;

%
tt = x(:,1);
da = x(:,2);

fs = 48000;
%derivative
xd = diff(da)/(1/fs);

%iso standard weighting
y = isofilwk(xd,fs);
% y = isofilwj(xd,fs);
% y = fifthOrderWk(xd,fs);
% y = secondOrderWk(xd,fs);
% y = thirdOrderWk(xd,fs);
% y = fourthOrderWk(xd,fs);

%RMSend
arms = rms(y);
VL = 20*log10(arms/1e-5);


%求波峰因子
[m, p] = max(y);
crestFactor = abs(m/arms);


%MTVV
% tvv = zeros(1,length(y) - fs); 
% for i = 1:length(y)-fs
%     tvv(i) = rms(y(i:fs+i-1));
% end

% mtvv = max(tvv);

%VDV
% tn=maketime(y,fs);
% vdv = (trapz(tn,y.^(4)))^(1/4);
% vdv2 = (trapz(y.^(4)))^(1/4);


%print and plot
% figure(1)
% plot(tt,da)
% xlabel('time/s');ylabel('velocity/m/s');
% title('OriginalVelocityData');
% set(gcf,'color','w');

figure(2)
plot(tt(2:end),xd);
xlabel('time/s');ylabel('acceleration/m/s^2');
title('OriginalAccelerationData');
set(gcf,'color','w');

% tn=maketime(y,fs);
% figure(3)
% plot(tn,y,'c');
% xlabel('time/s');ylabel('acceleration/m/s^2');
% title('WeightedData');
% set(gcf,'color','w');
% 
% [xf,xy] = ftf(xd,fs);
% [wf,wy] = ftf(y,fs);
% figure(4);
% plot(xf,xy);
% figure(5);
% plot(wf,wy,'c');

fc = [.4 .5 .63 .8 1 1.25 1.6 2 2.5 3.15 4 5 6.3 8 10 12.5 16 20 25 31.5 40 50 63 80 100];
[VL1,ggg,gg] = vl2(y,fs,fc);


figure(6);
bar(VL1(1:end)); %绘制1/3倍频程Z振级图谱  1-400Hz直方图
set(gca,'xtick',ggg);grid;
set(gca,'xticklabel',gg); %横坐标
xlabel('1/3倍频程中心频率/Hz');ylabel('振级/dB');
title('1/3倍频程Wk计权振级');
set(gcf,'color','w');

[VL2,ggg,gg] = vl2(xd,fs,fc);
figure(7);
bar(VL2(1:end),'c'); %绘制1/3倍频程Z振级图谱  1-400Hz直方图
set(gca,'xtick',ggg);grid;
set(gca,'xticklabel',gg); %横坐标
xlabel('1/3倍频程中心频率/Hz');ylabel('振级/dB');
title('未计权1/3倍频程振级');
set(gcf,'color','w');

VL1rms = rms(VL1);
VL2rms = rms(VL2);

tmp=[arms, VL, VL1rms, VL2rms];
disp('  arms    VL   VL1rms  VL2rms')
disp(tmp);
