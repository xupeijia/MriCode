clear
% 第second task二个任务是主动控制
% filename='newGE1.wav';
% [X,fs]=audioread(filename);
% filename = 'Siemens-MAGNETOM-HEAD.txt';
% filename = 'GE-SZNGA Premier-3D-AXT1-MPR.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-HEAD.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-1.txt';
% filename = 'GE-Verio-SZGNA-PIONEER-Waist-2.txt';
% dataset = importdata(filename,'	',6);%导入数据
filename = 'D:\Study\Projects\MRI\Data\Sequences\sample16k\Siemens-T2-TSE-TRA.csv';
sig = readmatrix(filename);%导入数据
% sig = dataset.data;% 只加载数字部分


