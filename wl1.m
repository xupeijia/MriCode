% 按照1/3倍频程频带进行计算分析
clc; clear; close all;

% 加载数据
% filename = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
filename = 'Siemens-MAGNETOM-HEAD.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-HEAD.txt'; 
dataset = importdata(filename);%only data loaded
x = dataset.data;
t = x(:,1);
y = x(:,2);


% 采样率
fs = round(length(x)/(t(end) - t(1)));
% 中心频段
% fc = [100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
fc = [25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
nfc = length(fc);

% 计算各频带振级Lv
[Lv,ggg,gg] = calOneThirdLv(y,fs,fc);

% 辐射指数
fcd = (0.5*sqrt(3))*fc;
logDelta = [-24 -21 -17 -16 -13 -10 -8 -4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
% 面积指数
s = 0.75*pi;
s0 = 1;
logS = linspace(s/s0, s/s0, nfc);
% 环境指数
logEnv = 0;

% 计算各频带声功率级Lws
Lw = Lv + logDelta + logS + logEnv;

% 按照A计权计算各频带加权振级Lwa
% wa = [-19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1.0 0.5 -0.1 -1.1 -2.5 -4.3 -6.6 -9.3];
wa = [-44.7 -39.4 -34.6 -30.2 -26.2 -22.5 -19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1.0 0.5 -0.1 -1.1 -2.5 -4.3 -6.6 -9.3];
sum = 0.1*(Lw+wa);
Lwa = 10*log10(10.^(sum));

% 输出结果
figure(1)
plot(t,y)
xlabel('时间s');ylabel('速度m/s');
title('时域图');
set(gcf,'color','w');

figure(2)
[ff,yy]=ftf(y,fs);
plot(ff,yy)
xlabel('频率Hz');ylabel('速度m/s');
title('频域图');
set(gcf,'color','w');

figure(3);
bar(Lv(1:end)); %绘制1/3倍频程Z振级图谱  1-400Hz直方图
set(gca,'xtick',ggg);grid;
set(gca,'xticklabel',gg); %横坐标
xlabel('1/3倍频程中心频率/Hz');ylabel('振级/dB');
title('1/3倍频程振级');
set(gcf,'color','w');

figure(4);
bar(Lw(1:end)); %绘制1/3倍频程Z振级图谱  1-400Hz直方图
set(gca,'xtick',ggg);grid;
set(gca,'xticklabel',gg); %横坐标
xlabel('1/3倍频程中心频率/Hz');ylabel('振级/dB');
title('未计权1/3倍频程声功率级');
set(gcf,'color','w');

figure(5);
bar(Lwa(1:end)); %绘制1/3倍频程Z振级图谱  1-400Hz直方图
set(gca,'xtick',ggg);grid;
set(gca,'xticklabel',gg); %横坐标
xlabel('1/3倍频程中心频率/Hz');ylabel('振级/dB');
title('A计权后1/3倍频程声功率级');
set(gcf,'color','w');
