function [Lpa, LpaSum, Lpn1, Lpn2, Lpn3, Lwa, LwaSum] = NoiseEvaluate(Lp, Lv, nc, wa, noyTable)
% 环境指数
logEnv = 0;

% 面积指数
% s = 0.75*pi;
r1 = 0.35;
r2 = 1.05;
s = pi*(r2*r2 - r1*r1);
% d = sqrt(s / pi);
% fd = fc*d;
s0 = 1;
logS = 10 * log10(s / s0);

% 辐射指数
% logSigma = [-21 -17 -16 -13 -10 -8 -4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
% 50Hz-10000Hz
logSigma = [-14 -11 -9 -7 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

% 各频带声功率级Lw
Lw = Lv + logSigma + logS + logEnv;
% LwSum = 10*log10(sum((10.^(0.1*Lw))));

% 各频带A计权声功率级
Lwa = Lw + wa;
LwaSum = 10*log10(sum((10.^(0.1*Lwa))));

% 各频带A计权声压级
LpRound = round(Lp);
Lpa = Lp + wa;
LpaSum = 10*log10(sum((10.^(0.1*Lpa))));

% 克雷特感觉噪度
noyR = calNoy(LpRound, nc, noyTable);
[Lpn1, Lpn2, Lpn3] = calLpn(noyR, LpaSum);
end