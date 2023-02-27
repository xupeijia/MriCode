function [f, y] = aft(x, Fs)
% 计算fft后的真实幅值
L = length(x);
Y = fft(x,L);
P2 = abs(Y/L);
y = P2(1:L/2+1);
y(2:end-1) = 2*y(2:end-1);
f = Fs*(0:L/2)/L;
end