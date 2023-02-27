function [spReal, SPReal] = CalSurfaceSP2(x, Fs)
% 对输入信号进行希尔伯特变换再根据频率变换相位和各频率下的幅值
L = length(x);
% Hilbert Transform
X = hilbert(x);
Y = fft(X, L);
% y = ifft(Y);
% YReal=x
% YReal = real(y);
f = Fs*(0:L-1)/L;

Rho0 = 1.2;
C0 = 340;
K = 2*pi*f/C0;
K = K';
R1 = 0.35;
R2 = 1.05;
m1 = cos(K*R1)-cos(K*R2);
m2 = sin(K*R1)-sin(K*R2);
m = sqrt(m1.^2 + m2.^2);
theta = -atan(m2./m1);
theta(1) = 0;
SP = Rho0*C0*m.*abs(Y).*exp(1i*angle(Y)+1i*theta);
sp = ifft(SP);
% spReal：进行计算后的时域表面声压
spReal = real(sp);
% spReal：进行计算后的频域表面声压
SPReal = fft(spReal);
