clc; clear; close all;
% 读取Lp和Lv并计算LpAvg和LvAvg
inputfilename = 'SiemensData3.xlsx';
SheetNames = {'梯度线圈左侧-头颅', '梯度线圈上侧-头颅'; '梯度线圈左侧-脊柱', '梯度线圈上侧-脊柱'};
for i = 1:length(SheetNames)
    SheetName1 = SheetNames{i, 1};
    SheetName2 = SheetNames{i, 2};
    Lp1 = readmatrix(inputfilename, Sheet=SheetName1, Range='B2:Y2');
    Lp2 = readmatrix(inputfilename, Sheet=SheetName2, Range='B2:Y2');
    LpAvg12 = 10 * log10((10.^(0.1*Lp1)+10.^(0.1*Lp2))/2);

    Lp3 = readmatrix(inputfilename, Sheet=SheetName1, Range='B3:Y3');
    Lp4 = readmatrix(inputfilename, Sheet=SheetName2, Range='B3:Y3');
    LpAvg34 = 10 * log10((10.^(0.1*Lp3)+10.^(0.1*Lp4))/2);
    
    Lv1 = readmatrix(inputfilename, Sheet=SheetName1, Range='B5:Y5');
    Lv2 = readmatrix(inputfilename, Sheet=SheetName1, Range='B5:Y5');
    LvAvg12 = 10 * log10((10.^(0.1*Lv1)+10.^(0.1*Lv2))/2);

    Lv3 = readmatrix(inputfilename, Sheet=SheetName1, Range='B6:Y6');
    Lv4 = readmatrix(inputfilename, Sheet=SheetName2, Range='B6:Y6');
    LvAvg34 = 10 * log10((10.^(0.1*Lv3)+10.^(0.1*Lv4))/2);
    LpRate1234 = calRate(LpAvg12, LpAvg34);
    LvRate1234 = calRate(LvAvg12, LvAvg34);
    inputSheets = strsplit(SheetName1, '-');
    inputSheet = [inputSheets{2}, '序列'];
    writematrix([LpAvg12; LpAvg34; LpRate1234; LvAvg12; LvAvg34; LvRate1234], inputfilename, Sheet=inputSheet, Range='B2:Y7');
end
fpritnf('Finished')
