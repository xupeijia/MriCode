% 计算三分之一倍频程振动速度级方法1
function Lv = calOneThirdLv(y,fs,fc)

%核心代码
v0 = 5e-8;
nc = length(fc); 
n = length(y);
nfft = 2^nextpow2(n);
a = fft(y,nfft);
oc6 = 2^(1/6);
yc = zeros(1,nc);
Lv = zeros(1,nc);
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
    Lv(i) = 20*log10(yc(i)/v0);
end

