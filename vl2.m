function [VL,ggg,gg] = vl2(y,fs,fc)
%核心代码
a0 = 10e-6;
nc = length(fc);
n = length(y);
nfft = 2^nextpow2(n);
a = fft(y,nfft);
oc6 = 2^(1/6);
yc = zeros(1,nc); 
VL = zeros(1,nc);
for j = 1:nc
    fl = fc(j)/oc6;
    fu = fc(j)*oc6;
    nl = round(fl*nfft/fs+1);
    nu = round(fu*nfft/fs+1);
    b = zeros(1,nfft);
    b(nl:nu) = a(nl:nu);
    b(nfft-nu+2:nfft-nl+2) = a(nfft-nu+2:nfft-nl+2);
    c = real(ifft(b,nfft));
    yc(j) = sqrt(var(c(1:n)));
    VL(j) = 20*log10(yc(j)/a0);
end

ggg = (2:3:nc);
gg = fc(2:3:nc);

