function [t, y] = CutData(x, Fs)
%输入信号x，返回整数倍采样频率时间长度的信号y和对应的时间t
N = length(x);
T = floor(N/Fs);
L = T*Fs;
y = x(1:L);
t = linspace(0, T, L)';
end