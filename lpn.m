% 按照1/3倍频程频带进行计算分析
clc; clear; close all;

% 加载数据
% filename = 'Siemens-MAGNETOM-HEAD.txt';
% filename1 = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-HEAD.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-1.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-2.txt';

% filename = 'bed-shell-西门子-脊柱常规序列-病人实测-20220226.txt';
% filename1 = 'gradient-coil-left-西门子-头颅常规序列-20220526.txt';
% filename2 = 'gradient-coil-left-西门子-头颅静音序列-20220526.txt';
% filename1 = 'gradient-coil-up-西门子-头颅常规序列-20220526.txt';
% filename2 = 'gradient-coil-up-西门子-头颅静音序列-20220526.txt';
% filename = 'bed-shell-西门子-头部常规序列-MPRAGE-20220226.txt';
% filename = 'bed-shell-西门子-头部静音序列-PETRA-20220226.txt';
% filename = 'head-coil-left-西门子-头部常规序列-MPRAGE-20220226.txt';
% filename = 'head-coil-left-西门子-头部静音序列-PETRA-20220526.txt';
% filename1 = 'gradient-coil-left-西门子-盆腔常规序列-20220526.txt';
% filename2 = 'gradient-coil-left-西门子-盆腔静音序列-20220526.txt';
filename1 = 'gradient-coil-left-西门子-脊柱常规序列-20220526.txt';
filename2 = 'gradient-coil-left-西门子-脊柱静音序列-20220526.txt';
% filename = 'gradient-coil-left-西门子-膝关节常规序列-20220526.txt';
% filename = 'gradient-coil-left-西门子-膝关节静音序列-20220526.txt';
% filename = 'gradient-coil-up-西门子-脊柱常规序列-20220526.txt';
% filename = 'gradient-coil-up-西门子-脊柱静音序列-20220526.txt';
[data1, t1, x1] = readVibration(filename1, 6);
[data2, t2, x2] = readVibration(filename2, 6);

noyTableFile = 'noyTable.xlsx';
noyTable = readmatrix("noyTable.xlsx", 'Sheet', 'Sheet2', 'range', 'A1:X100');

% 采样率
fs = round(length(data1)/(t1(end) - t1(1)));
% 速度基准
v0 = 5e-8;
% 中心频段
fc = [50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000];
% fc = [31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000 12500 16000 20000];
nc = length(fc);
wa = [-30.2 -26.2 -22.5 -19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1.0 0.5 -0.1 -1.1 -2.5];
% wa = [-39.4 -34.6 -30.2 -26.2 -22.5 -19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1.0 0.5 -0.1 -1.1 -2.5 -4.3 -6.6 -9.3];
% 计算各频带振级Lv
Lv1 = calOneThirdLv(x1,fs,fc);
Lv2 = calOneThirdLv(x2,fs,fc);
% 环境指数
logEnv = 0;

% 声压级
Lp1 = Lv1 + logEnv;
Lp2 = Lv2 + logEnv;
LpSum1 = 10*log10(sum((10.^(0.1*Lp1))));
LpSum2 = 10*log10(sum((10.^(0.1*Lp2))));

% A计权声压级
Lpa1 = Lp1 + wa;
LpaSum1 = 10*log10(sum((10.^(0.1*Lpa1))));
Lpa2 = Lp2 + wa;
LpaSum2 = 10*log10(sum((10.^(0.1*Lpa2))));

% 克瑞特感觉噪度
Lpval1 = round(Lp1);
Lpval2 = round(Lp2);

noy1 = calNoy(Lpval1, nc, noyTable);
noy2 = calNoy(Lpval2, nc, noyTable);

[Lpn11, Lpn12, Lpn13] = calLpn(noy1, LpaSum1);
[Lpn21, Lpn22, Lpn23] = calLpn(noy2, LpaSum2);

% 打印结果
fprintf('LpSum\t\tLpaSum\t\tLpn1\t\tLpn2\t\tLpn3\n');
fprintf('%.2f dB\t%.2f dB\t%.2f dB\t%.2f dB\t%.2f dB\n',LpSum1, LpaSum1, Lpn11, Lpn12, Lpn13);
fprintf('%.2f dB\t%.2f dB\t%.2f dB\t%.2f dB\t%.2f dB\n',LpSum2, LpaSum2, Lpn21, Lpn22, Lpn23);

% 绘图
% ggg = (2:3:nc);
% gg = fc(2:3:nc);
ggg = (1:1:nc);
gg = fc(1:1:nc);

figure(1);
bar(ggg, [Lp1; Lp2], 1); %绘制1/3倍频程Z振级图谱
set(gca, 'Xlim', [0 25], 'XTick', ggg);
set(gca,'XTickLabel', gg, 'YGrid', 'on'); %横坐标
for i=1:nc  
    text(i-0.25, Lp1(i), num2str(roundn(Lp1(i), -1)), 'VerticalAlignment','bottom','HorizontalAlignment','center');
    text(i+0.25, Lp2(i), num2str(roundn(Lp2(i), -1)) , 'VerticalAlignment','bottom','HorizontalAlignment','center');
end
xlabel('频率（Hz）');ylabel('幅值（dB）');
title('1/3倍频程声压级');
legend('西门子-梯度线圈左侧-盆腔常规序列', '西门子-梯度线圈左侧-盆腔静音序列');
set(gcf,'color','w');

figure(2);
bar(ggg, [Lpa1; Lpa2], 1); %绘制1/3倍频程Z振级图谱
set(gca, 'Xlim', [0 25], 'XTick', ggg);
set(gca,'XTickLabel', gg, 'YGrid', 'on'); %横坐标
for i=1:nc  
    text(i-0.25, Lpa1(i), num2str(roundn(Lpa1(i), -1)), 'VerticalAlignment','bottom','HorizontalAlignment','center');
    text(i+0.25, Lpa2(i), num2str(roundn(Lpa2(i), -1)) , 'VerticalAlignment','bottom','HorizontalAlignment','center');
end
xlabel('频率（Hz）');ylabel('幅值（dB）');
title('1/3倍频程A计权声压级');
legend('西门子-梯度线圈左侧-盆腔常规序列', '西门子-梯度线圈左侧-盆腔静音序列');
set(gcf,'color','w');