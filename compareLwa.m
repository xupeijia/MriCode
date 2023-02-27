% filename = 'Siemens-MAGNETOM-HEAD.txt';
% filename = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-HEAD.txt';
filename = 'GE-Verio-SZGNA-PIONEER-Waist-1.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-2.txt';
dataset1 = importdata(filename,'	',6);%导入数据
% dataset = importdata(filename);%导入数据
x1 = dataset1.data;% 只加载数字部分
t1 = x1(:,1);
y1 = x1(:,2);

dataset2 = load('e_cont.mat');
y2 = dataset2.e_cont;
t2 = dataset2.t;
x2 = [t2, y2'];

fs = round(length(x2)/(t2(end) - t2(1)));
v0 = 5e-8;

fc = [31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
nc = length(fc);
Lv1 = calOneThirdLv(y1,fs,fc);
Lv2 = calOneThirdLv(y2,fs,fc);
% 坐标刻度
ggg = (2:3:nc);
gg = fc(2:3:nc);
% 辐射指数
fcd = (0.5*sqrt(3))*fc;
logDelta = [-21 -17 -16 -13 -10 -8 -4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
% 面积指数
s = 0.75*pi;
s0 = 1;
logS = linspace(s/s0, s/s0, nc);
% 环境指数
logEnv = 0;
Lw1 = Lv1 + logDelta + logS + logEnv;
Lw2 = Lv2 + logDelta + logS + logEnv;
% 计算A计权声功率级
wa = [-39.4 -34.6 -30.2 -26.2 -22.5 -19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1.0 0.5 -0.1 -1.1 -2.5 -4.3 -6.6 -9.3];
Lwa1 = (Lw1+wa);
Lwa2 = (Lw2+wa);
LwaSum1 = 10*log10(sum((10.^(0.1*Lwa1))));
LwaSum2 = 10*log10(sum((10.^(0.1*Lwa2))));
% 出图
figure(1);
hold on;
bar(Lwa1(1:end)); %绘制1/3倍频程Z振级图谱  1-400Hz直方图
bar(Lwa2(1:end));
set(gca,'xtick',ggg);grid;
set(gca,'xticklabel',gg); %横坐标
xlabel('Hz');ylabel('dB');
% title('Siemens-HEAD');
% title('GE-MPR');
% title('GE-HEAD');
title('GE-Waist-1');
% title('GE-Waist-2');
set(gcf,'color','w');
legend('原始噪声', '降噪后噪声');
hold off;