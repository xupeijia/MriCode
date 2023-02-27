function [f,y]=ftf(data,fs)
n=length(data);
% NFFT=2^nextpow2(n);
yo=(1/(2*pi))*fft(data);
if mod(n,2) == 1
    n = n+1;
end
f=fs/2*linspace(0,1,n/2);
y=2*abs(yo(1:n/2));
