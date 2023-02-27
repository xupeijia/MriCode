function [t, x] = ReadAndCutVibration(filename, startLine)
%UNTITLED3 此处提供此函数的摘要
%   读取和裁剪振动信号，保证为整数秒的数据
dataset = importdata(filename,'	', startLine);
inputdata = dataset.data;
time = inputdata(:, 1);
n = length(inputdata);
Fs = round(n/(time(end) - time(1)));
T = floor(n/Fs);
L = T*Fs;
% 因为求导之后会少一个数，所以这里多去了一个点，以保证求导后的振动加速度点数为Fs整数倍
data = inputdata(1:L+1, :);
t = linspace(0, T+1/Fs, L+1);
x = data(:, 2);
end