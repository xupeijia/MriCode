function [Lv,Lw,Lwa] = calLvLwLwa(y,fs,fc,wa,nc)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
% 计算各频带振级Lv
Lv = calOneThirdLv(y,fs,fc);
% Lv = calOneThirdLv2(y,fs,fc);

% 辐射指数
% fcd = (0.5*sqrt(3))*fc;用fcd对应标准里的表格可得到logSigma
logSigma = [-21 -17 -16 -13 -10 -8 -4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
% 面积指数
s = 0.75*pi;
s0 = 1;
logS = linspace(s/s0, s/s0, nc);
% 环境指数
logEnv = 0;

% 计算各频带声功率级Lw
Lw = Lv + logDelta + logS + logEnv;

% 按照A计权计算各频带加权振级Lwa
% wa = [-19.1 -16.1 -13.4 -10.9 -8.6 -6.6 -4.8 -3.2 -1.9 -0.8 0 0.6 1.0 1.2 1.3 1.2 1.0 0.5 -0.1 -1.1 -2.5 -4.3 -6.6 -9.3];
Lwa = (Lw+wa);
end

