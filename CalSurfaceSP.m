function [spReal, SPReal] = CalSurfaceSP(x, Fs)

L = length(x);
Y = fft(x, L);
Y1 = Y(1:L/2+1);
f = Fs*(0:L/2)/L;

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
SP1 = Rho0*C0*m.*abs(Y1).*exp(1i*angle(Y1)+1i*theta);
SP2 = conj(SP1(end-1:-1:1));
SP = cat(1, SP1, SP2(1:end-1));
sp = ifft(SP);
% spReal：进行计算后的时域表面声压
spReal = real(sp);
% spReal：进行计算后的频域表面声压
SPReal = fft(spReal);
