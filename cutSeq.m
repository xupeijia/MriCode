clc; clear; close all;

% 加载数据
% filename = 'Siemens-MAGNETOM-HEAD.txt';
% filename1 = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-HEAD.txt';
filename1 = 'GE-Verio-SZGNA-PIONEER-Waist-1.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-2.txt';

% filename1 = 'bed-shell-西门子-头部常规序列-MPRAGE-20220226.txt';
% filename2 = 'bed-shell-西门子-头部静音序列-PETRA-20220226.txt';
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

dataset1 = importdata(filename1,'	',5);%导入数据
% dataset2 = importdata(filename2,'	',6);%导入数据
x1 = dataset1.data;% 只加载数字部分
t1 = x1(:,1);
y1 = x1(:,2);
% x2 = dataset2.data;% 只加载数字部分
% t2 = x2(:,1);
% y2 = x2(:,2);

fs = round(length(x1)/(t1(end) - t1(1)));

% 梯度线圈上侧未cutSeq
t11 = t1(1:fs*140+1);
y11 = y1(1:fs*140+1);
writematrix([t11, y11], 'GE-T2-TSE-SAG.txt');

t12 = t1(fs*140+2:fs*295+2);
y12 = y1(fs*140+2:fs*295+2);
writematrix([t12, y12], 'GE-T1-TSE-SAG.txt');

t13 = t1(fs*295+3:fs*380+3);
y13 = y1(fs*295+3:fs*380+3);
writematrix([t13, y13], 'GE-T2-TSE-STIR-SAG.txt');

t14 = t1(fs*380+4:fs*470+4);
y14 = y1(fs*380+4:fs*470+4);
writematrix([t14, y14], 'GE-T2-TSE-TRA.txt');


t21 = t2(1:fs*120+1);
y21 = y2(1:fs*120+1);
writematrix([t21, y21], 'Siemens-T2-QTSE-SAG.txt');

t22 = t2(fs*120+2:fs*245+2);
y22 = y2(fs*120+2:fs*245+2);
writematrix([t22, y22], 'Siemens-T1-QTSE-SAG.txt');

t23 = t2(fs*245+3:fs*340+3);
y23 = y2(fs*245+3:fs*340+3);
writematrix([t23, y23], 'Siemens-T2-QTSE-STIR-SAG.txt');

t24 = t2(fs*340+4:fs*430+4);
y24 = y2(fs*340+4:fs*430+4);
writematrix([t24, y24], 'Siemens-T2-QTSE-TRA.txt');

% 梯度线圈左侧
% t11 = t1(1:fs*140+1);
% y11 = y1(1:fs*140+1);
% writematrix([t11, y11], 'GE-T2-TSE-SAG.txt');
% 
% t12 = t1(fs*140+2:fs*295+2);
% y12 = y1(fs*140+2:fs*295+2);
% writematrix([t12, y12], 'GE-T1-TSE-SAG.txt');
% 
% t13 = t1(fs*295+3:fs*380+3);
% y13 = y1(fs*295+3:fs*380+3);
% writematrix([t13, y13], 'GE-T2-TSE-STIR-SAG.txt');
% 
% t14 = t1(fs*380+4:fs*470+4);
% y14 = y1(fs*380+4:fs*470+4);
% writematrix([t14, y14], 'GE-T2-TSE-TRA.txt');


% t21 = t2(1:fs*120+1);
% y21 = y2(1:fs*120+1);
% writematrix([t21, y21], 'Siemens-T2-QTSE-SAG.txt');
% 
% t22 = t2(fs*120+2:fs*245+2);
% y22 = y2(fs*120+2:fs*245+2);
% writematrix([t22, y22], 'Siemens-T1-QTSE-SAG.txt');
% 
% t23 = t2(fs*245+3:fs*340+3);
% y23 = y2(fs*245+3:fs*340+3);
% writematrix([t23, y23], 'Siemens-T2-QTSE-STIR-SAG.txt');
% 
% t24 = t2(fs*340+4:fs*430+4);
% y24 = y2(fs*340+4:fs*430+4);
% writematrix([t24, y24], 'Siemens-T2-QTSE-TRA.txt');
