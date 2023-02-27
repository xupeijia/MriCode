% 计算三分之一倍频程振动速度级方法2
function Lv = calOneThirdLv2(y,fs,fc)

v0 = 5e-8;
nc = length(fc); 
% n = length(y);
Lv = zeros(1, nc);
yc = zeros(1, nc);
oc6 = 2^(1/6);
LvSum = 0;
for i = 1 : nc
    fl = fc(i)/oc6;
    fu = fc(i)*oc6;
    % 调用fdesign+design函数计算滤波器系数集合Hd
    d = fdesign.bandpass('N,F3DB1,F3DB2',8,fl,fu,fs);
    Hd = design(d);
    yOut = filter(Hd,y);
%     yc(i) = sum(yOut.^2)/n;
    yc(i) = rms(yOut);
    Lv(i) = 20*log10(yc(i)/v0);
    LvSum = LvSum + Lv(i);
end
LvAll = 20*log10(LvSum/v0);
fprintf('LvAll= %5.6fdB', LvAll);