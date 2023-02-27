% 按照1/3倍频程频带进行计算分析
clc; clear; close all;

% 加载数据
% filename = 'Siemens-MAGNETOM-HEAD.txt';
filename = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-HEAD.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-1.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-2.txt';

% filename = 'bed-shell-西门子-脊柱常规序列-病人实测-20220226.txt';
% filename1 = '梯度线圈左侧-头颅常规序列.txt';
% filename2 = '梯度线圈左侧-头颅静音序列.txt';

% filename1 = '梯度线圈上侧-头颅常规序列.txt';
% filename2 = '梯度线圈上侧-头颅静音序列.txt';

% filename1 = '梯度线圈左侧-脊柱常规序列.txt';
% filename2 = '梯度线圈左侧-脊柱静音序列.txt';

% filename1 = '梯度线圈上侧-脊柱常规序列.txt';
% filename2 = '梯度线圈上侧-脊柱静音序列.txt';

% filename1 = '梯度线圈左侧-盆腔常规序列.txt';
% filename2 = '梯度线圈左侧-盆腔静音序列.txt';

% filename1 = '梯度线圈左侧-膝关节常规序列.txt';
% filename2 = '梯度线圈左侧-膝关节静音序列.txt';

% filename = 'bed-shell-西门子-头部常规序列-MPRAGE-20220226.txt';
% filename = 'bed-shell-西门子-头部静音序列-PETRA-20220226.txt';

% filename = '头线圈左侧-头部常规序列-MPRAGE.txt';
% filename = '头线圈左侧-头部静音序列-PETRA.txt';

%导入数据
dataset = importdata(filename,'	',6);

% dataset = load('e_cont.mat');
% y = dataset.e_cont;
% t = dataset.t;
% x = [t, y'];
data = dataset.data;% 只加载数字部分
t = data(:,1);
x = data(:,2);
% 定义参数
% 采样率
fs = round(length(data)/(t(end) - t(1)));
% 速度基准
v0 = 5e-8;

% 计算功率谱密度
% window = lenght(x)/fs;
% noverlap = 0.33*window;
% nfft = window;
% [pxx,f] = pwelch(x,window,noverlap,NFFT,fs);

% 时域未计权
% yRms = rms(y);
% Laa = 20*log10(yRms/v0);

% 时域未计权分段dB
% nt = round(t(end));
% LvEverySec = zeros(1, nt);
% for i = 1 : nt
%     temp = y((i-1)*fs+1: i*fs);
%     tempRms = rms(temp);
%     LvEverySec(i) = 20*log10(tempRms/v0);
% end

% % 时域A计权
% ya = adsgn(y,fs);
% yyRms = rms(ya);
% Laaa = 20*log10(yyRms/v0);
% 
% % 时域A计权分段dB
% LvaEverySec = zeros(1, nt);
% for i = 1 : nt
%     temp = ya((i-1)*fs+1:i*fs);
%     tempRms = rms(temp);
%     LvaEverySec(i) = 20*log10(tempRms/v0);
% end

% % 分段dB出图
% figure(1)
% plot(LvEverySec);hold on;
% plot(LvaEverySec);hold off;


% 中心频段
% fc = [100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
% fc = [31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
fc = [50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000];
nc = length(fc);


% 计算各频带振级Lv
Lv = calOneThirdLv(x,fs,fc);
LvSum = 10*log10(sum((10.^(0.1*Lv))));
fprintf('LvSum：%.2fdB\n', LvSum);
% Lv = calOneThirdLv2(y,fs,fc);

ggg = (2:3:nc);
gg = fc(2:3:nc);

% 面积指数
r1 = 0.35;
r2 = 1.05;
s = pi*(r2*r2 - r1*r1);
% d = sqrt(s / pi);
% fd = fc*d;
s0 = 1;
logS = 10 * log10(s / s0);

% 辐射指数50Hz-10000Hz
logSigma = [-14 -11 -9 -7 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

% 环境指数
logEnv = 0;

% 计算各频带声功率级Lw
Lw = Lv + logSigma + logS + logEnv;
LwSum = 10*log10(sum((10.^(0.1*Lw))));
fprintf('LwSum：%.2fdB\n', LwSum);

% 按照A计权计算各频带加权振级Lwa
% wa = [-19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1.0 0.5 -0.1 -1.1 -2.5 -4.3 -6.6 -9.3];
% wa = [-39.4 -34.6 -30.2 -26.2 -22.5 -19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1.0 0.5 -0.1 -1.1 -2.5 -4.3 -6.6 -9.3];
wa = [-30.2 -26.2 -22.5 -19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1.0 0.5 -0.1 -1.1 -2.5];
Lwa = (Lw+wa);
LwaSum = 10*log10(sum((10.^(0.1*Lwa))));
fprintf('LwaSum：%.2fdB\n', LwaSum);

Lva = Lv + wa;
LvaSum  = 10*log10(sum((10.^(0.1*Lva))));
fprintf('LvaSum：%.2fdB\n', LvaSum);


% 输出结果
% figure(1)
% plot(t,y)
% xlabel('s');ylabel('m/s');
% title('时域图');
% set(gcf,'color','w');
% % 
% figure(2)
% [ff,yy]=ftf(y,fs);
% plot(ff,yy);
% xlabel('Hz');ylabel('幅值');
% title('频域图');
% set(gcf,'color','w');
% 
% figure(3);
% bar(Lv(1:end)); %绘制1/3倍频程Z振级图谱  1-400Hz直方图
% set(gca,'xtick',ggg);grid;
% set(gca,'xticklabel',gg); %横坐标
% xlabel('Hz');ylabel('dB');
% title('1/3倍频程振动速度级');
% set(gcf,'color','w');
% 
% figure(4);
% bar(Lw(1:end)); %绘制1/3倍频程Z振级图谱  1-400Hz直方图
% set(gca,'xtick',ggg);grid;
% set(gca,'xticklabel',gg); %横坐标
% xlabel('Hz');ylabel('dB');
% title('未计权1/3倍频程声功率级');
% set(gcf,'color','w');
% 
% figure(5);
% bar(Lwa(1:end)); %绘制1/3倍频程Z振级图谱  1-400Hz直方图
% set(gca,'xtick',ggg);grid;
% set(gca,'xticklabel',gg); %横坐标
% xlabel('Hz');ylabel('dB');
% title('A计权后1/3倍频程声功率级');
% set(gcf,'color','w');
