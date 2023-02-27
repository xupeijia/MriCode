clear
N = 64;Fs = 10;
t = (1:N)/Fs;
% x = 2*sin(2*pi*50*t + pi/3) + 3*cos(2*pi*30*t);
x = 2*cos(2*pi*t);
X = hilbert(x);
Y = fft(X);
phi = -pi/3;
Ycheck = abs(Y).*exp(1i*angle(Y) + 1i*phi);
y = ifft(Ycheck);
% phi = -pi/3;
% index = 1:numel(Y)/2+1;
% Y(index) = abs(Y(index)).*exp(1i*angle(Y(index)) + 1i*phi);
% index = numel(Y)/2+2:numel(Y);
% Y(index) = abs(Y(index)).*exp(1i*angle(Y(index)) - 1i*phi);
% ycheck = ifft(Y);

figure(1)
plot(x)
hold on
plot(real(y))
