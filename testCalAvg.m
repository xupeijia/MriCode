clc; clear; close all;
% filename1 = '梯度线圈左侧-头颅常规序列.txt';
filename1 = '梯度线圈左侧-头颅静音序列.txt';

% filename2 = '梯度线圈上侧-头颅常规序列.txt';
filename2 = '梯度线圈上侧-头颅静音序列.txt';

[data1, t1, x1] = readVibration(filename1, 6);
[data2, t2, x2] = readVibration(filename2, 6);

fs = round(length(data1)/(t1(end) - t1(1)));
% 中心频段
fc = [50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000];

Lv1 = calOneThirdLv(x1, fs, fc);
Lv2 = calOneThirdLv(x2, fs, fc);
LvAvg = calLvAvg(x1, x2, fs, fc);

Lv1Sum = 10 * log10(sum(10.^(0.1*Lv1)));
Lv2Sum = 10 * log10(sum(10.^(0.1*Lv2)));
LvAvgSum1 = 10 * log10(sum(10.^(0.1*LvAvg)));
LvAvgSum2 = 10 * log10((10.^(0.1*Lv1Sum)+10.^(0.1*Lv2Sum))/2);
LvAvgSum3 = (Lv1Sum+Lv2Sum)/2;