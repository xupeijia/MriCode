clc; clear; close all;
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
% [data1, t1, x1] = readVibration(filename1, 6);
% [data2, t2, x2] = readVibration(filename2, 6);

% 直接读取振动数据
SheetNames = {'梯度线圈左侧-盆腔', '梯度线圈左侧-膝关节', '头颅序列', '脊柱序列'};
inputfilename = 'SiemensData3.xlsx';
for i = 1:length(SheetNames)
    SheetName = SheetNames{i};
    Lp1 = readmatrix(inputfilename, Sheet=SheetName, Range='B2:Y2');
    Lp2 = readmatrix(inputfilename, Sheet=SheetName, Range='B3:Y3');
    
    Lv1 = readmatrix(inputfilename, Sheet=SheetName, Range='B5:Y5');
    Lv2 = readmatrix(inputfilename, Sheet=SheetName, Range='B6:Y6');
    
    noyTable = readmatrix('noyTable.xlsx', Sheet='Sheet2', Range= 'A1:X100');
    % pncTable = readmatrix('pncTable.xlsx', Sheet='Sheet1', Range='A1:J12');
    % nrTable = readmatrix('nrTable.xlsx', Sheet='Sheet1', Range='A1:J14');
    
    % 采样率
    % fs = round(length(data1)/(t1(end) - t1(1)));
    fs = 50000;
    
    % 中心频段
    fc = [50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 8000 10000];
    nc = length(fc);
    wa = [-30.2 -26.2 -22.5 -19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1.0 0.5 -0.1 -1.1 -2.5];
    
    % 计算（平均）速度级
    
    % 计算声压级、声功率级、感觉噪度级
    [Lpa1, LpaSum1, Lpn11, Lpn12, Lpn13, Lwa1, LwaSum1] = noiseEvaluate(Lp1, Lv1, nc, wa, noyTable);
    [Lpa2, LpaSum2, Lpn21, Lpn22, Lpn23, Lwa2, LwaSum2] = noiseEvaluate(Lp2, Lv2, nc, wa, noyTable);
    
    LpaRate = calRate(Lpa1, Lpa2);
    LwaRate = calRate(Lwa1, Lwa2);
    
    % 计算更加噪声标准PNC和噪声评价数NC
    % fc2 = [31.5 63 125 250 500 1000 2000 4000 8000];
%     LpForPncAndNr1 = calOneThirdLevel(x1, fs, fc2);
%     LpForPncAndNr2 = calOneThirdLevel(x2, fs, fc2);
    % pnc1 = calPnc(LpForPncAndNr1, fc2, pncTable);
    % pnc2 = calPnc(LpForPncAndNr2, fc2, pncTable);
    % nr1 = calNr1(LpForPncAndNr1, fc2, nrTable);
    % nr2 = calNr1(LpForPncAndNr2, fc2, nrTable);
    % [pncMax1, index11] = max(pnc1);
    % [pncMax2, index12] = max(pnc2);
    % [nrMax1, index21] = max(nr1);
    % [nrMax2, index22] = max(nr2);
    
    % 存入数据到Excel进行绘图
    writematrix([Lpa1; Lpa2; LpaRate; Lwa1; Lwa2; LwaRate], inputfilename, Sheet=SheetName, Range='B9:Y14');
    writematrix([LpaSum1; Lpn11; Lpn12; Lpn13; LwaSum1], inputfilename, Sheet=SheetName, Range='B16:B20');
    writematrix([LpaSum2; Lpn21; Lpn22; Lpn23; LwaSum2], inputfilename, Sheet=SheetName, Range='B22:B26');
end

% 打印
fprintf('Finished');
