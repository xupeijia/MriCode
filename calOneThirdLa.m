% 计算三分之一倍频程振动加速度级方法1
function La = calOneThirdLa(y,fs,fc,a0)

%核心代码
nc = length(fc);
n = length(y);
% nfft = 2^nextpow2(n);
nfft = n;
a = fft(y,nfft);
oc6 = 2^(1/6);
yc = zeros(1,nc); 
La = zeros(1,nc);
for i = 1:nc
    fl = fc(i)/oc6;
    fu = fc(i)*oc6;
    nl = round(fl*nfft/fs+1);
    nu = round(fu*nfft/fs+1);
    b = zeros(1,nfft);
    b(nl:nu) = a(nl:nu);
    b(nfft-nu+2:nfft-nl+2) = a(nfft-nu+2:nfft-nl+2);
    c = real(ifft(b,nfft));
    yc(i) = sqrt(var(c(1 : n)));
    La(i) = 20*log10(yc(i)/a0);
end