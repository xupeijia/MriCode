function [aw, arms, cf, mtvv, mtvvDivideAw, vdv, vdvDivideAwAndT, Lwa, LwaSum] = VibrationEvaluate(t, a, fs, fc, weight)
%基准加速度
a0 = 10e-6;

% 计权处理
switch(weight)
    case 'wc' 
        aw = isofilwc(a, fs);
    case 'wd'
        aw = isofilwd(a, fs);
    case 'we'
        aw = isofilwe(a, fs);
    case 'wf'
        aw = isofilwf(a, fs);
    case 'wj'
        aw = isofilwj(a, fs);
    case 'wk'
        aw = isofilwk(a, fs);
end


% 计算加权后加速度RMS和振动加速度级
arms = rms(aw);
LwaSum = 20*log10(arms/a0);

% 1/3倍频程未计权振动加速级
% La = calOneThirdLa(a, fs, fc, a0);
% 1/3倍频程处理计权后振动加速度级
Lwa = calOneThirdLa(aw, fs, fc, a0);

%求波峰因子
[m, p] = max(aw);
cf = abs(m/arms);

%MTVV
% 根据《最大计权振级计算方法的探讨》所述增量方法计算MTVV，可有效缩短计算时间
% 设第一个点的运行均方根值为最大值
tvvIncrement = zeros(1, length(aw) - fs);
tvvIncrement(1) = rms(aw(1:fs));
for i = 2:length(aw)-fs
    tvvIncrement(i) = (tvvIncrement(i-1)^2 - (aw(i-1)^2)/fs + (aw(i-1+fs))^2/fs)^(1/2);
end
mtvv = max(tvvIncrement);
% 计算MTVV/aw是否>1.5
mtvvDivideAw = mtvv/arms;

% VDV 的定义式没有在四次根号中除以T 因此可以先除以T再乘以T从而用离散化的方式来解决
vdv = (sum(aw.^4)/length(aw))^(0.25)*t(end)^(0.25);
% 计算VDV/(aw*T^0.25)是否>1.75
vdvDivideAwAndT = vdv/(arms*t(end)^(0.25));
end